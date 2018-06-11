%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_ITEM_HRL__).
-define(__PT_ITEM_HRL__, true).

%% ================== client to server proto =====================

-define(CS_SELL_ITEM, 1002).          %% 1002 - 出售物品
-define(CS_COMPOSE_EQUIPMENT, 1003).  %% 1003 - 合成装备
-define(CS_CHIP_COMPOSE, 1004).       %% 1004 - 碎片合成



%% ================== server to client proto =====================

-define(SC_GET_ITEMS, 1000).          %% 1000 - 物品信息获取返回
-define(SC_UPDATE_ITEMS, 1001).       %% 1001 - 物品增量更新,数量0表示删除
-define(SC_SELL_ITEM, 1002).          %% 1002 - 出售物品返回
-define(SC_COMPOSE_EQUIPMENT, 1003).  %% 1003 - 合成装备返回
-define(SC_CHIP_COMPOSE, 1004).       %% 1004 - 碎片合成返回



%% ================== proto const =====================

-define(REWARD_ITEM_TYPE_ITEM, 1).  %% 奖励类型 1 - 物品
-define(REWARD_ITEM_TYPE_ROLE, 2).  %% 奖励类型 2 - 佣兵

-define(ITEM_TYPE_ECONOMY, 0).      %% 物品类型 0 - 货币
-define(ITEM_TYPE_EQUIP, 1).        %% 物品类型 1 - 装备
-define(ITEM_TYPE_STUFF, 2).        %% 物品类型 2 - 材料
-define(ITEM_TYPE_CHIP, 3).         %% 物品类型 3 - 碎片
-define(ITEM_TYPE_ARTI, 4).         %% 物品类型 4 - 神器

-define(EQUIP_TYPE_WEAPON, 1).      %% 物品类型 1 - 武器
-define(EQUIP_TYPE_ARMOUR, 2).      %% 物品类型 2 - 铠甲
-define(EQUIP_TYPE_NECKLACE, 3).    %% 物品类型 3 - 饰品
-define(EQUIP_TYPE_SHOE, 4).        %% 物品类型 4 - 鞋子

-define(CHIP_TYPE_HERO, 1).         %% 碎片类型 1 - 英雄碎片
-define(CHIP_TYPE_SKIN, 2).         %% 碎片类型 2 - 皮肤碎片
-define(CHIP_TYPE_ARTIFACT, 3).     %% 碎片类型 3 - 神器碎片



%% ================== records =====================

%% 物品信息获取返回
-record(pt_get_items,{
    items  = []  %% list(ps_item) 背包物品信息
}).

%% 物品增量更新,数量0表示删除
-record(pt_update_items,{
    items  = []  %% list(ps_item) 背包物品信息
}).

%% 出售物品返回
-record(pt_sell_item,{
    gold  = 0  %% integer() 获得金币
}).

%% 合成装备返回
-record(pt_compose_equipment,{
    items  = []  %% list(ps_reward_items) 背包物品信息
}).

%% 碎片合成返回
-record(pt_chip_compose,{
    items  = []  %% list(ps_reward_items) 背包物品信息
}).





%% ================== structs =====================

%% 获得物品提示结构
-record(ps_reward_items,{
    type       = 0, %% integer() 类型 REWARD_ITEM_TYPE(1物品 2货币 3佣兵)
    cfg_id     = 0, %% integer() 配置ID
    stack_num  = 0  %% integer() 数量
}).

%% 物品结构
-record(ps_item,{
    cfg_id     = 0, %% integer() 配置ID
    stack_num  = 0  %% integer() 物品堆叠数量
}).




-endif.