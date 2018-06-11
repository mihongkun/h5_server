%% this file is auto maked!
-ifndef(__DATA_SHOP_ITEM_HRL__).
-define(__DATA_SHOP_ITEM_HRL__, true).

%% S-商店相关表格\市场物品表.xlsx

-record(cfg_shop_item,{
		id            =  0,   % 刷新ID - 
		goodsid       =  0,   % 物品ID - 
		number        =  0,   % 物品数量 - 
		frequency     =  0,   % 购买次数 - 999则不限制
		currency_type =  0,   % 货币类型 - 1-钻石 2-金币 3-公会币 4-灵魂石碎片 5-幸运币
		price         =  0,   % 购买价格 - 
		weight        =  0    % 物品出现权重 - 
	}).

-endif.
