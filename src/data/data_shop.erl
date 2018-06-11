%% this file is auto maked!
-module(data_shop).
-include("data_shop.hrl").
-compile(export_all).

%% S-商店相关表格\商店类型表.xlsx

get(1) ->
	#cfg_shop{
		id            = 1,
		refresh_type  = 1,
		refresh_money = 20,
		reset_time    = 3,
		reset_consume = 0,
		prop_number   = 8,
		refresh_time  = 8
	};
get(2) ->
	#cfg_shop{
		id            = 2,
		refresh_type  = 3,
		refresh_money = 0,
		reset_time    = 0,
		reset_consume = 20000,
		prop_number   = 8,
		refresh_time  = 0
	};
get(3) ->
	#cfg_shop{
		id            = 3,
		refresh_type  = 5,
		refresh_money = 50,
		reset_time    = 24,
		reset_consume = 0,
		prop_number   = 8,
		refresh_time  = 0
	};
get(4) ->
	#cfg_shop{
		id            = 4,
		refresh_type  = 4,
		refresh_money = 0,
		reset_time    = 0,
		reset_consume = 5000,
		prop_number   = 8,
		refresh_time  = 0
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_shop:get(~p) not_match", [A]),
 not_match.

length() ->
 4.

id_list() ->
 [1, 2, 3, 4].

all() ->[data_shop:get(ID) || ID<-id_list()].
