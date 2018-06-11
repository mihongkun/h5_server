%% this file is auto maked!
-ifndef(__DATA_WISH_NORMAL_HRL__).
-define(__DATA_WISH_NORMAL_HRL__, true).

%% X-许愿池相关表格\普通许愿池奖励表.xlsx

-record(cfg_wish_normal,{
		lattice     =  0,   % 对应格子 - 
		type        =  0,   % 类型 - 读取道具表中物品类型
		level_min1  =  0,   % 级别最小1 - 战队等级最小
		level_max1  =  0,   % 级别最大1 - 战队等级最大
		item_order1 =  0,   % 物品品阶1 - 读取道具表中物品品阶
		min1        =  0,   % 最小值1 - 区间数量最小值
		max1        =  0,   % 最大值1 - 区间数量最大值
		frequency1  =  0,   % 抽次数 - 不限制则填“0”
		level_min2  =  0,   % 级别最小2 - 战队等级最小
		level_max2  =  0,   % 级别最大2 - 战队等级最大
		item_order2 =  0,   % 物品品阶2 - 读取道具表中物品品阶
		min2        =  0,   % 最小值2 - 区间数量最小值
		max2        =  0,   % 最大值2 - 区间数量最大值
		frequency2  =  0,   % 抽次数 - 不限制则填“0”
		level_min3  =  0,   % 级别最小3 - 战队等级最小
		level_max3  =  0,   % 级别最大3 - 战队等级最大
		item_order3 =  0,   % 物品品阶3 - 读取道具表中物品品阶
		min3        =  0,   % 最小值3 - 区间数量最小值
		max3        =  0,   % 最大值3 - 区间数量最大值
		frequency3  =  0,   % 抽次数 - 不限制则填“0”
		level_min4  =  0,   % 级别最小4 - 战队等级最小
		level_max4  =  0,   % 级别最大4 - 战队等级最大
		item_order4 =  0,   % 物品品阶4 - 读取道具表中物品品阶
		min4        =  0,   % 最小值4 - 区间数量最小值
		max4        =  0,   % 最大值4 - 区间数量最大值
		frequency4  =  0,   % 抽次数 - 不限制则填“0”
		weight      =  0    % 权重 - 物品出现概率
	}).

-endif.
