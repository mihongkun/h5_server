%% this file is auto maked!
-module(data_item_com).
-include("data_item_com.hrl").
-compile(export_all).

%% D-道具表\合成表.xlsx

get(411001) ->
	#cfg_item_com{
		q_id      = 411001,
		stuff_id  = 311001,
		stuff_num = 3,
		gold      = 300
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_item_com:get(~p) not_match", [A]),
 not_match.

length() ->
 1.

id_list() ->
 [411001].

all() ->[data_item_com:get(ID) || ID<-id_list()].
