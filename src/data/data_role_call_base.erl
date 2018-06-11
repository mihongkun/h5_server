%% this file is auto maked!
-module(data_role_call_base).
-include("data_role_call_base.hrl").
-compile(export_all).

%% C-抽奖表\C-抽奖表.xlsx

get(1) ->
	#cfg_role_call_base{
		id         = 1,
		item_id    = 116,
		cost       = 1,
		ten_cost   = 8,
		diamond    = 0,
		ten_diamon = 0,
		wait_time  = 12,
		power      = 0,
		ten_power  = 0
	};
get(2) ->
	#cfg_role_call_base{
		id         = 2,
		item_id    = 117,
		cost       = 1,
		ten_cost   = 8,
		diamond    = 250,
		ten_diamon = 2200,
		wait_time  = 48,
		power      = 10,
		ten_power  = 80
	};
get(3) ->
	#cfg_role_call_base{
		id         = 3,
		item_id    = 118,
		cost       = 10,
		ten_cost   = 100,
		diamond    = 0,
		ten_diamon = 0,
		wait_time  = 0,
		power      = 0,
		ten_power  = 0
	};
get(4) ->
	#cfg_role_call_base{
		id         = 4,
		item_id    = 131,
		cost       = 1000,
		ten_cost   = 10000,
		diamond    = 0,
		ten_diamon = 0,
		wait_time  = 0,
		power      = 0,
		ten_power  = 0
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_role_call_base:get(~p) not_match", [A]),
 not_match.

length() ->
 4.

id_list() ->
 [1, 2, 3, 4].

all() ->[data_role_call_base:get(ID) || ID<-id_list()].
