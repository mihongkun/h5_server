%%点金模块

-module(mod_spotgold).
-include("common.hrl").
-include("sys_macro.hrl").
-include("spotgold.hrl").
-include("PT_spotgold.hrl").
-include("data_spotgold.hrl").
-compile(export_all).

-export([
	login/3 %login
	]).

%%登录
login(Sid,Pid,Socket)->
	put(sid,Sid),
	put(socket,Socket),
	?DBG(mod_spotgold,"login sid = ~p,pid = ~p",[Sid,Pid]),
	check_spot(Sid).

%查询各个类型点金时间  计算获得金币数量
check_spot(Sid)->
	case cache:lookup(spotgold,{Sid}) of 
		[]->
			init_spot(Sid);
		[Item] ->
			Item
	end.

%初始化点金
init_spot(Sid)->
	SpotCfg = data_spotgold:get(1),
	Refresh_time = util:unixtime() + SpotCfg#cfg_spotgold.reset_time*?SECONDS_PER_HOUR,
	cache:insert(#spotgold{
		sid = Sid, 				%sid, 玩家ID 
		refresh_time=Refresh_time, 		%刷新时间
		ordinary=1,     		%普通点金
		intermediate=1, 		%中级点金
		senior=1        		%高级点金
	}).

%使用点金 增加玩家金币
use_spot(Sid,SpotType)->
	[Spotgold] = cache:lookup(spotgold,{Sid}),
	Refresh_time = Spotgold#spotgold.refresh_time,
	Nowtime = util:unixtime(),
	case Nowtime-Refresh_time>0 of      %判断是否超过刷新时间  是则重置
		true->
			cache:update(#spotgold{
				sid=Sid, 				%sid, 玩家ID
				ordinary=1,     			%普通点金
				intermediate=1,
				senior=1
			})
	end,
	%增加玩家相对应的金币
	[SpotgoldList] = calculate_spotgold(Sid),%查询玩家金币

	[SpotgoldNew] = cache:lookup(spotgold,{Sid}),

	[Number1,Number2,Number3] = SpotgoldList,
	case SpotType of
		SpotType when SpotType==?SPOTGOLD_TYPE_ORDINARY ->   %判断点金类型
			if SpotgoldNew#spotgold.ordinary == 1 ->
				cache:update(#spotgold{
					sid=Sid, 				%sid, 玩家ID
					ordinary=0     			%普通点金
				}),
				mod_item:add(Sid,?gold,Number1,?OP_TYPE_SPORTGOLD_GOLD)
			end;
		SpotType when SpotType==?SPOTGOLD_TYPE_INTERMEDIATE ->
			if SpotgoldNew#spotgold.intermediate == 1 ->
				cache:update(#spotgold{
					sid=Sid,
					intermediate=0
				}),
				mod_item:add(Sid,?gold,Number2,?OP_TYPE_SPORTGOLD_GOLD)
			end;
		SpotType when SpotType==?SPOTGOLD_TYPE_SENIOR ->
		if SpotgoldNew#spotgold.senior == 1 ->
			cache:update(#spotgold{
				sid=Sid,
				senior=0
			}),
				mod_item:add(Sid,?gold,Number2,?OP_TYPE_SPORTGOLD_GOLD)
		end
	end.
	

%计算玩家点金的金币  获取战队等级    50000+战队等级*300 
calculate_spotgold(Sid)->
	SpotCfg = data_spotgold:get(1),
	Account = mod_account:get_level(Sid),
	Ordinary_gold = SpotCfg#cfg_spotgold.spot_gold+Account*SpotCfg#cfg_spotgold.level_growth,
	Intermediate_gold = Ordinary_gold*2,
	Senior_gold = Ordinary_gold*5,
	[Ordinary_gold,Intermediate_gold,Senior_gold].




