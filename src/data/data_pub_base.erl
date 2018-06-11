%% this file is auto maked!
-module(data_pub_base).
-include("data_pub_base.hrl").
-compile(export_all).

%% J-酒馆任务相关表\酒馆任务基础表.xlsx

get(1) ->
	#cfg_pub_base{
		id                = 1,
		task_number       = 5,
		task_refresh_time = 8,
		ordinary_reel     = 1,
		refresh_task      = [1,2,3,4],
		senior_reel       = 1,
		refresh_task1     = [4,5,6,7],
		consume           = 10
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_pub_base:get(~p) not_match", [A]),
 not_match.

length() ->
 1.

id_list() ->
 [1].

all() ->[data_pub_base:get(ID) || ID<-id_list()].
