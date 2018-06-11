%% this file is auto maked!
-module(data_role_compose).
-include("data_role_compose.hrl").
-compile(export_all).

%% Y-英雄相关表格\英雄合成表（创造法阵）.xlsx

get(15) ->
	#cfg_role_compose{
		id           = 15,
		type         = 1,
		tar_id       = 100015,
		tar_star     = 6,
		role_id1     = 100114,
		role_star1   = 1,
		role_id2     = 100114,
		role_star2   = 3,
		role_id3     = 100111,
		role_star3   = 4,
		camp         = 1,
		camp_star    = 4,
		camp_num     = 4,
		need_quality = 0
	};
get(2) ->
	#cfg_role_compose{
		id           = 2,
		type         = 2,
		tar_id       = 100016,
		tar_star     = 8,
		role_id1     = 100015,
		role_star1   = 1,
		role_id2     = 100015,
		role_star2   = 1,
		role_id3     = 100113,
		role_star3   = 1,
		camp         = 1,
		camp_star    = 5,
		camp_num     = 3,
		need_quality = 1
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_role_compose:get(~p) not_match", [A]),
 not_match.

length() ->
 2.

id_list() ->
 [15, 2].

all() ->[data_role_compose:get(ID) || ID<-id_list()].
