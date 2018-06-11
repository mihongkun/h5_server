%% this file is auto maked!
-module(data_wish_base).
-include("data_wish_base.hrl").
-compile(export_all).

%% X-许愿池相关表格\许愿池基础表.xlsx

get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_wish_base:get(~p) not_match", [A]),
 not_match.

length() ->
 0.

id_list() ->
 [].

all() ->[data_wish_base:get(ID) || ID<-id_list()].
