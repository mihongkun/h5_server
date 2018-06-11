%% this file is auto maked!
-module(data_global).
-include("data_global.hrl").
-compile(export_all).

%% G-Global表\global表.xlsx

get(1) ->
	#cfg_global{
		id    = 1,
		value = 200,
		desc  = "佣兵最大怒气"
	};
get(2) ->
	#cfg_global{
		id    = 2,
		value = 10,
		desc  = "高抽增加能量"
	};
get(3) ->
	#cfg_global{
		id    = 3,
		value = 1000,
		desc  = "能量抽卡所需能量"
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_global:get(~p) not_match", [A]),
 not_match.

length() ->
 3.

id_list() ->
 [1, 2, 3].

all() ->[data_global:get(ID) || ID<-id_list()].
