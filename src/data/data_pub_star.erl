%% this file is auto maked!
-module(data_pub_star).
-include("data_pub_star.hrl").
-compile(export_all).

%% J-酒馆任务相关表\酒馆任务星级表.xlsx

get(1) ->
	#cfg_pub_star{
		id             = 1,
		star_lv        = 1,
		star_condition = 0,
		hero_number    = 1,
		con_number     = 1,
		task_time      = 1,
		acc_cost       = 0,
		weight         = 80
	};
get(2) ->
	#cfg_pub_star{
		id             = 2,
		star_lv        = 2,
		star_condition = 0,
		hero_number    = 1,
		con_number     = 2,
		task_time      = 2,
		acc_cost       = 0,
		weight         = 70
	};
get(3) ->
	#cfg_pub_star{
		id             = 3,
		star_lv        = 3,
		star_condition = 2,
		hero_number    = 2,
		con_number     = 3,
		task_time      = 4,
		acc_cost       = 0,
		weight         = 60
	};
get(4) ->
	#cfg_pub_star{
		id             = 4,
		star_lv        = 4,
		star_condition = 3,
		hero_number    = 3,
		con_number     = 3,
		task_time      = 6,
		acc_cost       = 10,
		weight         = 40
	};
get(5) ->
	#cfg_pub_star{
		id             = 5,
		star_lv        = 5,
		star_condition = 4,
		hero_number    = 3,
		con_number     = 3,
		task_time      = 8,
		acc_cost       = 50,
		weight         = 30
	};
get(6) ->
	#cfg_pub_star{
		id             = 6,
		star_lv        = 6,
		star_condition = 5,
		hero_number    = 4,
		con_number     = 3,
		task_time      = 12,
		acc_cost       = 250,
		weight         = 15
	};
get(7) ->
	#cfg_pub_star{
		id             = 7,
		star_lv        = 7,
		star_condition = 6,
		hero_number    = 4,
		con_number     = 4,
		task_time      = 16,
		acc_cost       = 1000,
		weight         = 1
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_pub_star:get(~p) not_match", [A]),
 not_match.

length() ->
 7.

id_list() ->
 [1, 2, 3, 4, 5, 6, 7].

all() ->[data_pub_star:get(ID) || ID<-id_list()].
