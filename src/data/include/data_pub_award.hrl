%% this file is auto maked!
-ifndef(__DATA_PUB_AWARD_HRL__).
-define(__DATA_PUB_AWARD_HRL__, true).

%% J-酒馆任务相关表\任务星级奖励表.xlsx

-record(cfg_pub_award,{
		id      =  0,   % 序列 - 
		star_lv =  0,   % 任务星级 - 
		reward  =  0,   % 奖励类型 - 填写道具表ID
		min     =  0,   % 奖励最小值 - 
		max     =  0,   % 奖励最大值 - 
		weight  =  0    % 权重 - 
	}).

-endif.
