%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_COUNTER_HRL__).
-define(__PT_COUNTER_HRL__, true).

%% ================== client to server proto =====================




%% ================== server to client proto =====================

-define(SC_COUNTER_INFOS, 500).   %% 500 - 类型和值登陆推送
-define(SC_COUNTER_UPDATE, 501).  %% 501 - 类型和值更新



%% ================== proto const =====================

-define(COUNT_TYPE_PUB_REFRESH_TIME, 1).  %% 类型 1 - 酒馆下次刷新时间



%% ================== records =====================

%% 类型和值登陆推送
-record(pt_counter_infos,{
    counters  = []  %% list(ps_counter_info) 类型和值
}).

%% 类型和值更新
-record(pt_counter_update,{
    type  = 0, %% integer() 类型 CONST@COUNT_TYPE
    num   = 0  %% integer() 配置ID
}).





%% ================== structs =====================

%% 类型和值
-record(ps_counter_info,{
    type  = 0, %% integer() 类型 CONST@COUNT_TYPE
    num   = 0  %% integer() 配置ID
}).




-endif.