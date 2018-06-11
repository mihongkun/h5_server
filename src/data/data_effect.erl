%% this file is auto maked!
-module(data_effect).
-include("data_effect.hrl").
-compile(export_all).

%% X-效果表\效果表.xlsx

get(1000) ->
	#cfg_effect{
		id          = 1000,
		effect_type = 1,
		hero_id     = 63401,
		star        = 4,
		sqid        = 0,
		herosjid    = 0,
		sqsjid      = 0
	};
get(1001) ->
	#cfg_effect{
		id          = 1001,
		effect_type = 2,
		hero_id     = 0,
		star        = 0,
		sqid        = 41101,
		herosjid    = 0,
		sqsjid      = 0
	};
get(1002) ->
	#cfg_effect{
		id          = 1002,
		effect_type = 2,
		hero_id     = 0,
		star        = 0,
		sqid        = 41101,
		herosjid    = 0,
		sqsjid      = 0
	};
get(1003) ->
	#cfg_effect{
		id          = 1003,
		effect_type = 2,
		hero_id     = 0,
		star        = 0,
		sqid        = 41101,
		herosjid    = 0,
		sqsjid      = 0
	};
get(1004) ->
	#cfg_effect{
		id          = 1004,
		effect_type = 2,
		hero_id     = 0,
		star        = 0,
		sqid        = 41101,
		herosjid    = 0,
		sqsjid      = 0
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_effect:get(~p) not_match", [A]),
 not_match.

length() ->
 5.

id_list() ->
 [1000, 1001, 1002, 1003, 1004].

all() ->[data_effect:get(ID) || ID<-id_list()].
