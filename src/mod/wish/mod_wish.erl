%% ============================================许愿池模块=========================================
%% 2018-05-28 mihongkun@gmail.com
%% 概念定义：
%%			 幸运币(幸运积分) -> 用于购买L币市场的物品
%% 			 许愿币 -> 用于许愿
%% 模块主要功能
%% 	高级许愿池 （需要玩家达到80级 or 需要 玩家是vip3级）
%%		不明确 （级数不够）
%%  普通许愿池 (需要玩家达到14级)
%%  	1. 购买许愿币
%%			根据购买的许愿币数量及许愿币的单价来计算消费钻石的数量
%%		2. 刷新
%%			@@@重点 每次刷新需要更新奖励列表 （根据）
%%				通过许愿池基础表
%%			a. 强制刷新
%%				系统强制在本次刷新之后多久进行刷新
%%							（实现方式 1. 全局定时任务 
%%									  2. 用户登陆的时候直接在后面检查要不要刷新
%%									  3. 用户在每次点击许愿池时检查要不要刷新）
%%			b. 用户刷新（区分用户的刷新方式可以放到每次点击许愿池）							
%%				1）. 花钻石来刷新 （直接根据配置中的价格进行刷新）（直接就成功没有提示玩家要消耗多少钻石）
%%				2）. 玩家免费手动刷新 
%%
%%		3. 中奖记录 
%%			（直接返回给前台 玩家昵称 和 奖项名称（如果前端可以通过奖项id得到奖项名称可以传奖项名称）以及获得的奖项的数量）
%%				NickName、RewardName、RewardNum -> 简化 -> nname、rname、rnum
%%		4. L币(Lucky币)市场 (不做提供)
%%			模仿市场的做法 -> todo
%%			a. 刷新 （付费用的是幸运币）
%%			b. 通过lucky币购买
%%		5. 帮助 -> 前端完全可以单独搞定（不作提供）
%%

-module (mod_wish).
-include ("log.hrl").
-include ("common.hrl").
-include ("wish.hrl").
-include ("pt_wish.hrl").
-include ("data_wish_normal.hrl").
-include ("data_wish_super.hrl").
-include ("data_wish_base.hrl").
-include ("sys_macro.hrl").

%% Sid 玩家id
-export ([
	wish/2,				%% 获取许愿池基础信息 Type -> 高级 or 普通
	pay/3,				%% 充值许愿币	Num -> 购买许愿币的数量
	logs/2,				%% 获取中奖列表 
	guest/3,			%% 用许愿池币抽奖 Type -> 高级 or 普通
	refresh_wish/2		%% 玩家手动刷新或强制刷新 Type -> 高级 or 普通
	]).

-compile(export_all).


%% 登陆处理
login(Sid,Pid,Socket)->
	put(sid,Sid),
	put(socket,Socket),
	?DBG(mod_wish,"login sid = ~p,pid = ~p",[Sid,Pid]),
	gen_server:cast(Pid,{login_load_mod_finish,?MODULE}).

wish(Sid,Type) ->
	case can_entry(Sid,Type) of 
		true -> 
			force_reset(Sid,Type),
			s2c_wish_info(Sid,Type);
		false -> s2c_can_not_entry(Sid,Type)
	end.

%% 检查用户是否符合进入许愿池的条件 Type -> 0 普通 ，1 高级
can_entry(Sid,Type) ->
	case get_player_level(Sid) >= get_level_limit(Type) orelse get_vip_limit(Type) =< get_vip_level(Sid) of
		true -> true;
		_ -> false
	end.

get_player_level(Sid) ->
	mod_account:get_level(Sid).

%% 获取玩家等级限制(开启)
get_level_limit(Type) ->
	E = get_wish(Type),
	E#cfg_wish_base.level.

%% 根据类型来查找字典表数据
get_wish(?WISH_NORMAL_TYPE) ->
	data_wish_base:get(?WISH_NORMAL_CFG_ID);
get_wish(?WISH_SUPER_TYPE) ->
	data_wish_base:get(?WISH_SUPER_CFG_ID);
get_wish(_) ->
	undefined.
%% 获取vip等级限制（开启）
get_vip_limit(Type) ->
	E = get_wish(Type),
	E#cfg_wish_base.vip.

%% 获取用户vip等级
get_vip_level(Sid) ->
	mod_account:get_vip(Sid).

 %% 强制刷新 触发时机为点击许愿图标的时候 不用定时可以减小服务器压力
force_reset(Sid,Type) ->
	case check_wish_time_out(Sid,?WISH_FORCE_RESET_TIME,Type) of 
		true ->
			Level = get_player_level(Sid),
			reset_wish_grids(Sid,Level,Type);
		false -> 
			ok
	end.

s2c_wish_info(Sid,Type) ->
	Info = get_wish_info(Sid,Type),	
	wish_util:send_wish(Sid,Info).

get_wish_info(Sid,Type) ->
	ok.


s2c_can_not_entry(Sid,?WISH_NORMAL_TYPE) ->
	proto:send_error(Sid,ok);
s2c_can_not_entry(Sid,?WISH_NORMAL_TYPE) ->
	proto:send_error(Sid,ok);
s2c_can_not_entry(_,_) -> 
	undefined.

reset_wish_grids(Sid,Level,Type) ->
	Grids = generate_grids(Type,Sid),
	case cache:lookup(Sid,wish) of  
		[] ->
			E = #wish{
				key = {Sid,Type},
				gs = Grids,
				fr = util:unixtime(),
				hr = util:unixtime()
			},
			cache:insert(E);
		[E] ->
			cache:update(E#wish{
					gs = Grids,
					fr = fr = util:unixtime(),
					hr = util:unixtime()
				})
	end.



% new_wish(Sid,?WISH_NORMAL_TYPE) -> 
% 	ok;
% new_wish(Sid,?WISH_SUPER_TYPE) -> 
% 	ok;
% new_wish(_,_) -> faild.


%% 充值许愿币 充值许愿币 -define(PAY_WISH_COIN,10000).
pay(Sid,Type,Num) ->
	%% 计算总消费钻石量
	Total = total_by_type(Type,Num), 
	%% 检查钻石是否充足 %% 不充足就返回钻石不足的提示%% 先减钻石
	case mod_economy:check_and_use(Sid,{diamond,Total},10000) of 
		{false,E} -> 
			proto:send_error(Sid,E);
		true -> 
			add_wish_coin(Sid,Type,Num),
			send_pay(Sid,Type)
	end.

send_pay(Sid,Type) ->
	WishNum = get_wish_coin(Sid,Type),
	wish_util:send_pay(Sid,WishNum,Type).

%% 获取玩家许愿币个数
get_wish_coin(Sid,Type) ->
	ID =  get_wish_coin_id(Type),
	mod_item:get_item_num(Sid,ID).


logs(Sid,Type) ->
	Logs = get_logs(),
	wish_util:send_logs(Sid,Logs#wish_log.logs,Type).

get_logs() ->
	case ets:lookup(?WISH_LOG_ONLY_ONE_ID,wish_log) of
		[] -> 
			Log = #wish_log{
					id = ?WISH_LOG_ONLY_ONE_ID,
					logs = []
			},
			ets:insert(Log),
			Log;
		[E] -> 
			E
	end.


% lucky(Sid) ->
% 	Lucky = get_lucky(Sid),
% 	wish_util:send_lucky(Sid,Lucky).

% get_lucky(Sid) ->
% 	case cache:lookup(Sid,lucky) of
% 		[] -> 
% 			ok;
% 		[E]	->
% 			E
% 	end.

guest(Sid,Type, Num) ->
	case can_guest(Sid,Type,Num) of
		true -> 
			Seq = lists:seq(1,Num),
			T = get_weight_total(Type),
			L = rand_guest(Seq,[],T,Sid,Type),
			LN=	get_cfg_lucky_num(Type),
			LuckyID = get_lucky_coin_id(),
			mod_item:add_item(LuckyID,LN * Num),
			add_logs(L,?WISH_MAX_LOG_NUM),
			wish_util:send_guest(Sid,L,Type);
		fasle ->
			ok
	end.

add_logs(Logs,N) ->
	D = get_logs(),
	OL = D#wish_log.logs,
	L = push_and_pop(D,OL,N),
	cache:update(D#wish_log{logs = L}).

%% 只保留N条中奖记录
push_and_pop([],Src,N) when erlang:length(Src) =< N ->
	Src;
push_and_pop(_,Src,N) when erlang:length(Src) > N ->
	LR = lists:reverse(Src), 
	[_|LH] = LR,
	T = lists:reverse(LH),
	push_and_pop([],T,N); 
push_and_pop(_,Src,N) when erlang:length(Src) =:= N ->
	Src;
push_and_pop(Dist,Src,N) ->
	push_and_pop([],Src ++ Dist,N).

% 获取抽奖一次获取的幸运币数量
get_cfg_lucky_num(Type) ->
	E = get_wish(Type),
	E#cfg_wish_base.produce.

get_weight_total(?WISH_NORMAL_TYPE) ->
	All = data_wish_normal:all(),
	guest_weight(fun(X,Y) -> X#cfg_wish_normal.weight + y end,0,All);
get_weight_total(?WISH_SUPER_TYPE) ->
	All = data_wish_super:all(),
	guest_weight(fun(X,Y) -> X#cfg_wish_super.weight + y end,0,All);
get_weight_total(_) -> 
	0.

guest_weight(_,Start,[]) -> Start;
guest_weight(F,Start,[H|T]) -> guest_weight(F,F(H,Start),T).


rand_guest([],L,_,Sid,Type) -> 
	L;
rand_guest(Seq,L,Total,Sid,Type) ->
	R = util:rand(1,Total),
	Grids = get_grids(Sid,Type),
	E = rand_grid_by_weight(),
	T = [E] ++ L, 
	[_|S] = Seq,
	rand_guest(S,T,Total,Sid,Type).

get_grids(Sid,Type) ->
	case cache:lookup({Sid,Type},wish) of
		[] ->
			Grids = generate_grids(Sid,Type),
			E = #wish{
				key  = {Sid,Type},
				gs = Grids,
				fr = util:unixtime(),
				hr = util:unixtime()
			},
			cache:insert(E),
			E;
		[E] -> E
	end.


rand_grid_by_weight() -> ok.
	



refresh_wish(Sid,Type) ->	
	case check_wish_time_out(Sid,?WISH_PLAYER_RESET_TIME,Type) of
		true ->
			insert_or_update_wish(Sid,Type);
		false ->
			Total = get_reset_cost(Type),
			case mod_economy:check_and_use(Sid,{diamond,Total},10000) of 
				{false,E} -> 
					proto:send_error(Sid,E);
				true -> 
					insert_or_update_wish(Sid,Type)
			end
	end.
get_reset_cost(Type) ->
	Cfg = get_wish(Type),
	Cfg#cfg_wish_base.reset.


% refresh_lucky(Sid) ->
% 	ok.

insert_or_update_wish(Sid,Type) ->
	Grids = generate_grids(Sid,Type),
	case cache:lookup({Sid,Type},wish) of
		[] ->
			cache:insert(#wish{
					key = {Sid,Type},
					gs = Grids,
					fr = util:unixtime(),
					hr = util:unixtime()
				});
		[E] ->
			cache:update(E#wish{
					gs = Grids,
					fr = util:unixtime(),
					hr = util:unixtime()
				})
	end,
	wish_util:send_refresh_wish(Sid,Type,Grids).


%% 添加或增加幸运币

%% 增加许愿币
add_wish_coin(Sid,?WISH_NORMAL_TYPE,Num) ->
	CfgID = get_wish_coin_id(?WISH_NORMAL_TYPE),
	mod_item:add_item(Sid,CfgID,Num);
add_wish_coin(Sid,?WISH_SUPER_TYPE,Num) ->
	CfgID = get_wish_coin_id(?WISH_SUPER_TYPE),
	mod_item:add_item(Sid,CfgID,Num);
add_wish_coin(_,_,_) -> faild.
			
%% 检查是否超出时间
check_wish_time_out(Sid,?WISH_FORCE_RESET_TIME,?WISH_NORMAL_TYPE) ->
	case util:unixtime() =< get_wish_reset_time(?WISH_FORCE_RESET_TIME) * ?SECONDS_PER_HOUR + get_last_refresh_time(Sid,?WISH_NORMAL_TYPE,?WISH_FORCE_RESET_TIME) of 
		true -> true;
		_ -> false
	end;

check_wish_time_out(Sid,?WISH_PLAYER_RESET_TIME,?WISH_NORMAL_TYPE) ->
	case util:unixtime() =< get_wish_reset_time(?WISH_PLAYER_RESET_TIME) * ?SECONDS_PER_HOUR + get_last_refresh_time(Sid,?WISH_NORMAL_TYPE,?WISH_PLAYER_RESET_TIME) of
		true -> true;
		_ -> false
	end;
check_wish_time_out(Sid,?WISH_FORCE_RESET_TIME,?WISH_SUPER_TYPE) ->
	case util:unixtime() =< get_wish_reset_time(?WISH_FORCE_RESET_TIME) * ?SECONDS_PER_HOUR +  get_last_refresh_time(Sid,?WISH_SUPER_TYPE,?WISH_FORCE_RESET_TIME)  of
		true -> true;
		_ -> false
	end;

check_wish_time_out(Sid,?WISH_PLAYER_RESET_TIME,?WISH_SUPER_TYPE) ->
	case util:unixtime() =< get_wish_reset_time(?WISH_PLAYER_RESET_TIME) * ?SECONDS_PER_HOUR + get_last_refresh_time(Sid,?WISH_SUPER_TYPE,?WISH_PLAYER_RESET_TIME)  of
		true -> true;
		_ -> false
	end.

get_last_refresh_time(Sid,Type,?WISH_FORCE_RESET_TIME) ->
	E = get_wish_data(Sid,Type),
	E#wish.fr;
get_last_refresh_time(Sid,Type,?WISH_PLAYER_RESET_TIME) ->
	E = get_wish_data(Sid,Type),
	E#wish.hr;
get_last_refresh_time(_,_,_) -> undefined.



%% =====================================================================================

%% 根据类型计算要用到多少钻石
total_by_type(Type,?WISH_NUM_CHOICE_ONE) ->
	Base = get_wish(Type),
	Base#cfg_wish_base.single;
%% 根据类型计算要用到多少钻石
total_by_type(Type,?WISH_NUM_CHOICE_TEN) ->
	Base = get_wish(Type),
	Base#cfg_wish_base.ten_times;
total_by_type(_,_) ->
	undefined.
	
%% 获取许愿池重置时间 Type -> 强制 or 手动免费
get_wish_reset_time(Type) ->
	Base = get_wish(Type),
	case Type of 
		?WISH_FORCE_RESET_TIME -> 
			Base#cfg_wish_base.force_reset;
		?WISH_PLAYER_RESET_TIME -> 
		 	Base#cfg_wish_base.reset_time
	end.


%% 能不能抽奖 Num次数
can_guest(Sid,Type,Num) ->
	get_wish_coin(Sid,Type) >= Num.

%% 获取许愿币id
get_wish_coin_id(Type) ->
	Base = get_wish(Type),
	Base#cfg_wish_base.wish_coin_id.

%% 获取幸运币id
get_lucky_coin_id() ->
	Base = get_wish(?WISH_SUPER_TYPE),
	Base#cfg_wish_base.lucky_coin_id.
	

% 生成一个许愿用到的格子
generate_grid(Seq,Sid,Type) ->
	Level = get_player_level(Sid),
	IT = get_grid_type(Type,Seq), % 物品类型
	{Order,Num} = get_grid_meta(Type,Seq,Level),
	get_grid_detail({IT,Order,Num}). % 物品详情 {item_id,num,times} item_id -> 物品id, num ->物品数量 ，times -> 物品被抽到的次数

% 获取盒子的具体内容
get_grid_detail(Meta) ->
	{Type,Order,Num} = Meta,
	Times = 0,
	CfgID = item_util:rand_item(),
	{CfgID,Num,Times}.

generate_grids(Sid,Type) ->
	[generate_grid(Seq,Sid,Type) || Seq <- lists:seq(1,?WISH_GRID_NUM)].

rand_normal_grids([],L,Total) -> ok;
rand_normal_grids(Seq,L,Total) -> ok.

%% 获取格子的物品类型 Type -> 0 普通 1 高级  Seq -> 序列编号 	
get_grid_type(?WISH_NORMAL_TYPE,Seq) ->
	E =  data_wish_normal:get(Seq),
	E#cfg_wish_normal.type;
get_grid_type(?WISH_SUPER_TYPE,Seq) ->
	E = data_wish_super:get(Seq),
	E#cfg_wish_super.type;
get_grid_type(_,_) -> undefined.
	
%% 获取物品品阶 和 数量区间值
get_grid_meta(?WISH_NORMAL_TYPE,Seq,Level) -> 
	get_normal_grid_meta(Seq,Level);
get_grid_meta(?WISH_SUPER_TYPE,Seq,Level) -> 
	get_super_grid_meta(Seq,Level);
get_grid_meta(_,_,_) -> undefined.
	
%% 获取普通许愿池奖励配置数据 Seq ->[1,2,3,4,5,6,7,8]
get_normal_cfg(Seq) -> 
	data_wish_normal:get(Seq).

%% 获取高级许愿池奖励配置数据 
get_super_cfg(Seq) ->
	data_wish_super:get(Seq).

%% 获取普通许愿池配置表中的物品品阶 和 数量区间值
get_normal_grid_meta(Seq,Level) -> %% 此部分注释是后面需要开启
	E = get_normal_cfg(Seq),
	if Level >= E#cfg_wish_normal.level_min1 andalso Level < E#cfg_wish_normal.level_max1 ->
		{E#cfg_wish_normal.item_order1,util:rand(E#cfg_wish_normal.min1,E#cfg_wish_normal.max1)};
		Level >= E#cfg_wish_normal.level_min2 andalso Level < E#cfg_wish_normal.level_max2 ->
		{E#cfg_wish_normal.item_order2,util:rand(E#cfg_wish_normal.min2,E#cfg_wish_normal.max2)};
		Level >= E#cfg_wish_normal.level_min3 andalso Level < E#cfg_wish_normal.level_max3 ->
		{E#cfg_wish_normal.item_order3,util:rand(E#cfg_wish_normal.min4,E#cfg_wish_normal.max4)};
		Level >= E#cfg_wish_normal.level_min4 andalso Level < E#cfg_wish_normal.level_max4 ->
		{E#cfg_wish_normal.item_order4,util:rand(E#cfg_wish_normal.min4,E#cfg_wish_normal.max4)}
	end.		

%% 获取高级许愿池配置表中的物品品阶 和 数量区间值
get_super_grid_meta(Seq,Level) ->
	E = get_super_cfg(Seq),
	case util:rand(?WISH_SUPER_MIN_SETION_NUM,?WISH_SUPER_MAX_SETION_NUM) of
		1 -> {E#cfg_wish_super.item_order1,util:rand(E#cfg_wish_normal.min1,E#cfg_wish_normal.max1)};
		2 -> {E#cfg_wish_super.item_order2,util:rand(E#cfg_wish_normal.min2,E#cfg_wish_normal.max2)};
		3 -> {E#cfg_wish_super.item_order3,util:rand(E#cfg_wish_normal.min3,E#cfg_wish_normal.max3)};
		_ -> undefined		
	end.
	
cfg_wish_normal(Cfg=#cfg_wish_normal{weight = Weight},Total,L) when Weight >= Total ->
	Cfg;
cfg_wish_normal(#cfg_wish_normal{weight = Weight},Total,[H,T]) ->
	cfg_wish_normal(H,Total - Weight,T).

%% 给定序列首尾组成的list,随机从这个序列中获取一个值
seq_rand([A]) -> 
	A;
seq_rand([A,B]) -> 
	util:rand(A,B);
seq_rand(L) -> 
	undefined.

% 从数据库中获取Wish数据
get_wish_data(Sid,Type) ->
	case cache:lookup({Sid,Type},wish) of
		[] -> 
			Grips = generate_grids(Sid,Type),
			Wish = #wish{
					key={Sid,Type},
					gs = Grips,
					fr = util:unixtime(),
					hr = util:unixtime()
				},
			cache:insert(Wish),
			Wish;
		[E] -> E
	end.
	