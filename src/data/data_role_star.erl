%% this file is auto maked!
-module(data_role_star).
-include("data_role_star.hrl").
-compile(export_all).

%% Y-英雄相关表格\英雄星级表.xlsx

get(0) ->
	#cfg_role_star{
		star         = 0,
		grow_rate    = 1.0,
		attri_rate   = 1.0,
		need_quality = 0,
		lv_max       = 30,
		icon1        = 10001,
		icon2        = 0,
		icon3        = 0
	};
get(1) ->
	#cfg_role_star{
		star         = 1,
		grow_rate    = 1.0,
		attri_rate   = 1.0,
		need_quality = 1,
		lv_max       = 40,
		icon1        = 10001,
		icon2        = 0,
		icon3        = 0
	};
get(2) ->
	#cfg_role_star{
		star         = 2,
		grow_rate    = 1.0,
		attri_rate   = 1.0,
		need_quality = 2,
		lv_max       = 50,
		icon1        = 10001,
		icon2        = 0,
		icon3        = 0
	};
get(3) ->
	#cfg_role_star{
		star         = 3,
		grow_rate    = 1.0,
		attri_rate   = 1.0,
		need_quality = 3,
		lv_max       = 60,
		icon1        = 10001,
		icon2        = 0,
		icon3        = 0
	};
get(4) ->
	#cfg_role_star{
		star         = 4,
		grow_rate    = 0.8,
		attri_rate   = 0.8,
		need_quality = 4,
		lv_max       = 80,
		icon1        = 10001,
		icon2        = 0,
		icon3        = 0
	};
get(5) ->
	#cfg_role_star{
		star         = 5,
		grow_rate    = 1.0,
		attri_rate   = 1.0,
		need_quality = 5,
		lv_max       = 100,
		icon1        = 10001,
		icon2        = 0,
		icon3        = 0
	};
get(6) ->
	#cfg_role_star{
		star         = 6,
		grow_rate    = 1.2,
		attri_rate   = 1.2,
		need_quality = 6,
		lv_max       = 140,
		icon1        = 0,
		icon2        = 10002,
		icon3        = 0
	};
get(7) ->
	#cfg_role_star{
		star         = 7,
		grow_rate    = 1.4,
		attri_rate   = 1.4,
		need_quality = 0,
		lv_max       = 160,
		icon1        = 0,
		icon2        = 10002,
		icon3        = 0
	};
get(8) ->
	#cfg_role_star{
		star         = 8,
		grow_rate    = 1.6,
		attri_rate   = 1.6,
		need_quality = 0,
		lv_max       = 180,
		icon1        = 0,
		icon2        = 10002,
		icon3        = 0
	};
get(9) ->
	#cfg_role_star{
		star         = 9,
		grow_rate    = 1.8,
		attri_rate   = 1.8,
		need_quality = 0,
		lv_max       = 200,
		icon1        = 0,
		icon2        = 10002,
		icon3        = 0
	};
get(10) ->
	#cfg_role_star{
		star         = 10,
		grow_rate    = 2.0,
		attri_rate   = 2.0,
		need_quality = 0,
		lv_max       = 250,
		icon1        = 0,
		icon2        = 0,
		icon3        = 10003
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_role_star:get(~p) not_match", [A]),
 not_match.

length() ->
 11.

id_list() ->
 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].

all() ->[data_role_star:get(ID) || ID<-id_list()].
