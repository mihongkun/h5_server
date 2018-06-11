%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_SPOTGOLD_HRL__).
-define(__PT_SPOTGOLD_HRL__, true).

%% ================== client to server proto =====================

-define(CS_GET_SPOTGOLD, 1101).  %% 1101 - 点金信息
-define(CS_BUY_SPOTGOLD, 1102).  %% 1102 - 点金使用



%% ================== server to client proto =====================

-define(SC_GET_SPOTGOLD, 1101).  %% 1101 - 点金信息



%% ================== proto const =====================

-define(SPOTGOLD_TYPE_ORDINARY, 1).      %% 点金类型 1 - 普通点金
-define(SPOTGOLD_TYPE_INTERMEDIATE, 2).  %% 点金类型 2 - 中级点金
-define(SPOTGOLD_TYPE_SENIOR, 3).        %% 点金类型 3 - 高级点金



%% ================== records =====================

%% 点金信息
-record(pt_get_spotgold,{
    refresh_time  = [], %% list(integer()) 刷新时间
    ordinary      = [], %% list(integer()) 普通点金
    intermediate  = [], %% list(integer()) 中级点金
    senior        = []  %% list(integer()) 高级点金
}).





%% ================== structs =====================




-endif.