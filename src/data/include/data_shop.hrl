%% this file is auto maked!
-ifndef(__DATA_SHOP_HRL__).
-define(__DATA_SHOP_HRL__, true).

%% S-商店相关表格\商店类型表.xlsx

-record(cfg_shop,{
		id            =  0,   % 商店类型 - 1-市场 2-公会商店 3-许愿池商店 4-祭坛商店
		refresh_type  =  0,   % 刷新货币类型 - 1-钻石 2-金币 3-公会币 4-灵魂石碎片 5-幸运币
		refresh_money =  0,   % 刷新消耗货币数量 - 刷新商品表中物品
		reset_time    =  0,   % 免费刷新重置时间（小时） - "0"则没有重置时间
		reset_consume =  0,   % 重置消耗 - 重置商品表中物品，购买次数
		prop_number   =  0,   % 刷出物品数量 - 填写具体商店呈现数量
		refresh_time  =  0    % 商店刷新时间（0则不刷新） - 
	}).

-endif.
