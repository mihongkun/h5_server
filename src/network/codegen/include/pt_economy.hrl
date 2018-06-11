%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_ECONOMY_HRL__).
-define(__PT_ECONOMY_HRL__, true).

%% ================== client to server proto =====================




%% ================== server to client proto =====================

-define(SC_ECONOMY_INFO, 300).    %% 300 - 经济总览获取返回
-define(SC_DIAMOND_UPDATE, 301).  %% 301 - 钻石更新返回
-define(SC_GOLD_UPDATE, 302).     %% 302 - 金币更新返回
-define(SC_SOUL_UPDATE, 303).     %% 303 - 英魂更新返回
-define(SC_WATER_UPDATE, 304).    %% 304 - 水滴更新返回
-define(SC_STAMEN_UPDATE, 305).   %% 305 - 体力更新返回
-define(SC_NARC_UPDATE, 306).     %% 306 - 紫水仙更新返回



%% ================== proto const =====================



%% ================== records =====================

%% 经济总览获取返回
-record(pt_economy_info,{
    diamond      = 0, %% integer() 钻石
    gold         = 0, %% integer() 金币
    soul         = 0, %% integer() 英魂
    water        = 0, %% integer() 水滴
    water_time   = 0, %% integer() 下次水滴恢复时间戳
    stamen       = 0, %% integer() 体力
    stamen_time  = 0, %% integer() 下次体力恢复时间戳
    narc         = 0, %% integer() 紫水仙
    narc_time    = 0  %% integer() 下次紫水仙恢复时间戳
}).

%% 钻石更新返回
-record(pt_diamond_update,{
    diamond  = 0  %% integer() 钻石更新
}).

%% 金币更新返回
-record(pt_gold_update,{
    gold  = 0  %% integer() 金币更新
}).

%% 英魂更新返回
-record(pt_soul_update,{
    soul  = 0  %% integer() 英魂更新
}).

%% 水滴更新返回
-record(pt_water_update,{
    water       = 0, %% integer() 水滴更新
    water_time  = 0  %% integer() 下次水滴恢复时间戳
}).

%% 体力更新返回
-record(pt_stamen_update,{
    stamen       = 0, %% integer() 体力
    stamen_time  = 0  %% integer() 下次体力恢复时间戳
}).

%% 紫水仙更新返回
-record(pt_narc_update,{
    narc       = 0, %% integer() 紫水仙
    narc_time  = 0  %% integer() 下次紫水仙恢复时间戳
}).





%% ================== structs =====================

%% 经济结构
-record(ps_economy_long,{
    type   = 0, %% integer() 类型@SEE ECONOMY_CONSTANT
    value  = 0  %% integer() 改变后的值
}).

%% 经济结构
-record(ps_economy,{
    type   = 0, %% integer() 类型@SEE ECONOMY_CONSTANT
    value  = 0  %% integer() 改变后的值
}).




-endif.