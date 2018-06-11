%% this file is auto maked!
-ifndef(__DATA_PUB_BASE_HRL__).
-define(__DATA_PUB_BASE_HRL__, true).

%% J-酒馆任务相关表\酒馆任务基础表.xlsx

-record(cfg_pub_base,{
		id                =  0,   % 序列 - 获取数据使用
		task_number       =  0,   % 任务数量 - 每日刷出的任务数量
		task_refresh_time =  0,   % 任务重置时间 - 每天实际时间
		ordinary_reel     =  0,   % 普通任务卷轴 - 普通任务卷轴消耗数量
		refresh_task      = "",   % 刷新任务 - 填写星级
		senior_reel       =  0,   % 高级任务卷轴 - 高级任务卷轴消耗数量
		refresh_task1     = "",   % 刷出任务 - 填写星级
		consume           =  0    % 刷新消耗 - 消耗钻石刷新
	}).

-endif.
