-ifndef(__ECONOMY_HRL__).
-define(__ECONOMY_HRL__, true).

-include("common.hrl").
-include("log_economy.hrl").
-include("pt_economy.hrl").
-include("pt_error.hrl").

-define(ECONOMY_TYPE_DIAMOND,   1).   
-define(ECONOMY_TYPE_GOLD,      2).   

-record(economy, {
    sid = 0,        %% 账号ID
    diamond = 0,    %% 钻石
    gold = 0,       %% 金币
    soul = 0,       %% 英魂
    water = 0,      %% 水滴
    water_time = 0, %% 下次水滴恢复时间戳
    stamen = 0,      %% 体力
    stamen_time = 0, %% 下次体力恢复时间戳
    narc = 0,      %% 紫水仙
    narc_time = 0  %% 下次紫水仙恢复时间戳
    }).

-endif.