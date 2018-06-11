%% 经济模块
%% 2018-5-2 laojiajie@gmail.com

-module(mod_economy).
-include("economy.hrl").
-include("sys_macro.hrl").

-compile(export_all).


%% 登陆处理
login(Sid,Pid,Socket)->
	put(sid,Sid),
	put(socket,Socket),
	?DBG(mod_economy,"login sid = ~p,pid = ~p",[Sid,Pid]),
	case cache:lookup(economy,Sid) of
		[] ->
			%% 不存在则先初始化
			init_economy(Sid);
		_ ->
			void
	end,
	send_economy(Sid),
	gen_server:cast(Pid,{login_load_mod_finish,?MODULE}).


init_economy(Sid) ->
    Gold = 10000,
    Diamond = 200,
    Power = 10,
    get_economy(Sid).


get_economy(Sid) ->
	case cache:lookup(economy,Sid) of
		[] ->
			NowMinute = util:unixtime() div (?SECONDS_PER_MINUTE*5),
			Economy = #economy{
                sid = Sid
            },
			cache:insert(Economy),
			Economy;
		[Economy] ->
			deal_power(Economy)		%% 处理体力
	end.



send_economy(Sid) ->
	Economy = get_economy(Sid),
	pt_economy:send(Sid,#pt_economy_info{
    diamond      = Economy#economy.diamond, %% integer() 钻石
    gold         = Economy#economy.gold, 	%% integer() 金币
    soul         = Economy#economy.soul, 	%% integer() 英魂
    water        = Economy#economy.water, 	%% integer() 水滴
    water_time   = Economy#economy.water_time, %% integer() 下次水滴恢复时间戳
    stamen       = Economy#economy.stamen, 	%% integer() 体力
    stamen_time  = Economy#economy.stamen_time, %% integer() 下次体力恢复时间戳
    narc         = Economy#economy.narc,	 %% integer() 紫水仙
    narc_time    = Economy#economy.narc_time %% integer() 下次紫水仙恢复时间戳
}).



deal_power(Economy) ->
	Economy.

write_log(Sid, Type, Cur, ChangeNum , OpType) ->
	logger:add(#log_economy{
			sid          	= Sid,			%% 玩家ID
			type          	= Type,			%% 经济类型
			num             = ChangeNum,	%% 变更数量
			total			= Cur,			%% 总数量
			opType			= OpType,		%% 操作类型
			opTime 			= util:unixtime()		%% 操作时间
	}).

	
check_by_item_id(Sid,CfgID,Num) ->
	Economy = get_economy(Sid),
	check_by_item_id_helper(Sid,CfgID,Num,Economy).

check_by_item_id_helper(Sid,?gold,Num,Economy) when Economy#economy.gold < Num ->
	proto:send_error(Sid,?TIPS_NOT_ENOUGH_GOLD),
	false;
check_by_item_id_helper(Sid,?diamond,Num,Economy) when Economy#economy.diamond < Num ->
	proto:send_error(Sid,?TIPS_NOT_ENOUGH_DIAMOND),
	false;
check_by_item_id_helper(Sid,?soul,Num,Economy) when Economy#economy.soul < Num ->
	proto:send_error(Sid,?TIPS_NOT_ENOUGH_SOUL),
	false;
check_by_item_id_helper(Sid,?water,Num,Economy) when Economy#economy.water < Num ->
	proto:send_error(Sid,?TIPS_NOT_ENOUGH_WATER),
	false;
check_by_item_id_helper(Sid,?stamen,Num,Economy) when Economy#economy.stamen < Num ->
	proto:send_error(Sid,?TIPS_NOT_ENOUGH_STAMEN),
	false;
check_by_item_id_helper(Sid,?narc,Num,Economy) when Economy#economy.narc < Num ->
	proto:send_error(Sid,?TIPS_NOT_ENOUGH_NARC),
	false;
check_by_item_id_helper(Sid,Type,Num,Economy) ->
	true.


use_by_item_id(Sid,?gold,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{gold = max(Economy#economy.gold - Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_gold_update{gold = NewEconomy#economy.gold}),
	write_log(Sid, ?ECONOMY_TYPE_GOLD, NewEconomy#economy.gold, - Num , OpType);

use_by_item_id(Sid,?diamond,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{diamond = max(Economy#economy.diamond - Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_diamond_update{diamond = NewEconomy#economy.diamond}),
	write_log(Sid, ?ECONOMY_TYPE_DIAMOND, NewEconomy#economy.diamond, - Num , OpType);

use_by_item_id(Sid,?soul,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{soul = max(Economy#economy.soul - Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_soul_update{soul = NewEconomy#economy.soul});

use_by_item_id(Sid,?water,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{water = max(Economy#economy.water - Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_water_update{water = NewEconomy#economy.water});

use_by_item_id(Sid,?stamen,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{stamen = max(Economy#economy.stamen - Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_stamen_update{stamen = NewEconomy#economy.stamen});

use_by_item_id(Sid,?narc,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{narc = max(Economy#economy.narc - Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_narc_update{narc = NewEconomy#economy.narc}).


add_by_item_id(Sid,?gold,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{gold = max(Economy#economy.gold + Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_gold_update{gold = NewEconomy#economy.gold}),
	write_log(Sid, ?ECONOMY_TYPE_GOLD, NewEconomy#economy.gold, + Num , OpType);

add_by_item_id(Sid,?diamond,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{diamond = max(Economy#economy.diamond + Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_diamond_update{diamond = NewEconomy#economy.diamond}),
	write_log(Sid, ?ECONOMY_TYPE_DIAMOND, NewEconomy#economy.diamond, + Num , OpType);

add_by_item_id(Sid,?soul,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{soul = max(Economy#economy.soul + Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_soul_update{soul = NewEconomy#economy.soul});

add_by_item_id(Sid,?water,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{water = max(Economy#economy.water + Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_water_update{water = NewEconomy#economy.water});

add_by_item_id(Sid,?stamen,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{stamen = max(Economy#economy.stamen + Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_stamen_update{stamen = NewEconomy#economy.stamen});

add_by_item_id(Sid,?narc,Num,OpType) ->
	Economy = get_economy(Sid),
	NewEconomy= Economy#economy{narc = max(Economy#economy.narc + Num,0)},
	cache:update(NewEconomy),
	pt_economy:send(Sid,#pt_narc_update{narc = NewEconomy#economy.narc}).
	

