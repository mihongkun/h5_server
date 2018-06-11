%% this file is auto maked!
-module(data_pub_rand).
-include("data_pub_rand.hrl").
-compile(export_all).

%% J-酒馆任务相关表\任务条件随机表.xlsx

get(1) ->
	#cfg_pub_rand{
		id         = 1,
		camp       = 1,
		occupation = 1
	};
get(2) ->
	#cfg_pub_rand{
		id         = 2,
		camp       = 2,
		occupation = 2
	};
get(3) ->
	#cfg_pub_rand{
		id         = 3,
		camp       = 3,
		occupation = 3
	};
get(4) ->
	#cfg_pub_rand{
		id         = 4,
		camp       = 4,
		occupation = 4
	};
get(5) ->
	#cfg_pub_rand{
		id         = 5,
		camp       = 5,
		occupation = 5
	};
get(6) ->
	#cfg_pub_rand{
		id         = 6,
		camp       = 6,
		occupation = 6
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_pub_rand:get(~p) not_match", [A]),
 not_match.

length() ->
 6.

id_list() ->
 [1, 2, 3, 4, 5, 6].

all() ->[data_pub_rand:get(ID) || ID<-id_list()].
