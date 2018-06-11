%% this file is auto maked!
-module(data_battle).
-include("data_battle.hrl").
-compile(export_all).

%% Z-战斗\战斗表-Battle.xlsx

get(1) ->
	#cfg_battle{
		id        = 1,
		scene_id  = 1000,
		mon_1     = 65001,
		mon_2     = 65001,
		mon_3     = 65001,
		mon_4     = 65001,
		mon_5     = 65001,
		mon_6     = 65001,
		max_round = 15,
		reward_id = 100
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_battle:get(~p) not_match", [A]),
 not_match.

length() ->
 1.

id_list() ->
 [1].

all() ->[data_battle:get(ID) || ID<-id_list()].
