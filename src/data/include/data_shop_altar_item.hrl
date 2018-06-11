%% this file is auto maked!
-ifndef(__DATA_SHOP_ALTAR_ITEM_HRL__).
-define(__DATA_SHOP_ALTAR_ITEM_HRL__, true).

%% S-商店相关表格\祭坛商店物品表.xlsx

-record(cfg_shop_altar_item,{
		id            =  0,   % 排序ID - 
		goodsid       =  0,   % 物品ID - 
		number        =  0,   % 物品数量 - 
		frequency     =  0,   % 购买次数 - 999则不限制
		currency_type =  0,   % 货币类型 - 1-钻石 2-金币 3-公会币 4-灵魂石碎片 5-幸运币
		price         =  0    % 购买价格 - 
	}).

-endif.
