%% this file is auto maked!
-ifndef(__DATA_PUB_STAR_HRL__).
-define(__DATA_PUB_STAR_HRL__, true).

%% J-酒馆任务相关表\酒馆任务星级表.xlsx

-record(cfg_pub_star,{
		id             =  0,   % 序列 - 
		star_lv        =  0,   % 星级 - 1-7星
		star_condition =  0,   % 星级要求 - 英雄星级要求，填0则没有要求
		hero_number    =  0,   % 英雄数量 - 所需英雄数量
		con_number     =  0,   % 任务条件数量 - 完成这个任务需要满足几个条件（不包含星级要求）
		task_time      =  0,   % 任务时间 - 完成对应星级任务所需时长（单位：小时）
		acc_cost       =  0,   % 加速 需要的钻石个数 - 
		weight         =  0    % 星级权重 - 
	}).

-endif.
