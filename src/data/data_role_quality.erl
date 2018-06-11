%% this file is auto maked!
-module(data_role_quality).
-include("data_role_quality.hrl").
-compile(export_all).

%% Y-英雄相关表格\英雄进化等级表.xlsx

get(0) ->
	#cfg_role_quality{
		lv         = 0,
		hp_rate    = 1.0,
		atk_rate   = 1.0,
		def_rate   = 1.0,
		speed_rate = 1.0,
		cost_jjs   = 0,
		cost_gold  = 0
	};
get(1) ->
	#cfg_role_quality{
		lv         = 1,
		hp_rate    = 1.2,
		atk_rate   = 1.2,
		def_rate   = 1.0,
		speed_rate = 1.2,
		cost_jjs   = 1111,
		cost_gold  = 1111
	};
get(2) ->
	#cfg_role_quality{
		lv         = 2,
		hp_rate    = 1.4,
		atk_rate   = 1.4,
		def_rate   = 1.0,
		speed_rate = 1.4,
		cost_jjs   = 1111,
		cost_gold  = 1111
	};
get(3) ->
	#cfg_role_quality{
		lv         = 3,
		hp_rate    = 1.6,
		atk_rate   = 1.6,
		def_rate   = 1.0,
		speed_rate = 1.6,
		cost_jjs   = 1111,
		cost_gold  = 1111
	};
get(4) ->
	#cfg_role_quality{
		lv         = 4,
		hp_rate    = 1.8,
		atk_rate   = 1.8,
		def_rate   = 1.0,
		speed_rate = 1.8,
		cost_jjs   = 1111,
		cost_gold  = 1111
	};
get(5) ->
	#cfg_role_quality{
		lv         = 5,
		hp_rate    = 2.0,
		atk_rate   = 2.0,
		def_rate   = 1.0,
		speed_rate = 2.0,
		cost_jjs   = 1111,
		cost_gold  = 1111
	};
get(6) ->
	#cfg_role_quality{
		lv         = 6,
		hp_rate    = 2.2,
		atk_rate   = 2.2,
		def_rate   = 1.0,
		speed_rate = 2.2,
		cost_jjs   = 1111,
		cost_gold  = 1111
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_role_quality:get(~p) not_match", [A]),
 not_match.

length() ->
 7.

id_list() ->
 [0, 1, 2, 3, 4, 5, 6].

all() ->[data_role_quality:get(ID) || ID<-id_list()].
