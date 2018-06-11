%% this file is auto maked!
-module(data_role_call_super).
-include("data_role_call.hrl").
-compile(export_all).

%% J-奖池表\高抽英雄池表.xlsx

get(61501) ->
	#cfg_role_call{
		role_id = 61501,
		weight  = 12
	};
get(61502) ->
	#cfg_role_call{
		role_id = 61502,
		weight  = 12
	};
get(61503) ->
	#cfg_role_call{
		role_id = 61503,
		weight  = 12
	};
get(61504) ->
	#cfg_role_call{
		role_id = 61504,
		weight  = 12
	};
get(61505) ->
	#cfg_role_call{
		role_id = 61505,
		weight  = 12
	};
get(61506) ->
	#cfg_role_call{
		role_id = 61506,
		weight  = 12
	};
get(61507) ->
	#cfg_role_call{
		role_id = 61507,
		weight  = 12
	};
get(61508) ->
	#cfg_role_call{
		role_id = 61508,
		weight  = 12
	};
get(61509) ->
	#cfg_role_call{
		role_id = 61509,
		weight  = 12
	};
get(61510) ->
	#cfg_role_call{
		role_id = 61510,
		weight  = 12
	};
get(61511) ->
	#cfg_role_call{
		role_id = 61511,
		weight  = 12
	};
get(61512) ->
	#cfg_role_call{
		role_id = 61512,
		weight  = 12
	};
get(61513) ->
	#cfg_role_call{
		role_id = 61513,
		weight  = 12
	};
get(61514) ->
	#cfg_role_call{
		role_id = 61514,
		weight  = 12
	};
get(61515) ->
	#cfg_role_call{
		role_id = 61515,
		weight  = 12
	};
get(61516) ->
	#cfg_role_call{
		role_id = 61516,
		weight  = 12
	};
get(61517) ->
	#cfg_role_call{
		role_id = 61517,
		weight  = 12
	};
get(61518) ->
	#cfg_role_call{
		role_id = 61518,
		weight  = 12
	};
get(61519) ->
	#cfg_role_call{
		role_id = 61519,
		weight  = 12
	};
get(61520) ->
	#cfg_role_call{
		role_id = 61520,
		weight  = 12
	};
get(61521) ->
	#cfg_role_call{
		role_id = 61521,
		weight  = 12
	};
get(61522) ->
	#cfg_role_call{
		role_id = 61522,
		weight  = 12
	};
get(61523) ->
	#cfg_role_call{
		role_id = 61523,
		weight  = 12
	};
get(61524) ->
	#cfg_role_call{
		role_id = 61524,
		weight  = 12
	};
get(61525) ->
	#cfg_role_call{
		role_id = 61525,
		weight  = 12
	};
get(61526) ->
	#cfg_role_call{
		role_id = 61526,
		weight  = 12
	};
get(61527) ->
	#cfg_role_call{
		role_id = 61527,
		weight  = 12
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_role_call_super:get(~p) not_match", [A]),
 not_match.

length() ->
 27.

id_list() ->
 [61501, 61502, 61503, 61504, 61505, 61506, 61507, 61508, 61509, 61510, 61511, 61512, 61513, 61514, 61515, 61516, 61517, 61518, 61519, 61520, 61521, 61522, 61523, 61524, 61525, 61526, 61527].

all() ->[data_role_call_super:get(ID) || ID<-id_list()].
