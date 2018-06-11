%% this file is auto maked!
-ifndef(__DATA_WISH_SUPER_HRL__).
-define(__DATA_WISH_SUPER_HRL__, true).

%% X-许愿池相关表格\高级许愿池奖励表.xlsx

-record(cfg_wish_super,{
		lattice     =  0,   % 对应格子 - 
		type        =  0,   % 类型 - 读取道具表中物品类型
		item_order1 =  0,   % 物品品阶1 - 读取道具表中物品品阶
		min1        =  0,   % 最小值1 - 区间数量最小值
		max1        =  0,   % 最大值1 - 区间数量最大值
		frequency1  =  0,   % 抽次数 - 不限制则填“0”
		item_order2 =  0,   % 物品品阶2 - 读取道具表中物品品阶
		min2        =  0,   % 最小值2 - 区间数量最小值
		max2        =  0,   % 最大值2 - 区间数量最大值
		frequency2  =  0,   % 抽次数 - 不限制则填“0”
		item_order3 =  0,   % 物品品阶3 - 读取道具表中物品品阶
		min3        =  0,   % 最小值3 - 区间数量最小值
		max3        =  0,   % 最大值3 - 区间数量最大值
		frequency3  =  0,   % 抽次数 - 不限制则填“0”
		weight      =  0    % 权重 - 物品出现概率
	}).

-endif.
