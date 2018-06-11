%% this file is auto maked!
-module(data_pub_name).
-include("data_pub_name.hrl").
-compile(export_all).

%% J-酒馆任务相关表\任务名字随机表.xlsx

get(1) ->
	#cfg_pub_name{
		id        = 1,
		task_name = "寻找小白的剑",
		weight    = 1
	};
get(2) ->
	#cfg_pub_name{
		id        = 2,
		task_name = "营救玄奘",
		weight    = 1
	};
get(3) ->
	#cfg_pub_name{
		id        = 3,
		task_name = "大闹天宫",
		weight    = 1
	};
get(4) ->
	#cfg_pub_name{
		id        = 4,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(5) ->
	#cfg_pub_name{
		id        = 5,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(6) ->
	#cfg_pub_name{
		id        = 6,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(7) ->
	#cfg_pub_name{
		id        = 7,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(8) ->
	#cfg_pub_name{
		id        = 8,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(9) ->
	#cfg_pub_name{
		id        = 9,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(10) ->
	#cfg_pub_name{
		id        = 10,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(11) ->
	#cfg_pub_name{
		id        = 11,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(12) ->
	#cfg_pub_name{
		id        = 12,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(13) ->
	#cfg_pub_name{
		id        = 13,
		task_name = "绿巨人吃糖",
		weight    = 1
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_pub_name:get(~p) not_match", [A]),
 not_match.

length() ->
 13.

id_list() ->
 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13].

all() ->[data_pub_name:get(ID) || ID<-id_list()].
