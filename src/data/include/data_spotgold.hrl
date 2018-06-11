%% this file is auto maked!
-ifndef(__DATA_SPOTGOLD_HRL__).
-define(__DATA_SPOTGOLD_HRL__, true).

%% D-点金功能\点金功能表.xlsx

-record(cfg_spotgold,{
		id              =  0,   % 序列 - 
		spot_gold       =  0,   % 普通点金 - 获得资源金币
		level_growth    =  0,   % 每级增长 - 战队等级每提升一级增加金币数量
		in_golg         =  0,   % 中级点金 - 获得资源金币
		consume_drill_1 =  0,   % 点金钻石消耗 - 中级点金钻石消耗
		high_golg       =  0,   % 高级点金 - 获得资源金币
		consume_drill_2 =  0,   % 点金钻石消耗 - 高级点金钻石消耗
		reset_time      =  0    % 重置时间 - 重置时间点金后开始计算，单位‘小时’
	}).

-endif.
