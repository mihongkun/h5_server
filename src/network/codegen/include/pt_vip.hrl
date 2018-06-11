%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_VIP_HRL__).
-define(__PT_VIP_HRL__, true).

%% ================== client to server proto =====================

-define(CS_GET_VIP_BASE_INFO, 700).         %% 700 - 获取VIP基础信息
-define(CS_BUY_VIP_GIFT, 701).              %% 701 - 购买VIP礼包
-define(CS_GET_FIRST_RECHARGE_INFO, 710).   %% 710 - 获取首充礼包信息
-define(CS_GET_FIRST_RECHARGE_AWARD, 711).  %% 711 - 获取首充礼包奖励



%% ================== server to client proto =====================

-define(SC_RESP_GET_VIP_BASE_INFO, 700).        %% 700 - 返回VIP基础信息
-define(SC_RESP_NOTIFY_VIP_GIFT_CHANGE, 701).   %% 701 - 返回VIP礼包变动信息
-define(SC_RESP_GET_FIRST_RECHARGE_INFO, 710).  %% 710 - 返回首充礼包信息



%% ================== proto const =====================

-define(VIP_CONSTANT_IS_CAN_BUY_N, 0).              %% VIP模块常量 0 - 不可购买
-define(VIP_CONSTANT_IS_CAN_BUY_Y, 1).              %% VIP模块常量 1 - 可以购买
-define(VIP_CONSTANT_IS_BUY_N, 0).                  %% VIP模块常量 0 - 未购买
-define(VIP_CONSTANT_IS_BUY_Y, 1).                  %% VIP模块常量 1 - 已购买

-define(RECHARGE_CONSTANT_IS_DOUBLE_N, 0).          %% VIP模块-充值常量 0 - 没有翻倍
-define(RECHARGE_CONSTANT_IS_DOUBLE_Y, 1).          %% VIP模块-充值常量 1 - 充值翻倍
-define(RECHARGE_CONSTANT_FIRST_AWARD_STATE_N, 0).  %% VIP模块-充值常量 0 - 未激活
-define(RECHARGE_CONSTANT_FIRST_AWARD_STATE_C, 1).  %% VIP模块-充值常量 1 - 可领取
-define(RECHARGE_CONSTANT_FIRST_AWARD_STATE_Y, 2).  %% VIP模块-充值常量 2 - 已领取



%% ================== records =====================

%% 返回VIP基础信息
-record(pt_resp_get_vip_base_info,{
    vip_base_info  = none  %% vip_base_info VIP等级
}).

%% 返回VIP礼包变动信息
-record(pt_resp_notify_vip_gift_change,{
    vip_gift_info  = none  %% vip_gift_info VIP礼包信息
}).

%% 返回首充礼包信息
-record(pt_resp_get_first_recharge_info,{
    first_recharge_award_state  = 0, %% integer() 首充奖励状态 @SEE VIP_CONSTANT:FIRST_AWARD_STATE_N、FIRST_AWARD_STATE_C、FIRST_AWARD_STATE_Y
    first_recharge_item_list    = []  %% list(ps_first_recharge_item_info) 赠送道具列表
}).





%% ================== structs =====================

%% VIP基础信息
-record(ps_vip_base_info,{
    vip_level              = 0, %% integer() VIP等级
    charge_tot_diamond     = 0, %% integer() 玩家当前充值钻石数量
    next_vip_tot_diamond   = 0, %% integer() 下一等级VIP钻石总数量
    is_can_buy_month_card  = 0, %% integer() 是否可购买包月卡 @SEE VIP_CONSTANT:IS_CAN_BUY_N、IS_CAN_BUY_Y
    vip_gift_list          = [], %% list(ps_vip_gift_info) VIP礼包信息
    recharge_list          = []  %% list(ps_recharge_info) 充值信息列表
}).

%% VIP礼包信息
-record(ps_vip_gift_info,{
    vip_level  = 0, %% integer() VIP等级
    item_id    = 0, %% integer() 道具原型ID
    is_buy     = 0  %% integer() 是否已购买 @SEE VIP_CONSTANT:IS_BUY_N、IS_BUY_Y
}).

%% VIP礼包信息
-record(ps_recharge_info,{
    recharge_money    = 0, %% integer() 充值金额
    recharge_diamond  = 0, %% integer() 充值钻石
    is_double         = 0, %% integer() 是否首充翻倍 @SEE RECHARGE_CONSTANT:IS_DOUBLE_N、IS_DOUBLE_Y
    icon              = 0  %% integer() 充值图标
}).

%% 首充赠送道具信息
-record(ps_first_recharge_item_info,{
    item_id   = 0, %% integer() 道具原型ID
    item_num  = 0  %% integer() 道具数量
}).




-endif.