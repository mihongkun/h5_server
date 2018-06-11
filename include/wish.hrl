%许愿池头文件
% 2018-5-28 mihongkun@gmail.com
-ifndef(__WISH_HRL__).
-define(__WISH_HRL__, true).

-define (WISH_NORMAL_CFG_ID,			1).		 % 许愿池基础表中对应普通许愿池ID
-define (WISH_SUPER_CFG_ID,			 	2).		 % 许愿池基础表中对应高级许愿池ID
-define (WISH_FORCE_RESET_TIME,			0).		 % 许愿池强制刷新时间
-define (WISH_PLAYER_RESET_TIME,		1).		 % 许愿池手动刷新时间
-define (WISH_NUM_CHOICE_ONE,			1).		 % 抽一次的次数
-define (WISH_NUM_CHOICE_TEN,			10).	 % 抽10次的次数
-define (WISH_NORMAL_TYPE,			 	0).		 % 普通许愿池类型
-define (WISH_SUPER_TYPE,			 	1).		 % 高级许愿池类型
-define (WISH_LOG_ONLY_ONE_ID,			1).		 % 唯一一条中奖纪录的ID
-define (WISH_GRID_NUM,					8).		 % 转轮格子的个数
-define (WISH_MAX_LOG_NUM,			 	10).	 % 许愿最大记录数
-define (WISH_SUPER_MIN_SETION_NUM,		1).		 % 高级许愿池最小区间值
-define (WISH_SUPER_MAX_SETION_NUM,		3).		 % 高级许愿池最大区间值


-define (LUCKY_ITEM_SELLED_Y, 1).		
-define (LUCKY_ITEM_SELLED_N, 0).		


%% 玩家普通许愿池信息表
-record (wish, {
	key 	= {0,0},	%% {Sid,Type} Sid -> 玩家ID, Type -> 许愿池类型	
	gs 		= [],		%% 奖品列表 [{cfgid,num,times}] cfgid -> 物品id ，num -> 物品数量，times -> 物品已被抽到的次数 
	fr 		= 0,		%% 上次强制刷新时间戳(unix时间，单位为秒)
	hr 		= 0			%% 上次手动刷新时间戳(unix时间，单位为秒)
	}).


%% 获奖记录表
-record (wish_log,{
		id 		= 0,
		logs 	=[]
	}).


-endif.