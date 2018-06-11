%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_ERROR_HRL__).
-define(__PT_ERROR_HRL__, true).

%% ================== client to server proto =====================




%% ================== server to client proto =====================

-define(SC_ERROR, 99).  %% 99 - 通用错误返回



%% ================== proto const =====================



%% ================== records =====================

%% 通用错误返回
-record(pt_error,{
    proto  = 0, %% integer() 发生错误操作的协议
    code   = 0, %% integer() 错误码
    parms  = []  %% list(list()) 参数
}).





%% ================== structs =====================




-endif.