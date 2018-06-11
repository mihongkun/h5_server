%% this file is auto maked!
-module(data_spotgold).
-include("data_spotgold.hrl").
-compile(export_all).

%% D-点金功能\点金功能表.xlsx

get(1) ->
	#cfg_spotgold{
		id              = 1,
		spot_gold       = 50000,
		level_growth    = 300,
		in_golg         = 100000,
		consume_drill_1 = 20,
		high_golg       = 25000,
		consume_drill_2 = 50,
		reset_time      = 8
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_spotgold:get(~p) not_match", [A]),
 not_match.

length() ->
 1.

id_list() ->
 [1].

all() ->[data_spotgold:get(ID) || ID<-id_list()].
