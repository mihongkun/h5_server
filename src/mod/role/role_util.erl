%% 佣兵工具
%% 2018-5-2 laojiajie@gmail.com

-module(role_util).
-include("role.hrl").
-include("data_role.hrl").
-compile(export_all).


make_init_role(Sid,Uid,CfgID) ->
	RoleCfg = data_role:get(CfgID),
	#role{
		key           	= {Sid,Uid},	%% {Sid,Uid}
		cfg_id 	      	= CfgID,			%% 配置id
		star	      	= RoleCfg#cfg_role.star,				%% 星级
		lv     	      	= 1,				%% 等级
		quality 		= 0,				%% 品阶
		xtal 	  		= 0,				%% 水晶id
		xtal_attris 	= [],				%% 水晶属性
		power  		  	= 0,				%% 战力
		equips		  	= [],				%% 装备
		attri 		  	= #attri{}			%% 总属性
	}.



%% 获取下个佣兵世界ID
get_next_uid(Sid) ->
	get_next_uid_helper(Sid,lists:seq(1,1000)).

get_next_uid_helper(Sid,[Uid|Res]) ->
	case cache:lookup(role,{Sid,Uid}) of
		[] ->
			Uid;
		_ ->
			get_next_uid_helper(Sid,Res)
	end.


% 记录获取日志
log_role_add(Role=#role{key = {Sid,Uid},cfg_id = CfgID},OpType) ->
	logger:add(#log_role{
				sid          	= Sid,	%% 玩家ID
				world_id 		= Uid,	%% 世界ID
				cfg_id          = CfgID,	%% 佣兵配置ID
				opType			= OpType,	%% 操作类型
				opValue			= 1,	%% 操作参数
				opTime 			= util:unixtime()		%% 操作时间
			}).

% 记录删除日志
log_role_del(Role=#role{key = {Sid,Uid},cfg_id = CfgID},OpType) ->
	logger:add(#log_role{
				sid          	= Sid,	%% 玩家ID
				world_id 		= Uid,	%% 世界ID
				cfg_id          = CfgID,	%% 佣兵配置ID
				opType			= OpType,	%% 操作类型
				opValue			= -1,	%% 操作参数
				opTime 			= util:unixtime()		%% 操作时间
			}).


attri_type_to_ps_type(atk) 	-> ?ROLE_ATTRI_ATK;
attri_type_to_ps_type(def) 	-> ?ROLE_ATTRI_DEF;
attri_type_to_ps_type(hp) 	-> ?ROLE_ATTRI_HP;
attri_type_to_ps_type(speed) -> ?ROLE_ATTRI_SPEED;
attri_type_to_ps_type(angry) -> ?ROLE_ATTRI_ANGRY;
attri_type_to_ps_type(skill_hurt) -> ?ROLE_ATTRI_SKILL_HURT;
attri_type_to_ps_type(hit) -> ?ROLE_ATTRI_HIT;
attri_type_to_ps_type(dodge) -> ?ROLE_ATTRI_DODGE;
attri_type_to_ps_type(crit) -> ?ROLE_ATTRI_CRIT;
attri_type_to_ps_type(crit_hurt) -> ?ROLE_ATTRI_CRIT_HURT;
attri_type_to_ps_type(arp) -> ?ROLE_ATTRI_ARP;
attri_type_to_ps_type(bs) -> ?ROLE_ATTRI_BS;
attri_type_to_ps_type(stun_imm) -> ?ROLE_ATTRI_STUN_IMM;
attri_type_to_ps_type(hurt_imm) -> ?ROLE_ATTRI_HURT_IMM;
attri_type_to_ps_type(holy_hurt) -> ?ROLE_ATTRI_HOLY_HURT;
attri_type_to_ps_type(AttriType) -> 0.


cal_buy_cost(BuyTimes,PriceList,PriceAdd,MaxPrice)->
	NextTimes = BuyTimes + 1,
	Len = erlang:length(PriceList),
	case Len =< NextTimes of
		true ->
			lists:nth(NextTimes,PriceList);
		false ->
			erlang:min(MaxPrice,lists:nth(Len,PriceList) + PriceAdd*(NextTimes - Len))
	end.



