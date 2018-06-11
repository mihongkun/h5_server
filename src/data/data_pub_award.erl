%% this file is auto maked!
-module(data_pub_award).
-include("data_pub_award.hrl").
-compile(export_all).

%% J-酒馆任务相关表\任务星级奖励表.xlsx

get(1) ->
	#cfg_pub_award{
		id      = 1,
		star_lv = 1,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(2) ->
	#cfg_pub_award{
		id      = 2,
		star_lv = 1,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(3) ->
	#cfg_pub_award{
		id      = 3,
		star_lv = 2,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(4) ->
	#cfg_pub_award{
		id      = 4,
		star_lv = 2,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(5) ->
	#cfg_pub_award{
		id      = 5,
		star_lv = 3,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(6) ->
	#cfg_pub_award{
		id      = 6,
		star_lv = 3,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(7) ->
	#cfg_pub_award{
		id      = 7,
		star_lv = 3,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(8) ->
	#cfg_pub_award{
		id      = 8,
		star_lv = 4,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(9) ->
	#cfg_pub_award{
		id      = 9,
		star_lv = 4,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(10) ->
	#cfg_pub_award{
		id      = 10,
		star_lv = 4,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(11) ->
	#cfg_pub_award{
		id      = 11,
		star_lv = 4,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(12) ->
	#cfg_pub_award{
		id      = 12,
		star_lv = 4,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(13) ->
	#cfg_pub_award{
		id      = 13,
		star_lv = 5,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(14) ->
	#cfg_pub_award{
		id      = 14,
		star_lv = 5,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(15) ->
	#cfg_pub_award{
		id      = 15,
		star_lv = 5,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(16) ->
	#cfg_pub_award{
		id      = 16,
		star_lv = 5,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(17) ->
	#cfg_pub_award{
		id      = 17,
		star_lv = 5,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(18) ->
	#cfg_pub_award{
		id      = 18,
		star_lv = 6,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(19) ->
	#cfg_pub_award{
		id      = 19,
		star_lv = 6,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(20) ->
	#cfg_pub_award{
		id      = 20,
		star_lv = 6,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(21) ->
	#cfg_pub_award{
		id      = 21,
		star_lv = 6,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(22) ->
	#cfg_pub_award{
		id      = 22,
		star_lv = 6,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(23) ->
	#cfg_pub_award{
		id      = 23,
		star_lv = 6,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(24) ->
	#cfg_pub_award{
		id      = 24,
		star_lv = 7,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(25) ->
	#cfg_pub_award{
		id      = 25,
		star_lv = 7,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(26) ->
	#cfg_pub_award{
		id      = 26,
		star_lv = 7,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(27) ->
	#cfg_pub_award{
		id      = 27,
		star_lv = 7,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(28) ->
	#cfg_pub_award{
		id      = 28,
		star_lv = 7,
		reward  =  0,
		min     =  0,
		max     =  0,
		weight  =  0
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_pub_award:get(~p) not_match", [A]),
 not_match.

length() ->
 28.

id_list() ->
 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28].

all() ->[data_pub_award:get(ID) || ID<-id_list()].
