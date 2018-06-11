%% this file is auto maked!
-module(data_triger_skill).
-include("data_triger_skill.hrl").
-compile(export_all).

%% Z-战斗\即时技能-Req.xlsx

get(65001311) ->
	#cfg_triger_skill{
		id            = 65001311,
		desc          = "",
		tar           = 2,
		pos           = [9],
		rate          = 10000,
		skill         = [6500131],
		max_times     = 0,
		need_type     =  0,
		need_value    =  0,
		attri_type    = "",
		attri_cp_type =  0
	};
get(65001411) ->
	#cfg_triger_skill{
		id            = 65001411,
		desc          = "",
		tar           = 1,
		pos           = [3],
		rate          = 5000,
		skill         = [6500141],
		max_times     = 0,
		need_type     =  0,
		need_value    =  0,
		attri_type    = "",
		attri_cp_type =  0
	};
get(65001321) ->
	#cfg_triger_skill{
		id            = 65001321,
		desc          = "",
		tar           = 2,
		pos           = [9],
		rate          = 10000,
		skill         = [6500132],
		max_times     = 0,
		need_type     =  0,
		need_value    =  0,
		attri_type    = "",
		attri_cp_type =  0
	};
get(65001421) ->
	#cfg_triger_skill{
		id            = 65001421,
		desc          = "",
		tar           = 1,
		pos           = [3],
		rate          = 5000,
		skill         = [6500142],
		max_times     = 0,
		need_type     =  0,
		need_value    =  0,
		attri_type    = "",
		attri_cp_type =  0
	};
get(65001331) ->
	#cfg_triger_skill{
		id            = 65001331,
		desc          = "",
		tar           = 2,
		pos           = [9],
		rate          = 10000,
		skill         = [6500133],
		max_times     = 0,
		need_type     =  0,
		need_value    =  0,
		attri_type    = "",
		attri_cp_type =  0
	};
get(65001431) ->
	#cfg_triger_skill{
		id            = 65001431,
		desc          = "",
		tar           = 1,
		pos           = [3],
		rate          = 5000,
		skill         = [6500143],
		max_times     = 0,
		need_type     =  0,
		need_value    =  0,
		attri_type    = "",
		attri_cp_type =  0
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_triger_skill:get(~p) not_match", [A]),
 not_match.

length() ->
 6.

id_list() ->
 [65001311, 65001411, 65001321, 65001421, 65001331, 65001431].

all() ->[data_triger_skill:get(ID) || ID<-id_list()].
