%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_COMMON_HRL__).
-define(__PT_COMMON_HRL__, true).

%% ================== client to server proto =====================




%% ================== server to client proto =====================




%% ================== proto const =====================

-define(REWARD_ITEM_TYPE_ITEM, 1).     %% 经济模块常量 1 - 物品
-define(REWARD_ITEM_TYPE_ECONOMY, 2).  %% 经济模块常量 2 - 货币
-define(REWARD_ITEM_TYPE_ROLE, 3).     %% 经济模块常量 3 - 佣兵



%% ================== records =====================





%% ================== structs =====================

%% 获得物品提示结构
-record(ps_reward_items,{
    type       = 0, %% integer() 类型 REWARD_ITEM_TYPE(1物品 2货币 3佣兵)
    cfg_id     = 0, %% integer() 配置ID
    stack_num  = 0  %% integer() 数量
}).




-endif.