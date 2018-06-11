%% this file is auto maked!
-ifndef(__DATA_BATTLE_HRL__).
-define(__DATA_BATTLE_HRL__, true).

%% Z-战斗\战斗表-Battle.xlsx

-record(cfg_battle,{
		id        =  0,   % 战斗ID - 
		scene_id  = "",   % 场景ID - 调用场景路径
		mon_1     =  0,   % 1号位怪物ID - 调用怪物表
		mon_2     =  0,   % 2号位怪物ID - 调用怪物表
		mon_3     =  0,   % 3号位怪物ID - 调用怪物表
		mon_4     =  0,   % 4号位怪物ID - 调用怪物表
		mon_5     =  0,   % 5号位怪物ID - 调用怪物表
		mon_6     =  0,   % 6号位怪物ID - 调用怪物表
		max_round =  0,   % 战斗最大回合 - 通常情况下填15
		reward_id =  0    % 奖励ID - 调用奖励表
	}).

-endif.
