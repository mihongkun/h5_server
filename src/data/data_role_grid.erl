%% this file is auto maked!
-module(data_role_grid).
-include("data_role_grid.hrl").
-compile(export_all).

%% Y-英雄列表开启表\英雄列表扩充表.xlsx

get(1) ->
	#cfg_role_grid{
		id           = 1,
		grid         = 60,
		grid_max     = 1000,
		buy_add      = 5,
		buy_cost     = [50, 100, 200],
		buy_cost_add = 100,
		buy_cost_max = 999999
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_role_grid:get(~p) not_match", [A]),
 not_match.

length() ->
 1.

id_list() ->
 [1].

all() ->[data_role_grid:get(ID) || ID<-id_list()].
