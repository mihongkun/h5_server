-ifndef (__PUB_HRL__).
-define (__PUB_HRL__, true).


-define (CFG_BASE_ID, 1). 						% 获取基础配置表的id
-define (TASK_REFRESH_MIN, 0). 					% 任务开始的分钟
-define (TASK_REFRESH_SEC, 0). 					% 任务开始的秒数





-record (pub, {
	sid 		= 0,		% 用户id
	taskid		= 0,		% 任务id
	nameid		= 0,		% 名字对应配置表中的id
	starid		= 0,		% 星级对对应配置表的id
	timestamp	= 0,		% 任务完成对应的时间戳
	itemid		= 0,		% 任务奖励对应的物品id
	itemnum		= 0,		% 任务奖励对应的物品数量
	lock		= 0,		% 任务锁状态 0 未锁定 1 已锁定
	state		= 0,		% 任务开始状态 0 未开始  1 已经开始
	cons		= 0			% 完成任务需要的条件id（对应随机条件配置表中的id）集合
	}).


-endif.







