%% 佣兵模块
%% 2018-5-2 laojiajie@gmail.com

-module(mod_role).
-include("role.hrl").
-include("data_role_grid.hrl").
-include("data_role_uplv.hrl").
-include("data_role_quality.hrl").
-include("common.hrl").
-compile(export_all).

% 接口
-export([
		get_roles/1,	% 获取玩家所有佣兵
		add_roles/3,	% 增加佣兵 Sid,[{CfgID,Num}]/[CfgID],OpType -> true
		add_roles/4,	% 增加佣兵 Sid,CfgID,Num,OpType -> true
		delete_roles/3,	% 删除佣兵 Sid,[Uid],OpType -> true
		check_grid_enough/2,	% 检查佣兵格子数是否足够， Sid,Num -> true/false
		get_role/2		% 获取玩家指定世界ID的佣兵
	]).

% 客户端请求
-export([
		buy_grid/1, 		% 购买格子
		upgrade_role/2		% 升级英雄
	]).

%% 登陆处理
login(Sid,Pid,Socket)->
	put(sid,Sid),
	put(socket,Socket),
	?DBG(mod_role,"login sid = ~p,pid = ~p",[Sid,Pid]),
	send_grid_info(Sid),
	send_client_roles(Sid),
	send_call_info(Sid),
	gen_server:cast(Pid,{login_load_mod_finish,?MODULE}).




%% 获取所有佣兵
get_roles(Sid) ->	
	[role_math:build_role_attri(Role) || Role <- cache:lookup(role,Sid)].


%% 获取单个佣兵
get_role(Sid,Uid)->
	case cache:lookup(role,{Sid,Uid}) of
		[] ->
			undefined;
		[Role] ->
			role_math:build_role_attri(Role)
	end.

add_roles(Sid,CfgID,Num,OpType) ->
	Roles = add_roles_helper(Sid,[{CfgID,Num}],OpType,[]),
	send_update_roles(Sid,Roles).

add_roles(Sid,RoleList,OpType) ->
	Roles = add_roles_helper(Sid,RoleList,OpType,[]),
	send_update_roles(Sid,Roles).

add_roles_helper(Sid,[RoleID|Res],OpType,Roles) when erlang:is_integer(RoleID) ->
	add_roles_helper(Sid,[{RoleID,1}|Res],OpType,Roles);

add_roles_helper(Sid,[],OpType,Roles) ->
	Roles;
add_roles_helper(Sid,[{CfgID,Num}|Res],OpType,Roles) when Num =< 0 ->
	add_roles_helper(Sid,Res,OpType,Roles);
add_roles_helper(Sid,[{CfgID,Num}|Res],OpType,Roles) ->
	Uid = role_util:get_next_uid(Sid),
	Role = role_util:make_init_role(Sid,Uid,CfgID),
	cache:insert(Role),
	role_util:log_role_add(Role,OpType),
	add_roles_helper(Sid,[{CfgID,Num-1}|Res],OpType,[Role|Roles]).

delete_roles(Sid,Uids,OpType) ->
	delete_roles_helper(Sid,Uids,OpType),
	send_delete_roles(Sid,Uids).


delete_roles_helper(Sid,[Uid|Res],OpType) ->
	[Role] = cache:lookup(role,{Sid,Uid}),
	role_util:log_role_del(Role,OpType),
	cache:delete(role,{Sid,Uid}),
	delete_roles_helper(Sid,Res,OpType).



check_grid_enough(Sid,Num) ->
	CurSize = erlang:length(cache:lookup(role,Sid)),
	GridSize = get_grid_size(Sid),
	case GridSize >= CurSize + Num of
		true ->
			true;
		false ->
			proto:send_err(Sid,?TIPS_ROLE_GIRD_NOT_ENOUGH),
			false
	end.


get_grid_size(Sid) ->
	RoleElse = get_role_else(Sid),
	RoleGridCfg = data_role_grid:get(1),
	RoleGridCfg#cfg_role_grid.grid + RoleGridCfg#cfg_role_grid.buy_add*RoleElse#role_else.buy_grid_times.

get_grid_buy_cost(Sid) ->
	RoleElse = get_role_else(Sid),
	RoleGridCfg = data_role_grid:get(1),
	role_util:cal_buy_cost(RoleElse#role_else.buy_grid_times,RoleGridCfg#cfg_role_grid.buy_cost,RoleGridCfg#cfg_role_grid.buy_cost_add,RoleGridCfg#cfg_role_grid.buy_cost_max).



get_role_else(Sid) ->
	case cache:lookup(role_else,Sid) of
		[] ->
			RoleElse = #role_else{
						sid = Sid,  			%% 玩家id
					    free_time_1 = 0,  	%% 下次免费时间挫
					    free_time_2 = 0,  	%% 下次免费时间挫
					    free_time_3 = 0,  	%% 下次免费时间挫
					    free_time_4 = 0,  	%% 下次免费时间挫
					    buy_grid_times = 0	%% 格子的购买次数
			},
			cache:insert(RoleElse),
			RoleElse;
		[RoleElse] ->
			RoleElse
	end.


%%=============================================client req=======================================================
buy_grid(Sid) ->
	RoleElse = get_role_else(Sid),
	Cost = get_grid_buy_cost(Sid),
	case mod_item:use(Sid,?diamond,Cost,?OP_TYPE_ROLE_BUY_GRID) of
		true ->
			cache:update(RoleElse#role_else{buy_grid_times = RoleElse#role_else.buy_grid_times + 1}),
			send_grid_info(Sid);
		false ->
			void
	end.

upgrade_role(Sid,Uid) ->
	Role = get_role(Sid,Uid),
	MaxLv = role_math:get_lv_max(Role#role.star,Role#role.quality),
	LvCfg = data_role_uplv:get(Role#role.lv + 1),
	try
		?TRY(Role#role.lv < MaxLv),
		?TRY(mod_item:use(Sid,[{?gold,LvCfg#cfg_role_uplv.cost_gold},{?soul,LvCfg#cfg_role_uplv.cost_zh}],?OP_TYPE_ROLE_UPLV)),
		NewRole = role_math:build_role_attri(Role#role{lv = Role#role.lv + 1}),
		cache:update(NewRole),
		send_update_roles(Sid,[NewRole])
	catch throw:?break ->
		void
	end.

up_quality(Sid,Uid) ->
	Role = get_role(Sid,Uid),
	MaxLv = role_math:get_lv_max(Role#role.star,Role#role.quality),
	QuaCfg = data_role_uplv:get(Role#role.quality + 1),
	try
		?TRY(Role#role.lv >= MaxLv),
		?TRY(mod_item:use(Sid,[{?gold,QuaCfg#cfg_role_quality.cost_gold},{?jj_stone,QuaCfg#cfg_role_quality.cost_jjs}],?OP_TYPE_ROLE_UPQUALITY)),
		NewRole = role_math:build_role_attri(Role#role{lv = Role#role.lv + 1}),
		cache:update(NewRole),
		send_update_roles(Sid,[NewRole])
	catch throw:?break ->
		void
	end.

%%=============================================proto_send========================================================
%% 发送所有佣兵数据
send_client_roles(Sid) ->
	Roles = get_roles(Sid),
	pt_role:send(Sid,#pt_roles{
	    roles  = write_ps_roles(Roles)
	}).


%% 更新部分佣兵数据
send_update_roles(Sid,Roles) ->
	pt_role:send(Sid,#pt_roles_update{
	    roles  = write_ps_roles(Roles)
	}).

%% 删除佣兵通知
send_delete_roles(Sid,RoleIDs) ->
	pt_role:send(Sid,#pt_roles_delete{
	    roles  = RoleIDs
	}).

%% 推送/更新格子数
send_grid_info(Sid) ->
	GridSize = get_grid_size(Sid),
	RoleGridCfg = data_role_grid:get(1),
	Cost = get_grid_buy_cost(Sid),

	pt_role:send(Sid,#pt_role_grid_info{
	    grid      = GridSize, %% integer() 格子数
	    buy_cost  = Cost, %% integer() 下次购买的钻石价格
	    buy_add   = RoleGridCfg#cfg_role_grid.buy_add  %% integer() 下次购买的增加的格子数
	}).

% 推送/更新免费召唤的时间戳
send_call_info(Sid) ->
	RoleElse = get_role_else(Sid),

	pt_role:send(Sid,#pt_role_call_info{
	    free_ts1  = RoleElse#role_else.free_time_1, %% integer() 普通召唤下次免费时间戳,少于当前时间而且不等于0表示当前免费
	    free_ts2  = RoleElse#role_else.free_time_2, %% integer() 高级召唤下次免费时间戳,少于当前时间而且不等于0表示当前免费
	    free_ts3  = RoleElse#role_else.free_time_3  %% integer() 友情召唤下次免费时间戳,少于当前时间而且不等于0表示当前免费
	}).


write_ps_roles(Roles) ->
	[#ps_role{
	    uid          = Uid, %% integer() 世界ID
	    cfg_id       = CfgID, %% integer() 配置ID
	    lv           = Lv, %% integer() 等级
	    star         = Star, %% integer() 星级
	    quality      = Quality, %% integer() 品阶
	    equips       = Equips, %% list(ps_equips) 装备
	    attris       = write_ps_attri(Attri), %% list(ps_attris) 属性
	    power        = Power, %% integer() 战力
	    xtal_id      = Xtal, %% integer() 水晶ID
	    xtal_attris  = write_ps_attri_tuple(XtalAttris)  %% attris 水晶属性
		} || 
		#role{
			key           	= {Sid,Uid},	%% {Sid,Uid}
			cfg_id 	      	= CfgID,		%% 配置id
			star	      	= Star,		%% 星级
			lv     	      	= Lv,		%% 等级
			quality 		= Quality,		%% 品阶
			xtal 	  		= Xtal,		%% 水晶id
			xtal_attris 	= XtalAttris,		%% 水晶属性
			power  		  	= Power,		%% 战力
			equips		  	= Equips,		%% 装备
			attri 		  	= Attri 	%% 总属性
		} <- Roles].


write_ps_attri(Attri) ->
	[attri|Values] = tuple_to_list(Attri),
	Fields = record_info(fields,attri),
	write_ps_attri_helper(Fields,Values,[]).

write_ps_attri_helper([],[],PsList) ->
	PsList;
write_ps_attri_helper([Field|Fields],[Value|Values],PsList) when Value > 0 ->
	Type = role_util:attri_type_to_ps_type(Field),
	write_ps_attri_helper(Fields,Values,[#ps_attris{
	    type   = Type, %% integer() 属性类型
	    value  = Value  %% integer() 属性值
	}|PsList]);
write_ps_attri_helper([Field|Fields],[Value|Values],PsList) ->
	write_ps_attri_helper(Fields,Values,PsList).



write_ps_attri_tuple(Attris) ->
	[#ps_attris{
	    type   = Type, %% integer() 属性类型
	    value  = Value  %% integer() 属性值
	} || {Type,Value} <- Attris].



	