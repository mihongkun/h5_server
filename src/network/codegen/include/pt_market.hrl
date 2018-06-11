%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_MARKET_HRL__).
-define(__PT_MARKET_HRL__, true).

%% ================== client to server proto =====================

-define(CS_GET_SHOP, 800).          %% 800 - 请求商店信息
-define(CS_REFRESH_MARKET, 801).    %% 801 - 市场刷新
-define(CS_BUY_MARKET_PROPS, 802).  %% 802 - 市场购买



%% ================== server to client proto =====================

-define(SC_GET_SHOP, 800).          %% 800 - 商店信息获取返回
-define(SC_BUY_MARKET_PROPS, 802).  %% 802 - 商店信息获取返回



%% ================== proto const =====================



%% ================== records =====================

%% 商店信息获取返回
-record(pt_get_shop,{
    items  = []  %% list(ps_shop_item) 商店物品信息
}).

%% 商店信息获取返回
-record(pt_buy_market_props,{
    item_id  = 0, %% integer() 物品ID
    num      = 0  %% integer() 物品数量
}).





%% ================== structs =====================

%% 物品结构
-record(ps_shop_item,{
    shop_item_id  = 0, %% integer() 商店物品配置
    res_num       = 0  %% integer() 物品剩余数量
}).




-endif.