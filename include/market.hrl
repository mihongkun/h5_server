-ifndef(__MARKET_HRL__).
-define(__MARKET_HRL__, true).

-define(MARKET_TYPE_DIAMOND, 1).          %% 经济模块常量 1 - 钻石
-define(MARKET_TYPE_GOLD, 2).             %% 经济模块常量 2 - 金币


%%市场
-record(market,{
	key={0,0}, %%sid,shop_id 玩家ID 商店ID
	items=[],  %%[{freshid,buytime}] 物品id ，购买次数
	free_refresh_time=0, %%免费刷新时间，如果少于当前时间可免费刷新
	force_fresh_time=0    %%强制刷新时间
	}

	).


-endif.
