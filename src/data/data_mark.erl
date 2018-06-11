%% this file is auto maked!
-module(data_mark).
-include("data_mark.hrl").
-compile(export_all).

%% Z-战斗\印记表.xlsx

get(1) ->
	#cfg_mark{
		id               = 1,
		group            = 1,
		name             = "鲜血印记（被攻击时，攻击者治疗生命上限15%的血量）",
		act_type         = 1,
		act_skill        = [0],
		act_tar          = 3,
		effect_times     = 0,
		effect_type      = 2,
		effect_value     = 0,
		effect_value_max = 0,
		effect_tar       = 3,
		effect_attri     = maxhp,
		effect_per       = 1500,
		effect_per_max   = 0
	};
get(2) ->
	#cfg_mark{
		id               = 2,
		group            = 2,
		name             = "暴击印记（被暴击时，额外受到施加者120%的攻击伤害）",
		act_type         = 5,
		act_skill        = [0],
		act_tar          = 2,
		effect_times     = 1,
		effect_type      = 1,
		effect_value     = 0,
		effect_value_max = 0,
		effect_tar       = 2,
		effect_attri     = attack,
		effect_per       = 12000,
		effect_per_max   = 0
	};
get(3) ->
	#cfg_mark{
		id               = 3,
		group            = 3,
		name             = "能量印记（被攻击时，额外增加攻击者10点能量，印记持续两回合）",
		act_type         = 1,
		act_skill        = [0],
		act_tar          = 3,
		effect_times     = 0,
		effect_type      = 3,
		effect_value     = 10,
		effect_value_max = 0,
		effect_tar       = 0,
		effect_attri     = 0,
		effect_per       = 0,
		effect_per_max   = 0
	};
get(65001411) ->
	#cfg_mark{
		id               = 65001411,
		group            = 650014,
		name             = "鲜血印记（被攻击时，攻击者治疗生命上限15%的血量）",
		act_type         = 1,
		act_skill        = [0],
		act_tar          = 3,
		effect_times     = 0,
		effect_type      = 2,
		effect_value     = 0,
		effect_value_max = 0,
		effect_tar       = 3,
		effect_attri     = maxhp,
		effect_per       = 1500,
		effect_per_max   = 0
	};
get(65001421) ->
	#cfg_mark{
		id               = 65001421,
		group            = 650014,
		name             = "鲜血印记（被攻击时，攻击者治疗生命上限15%的血量）",
		act_type         = 1,
		act_skill        = [0],
		act_tar          = 3,
		effect_times     = 0,
		effect_type      = 2,
		effect_value     = 0,
		effect_value_max = 0,
		effect_tar       = 3,
		effect_attri     = maxhp,
		effect_per       = 1500,
		effect_per_max   = 0
	};
get(65001431) ->
	#cfg_mark{
		id               = 65001431,
		group            = 650014,
		name             = "鲜血印记（被攻击时，攻击者治疗生命上限15%的血量）",
		act_type         = 1,
		act_skill        = [0],
		act_tar          = 3,
		effect_times     = 0,
		effect_type      = 2,
		effect_value     = 0,
		effect_value_max = 0,
		effect_tar       = 3,
		effect_attri     = maxhp,
		effect_per       = 1500,
		effect_per_max   = 0
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_mark:get(~p) not_match", [A]),
 not_match.

length() ->
 6.

id_list() ->
 [1, 2, 3, 65001411, 65001421, 65001431].

all() ->[data_mark:get(ID) || ID<-id_list()].
