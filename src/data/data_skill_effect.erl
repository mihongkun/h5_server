%% this file is auto maked!
-module(data_skill_effect).
-include("data_skill_effect.hrl").
-compile(export_all).

%% Z-战斗\技能效果表-Effects.xlsx

get(65001011) ->
	#cfg_skill_effect{
		id              = 65001011,
		desc            = "巫妖王普攻伤害",
		filters         = [1001],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 10000,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [0],
		buff_rate       = 0,
		buff_round      = 0,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 0,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001111) ->
	#cfg_skill_effect{
		id              = 65001111,
		desc            = "巫妖王大招单体",
		filters         = [1001],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 15000,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [0],
		buff_rate       = 0,
		buff_round      = 0,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 0,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001112) ->
	#cfg_skill_effect{
		id              = 65001112,
		desc            = "巫妖王大招全体",
		filters         = [1005,2002],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 0,
		effect_tar      = [2],
		effect_attri    = hp,
		effect_per      = 600,
		effect_value    = 0,
		buff_id         = [65001112],
		buff_rate       = 10000,
		buff_round      = 3,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 3,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001211) ->
	#cfg_skill_effect{
		id              = 65001211,
		desc            = "霜之哀伤前排伤害",
		filters         = [1005,2003],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 10500,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [65001211],
		buff_rate       = 2500,
		buff_round      = 2,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 2,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001311) ->
	#cfg_skill_effect{
		id              = 65001311,
		desc            = "灵魂收割自身buff",
		filters         = [1002],
		re_tar          = 0,
		effect_type     = 3,
		effect_atk_rate = 0,
		effect_tar      = [1],
		effect_attri    = hp,
		effect_per      = 1000,
		effect_value    = 0,
		buff_id         = [65001311,65001312],
		buff_rate       = 10000,
		buff_round      = 0,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 0,
		next_circuit    = 0,
		next_effects    = [0]
	};
get(65001411) ->
	#cfg_skill_effect{
		id              = 65001411,
		desc            = "打上鲜血印记",
		filters         = [1005,2002],
		re_tar          = 0,
		effect_type     = 0,
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [0],
		buff_rate       = 0,
		buff_round      = 0,
		mark_id         = [65001411],
		mark_rate       = 10000,
		mark_round      = 2,
		next_circuit    = 0,
		next_effects    = [0]
	};
get(65001121) ->
	#cfg_skill_effect{
		id              = 65001121,
		desc            = "巫妖王大招单体2",
		filters         = [1001],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 15000,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [0],
		buff_rate       = 0,
		buff_round      = 0,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 0,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001122) ->
	#cfg_skill_effect{
		id              = 65001122,
		desc            = "巫妖王大招全体2",
		filters         = [1005,2002],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 0,
		effect_tar      = [2],
		effect_attri    = hp,
		effect_per      = 600,
		effect_value    = 0,
		buff_id         = [65001122],
		buff_rate       = 10000,
		buff_round      = 3,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 3,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001221) ->
	#cfg_skill_effect{
		id              = 65001221,
		desc            = "霜之哀伤前排伤害2",
		filters         = [1005,2003],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 10500,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [65001221],
		buff_rate       = 2500,
		buff_round      = 2,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 2,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001321) ->
	#cfg_skill_effect{
		id              = 65001321,
		desc            = "灵魂收割自身buff2",
		filters         = [1002],
		re_tar          = 0,
		effect_type     = 3,
		effect_atk_rate = 0,
		effect_tar      = [1],
		effect_attri    = hp,
		effect_per      = 1000,
		effect_value    = 0,
		buff_id         = [65001321,65001322],
		buff_rate       = 10000,
		buff_round      = 0,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 0,
		next_circuit    = 0,
		next_effects    = [0]
	};
get(65001421) ->
	#cfg_skill_effect{
		id              = 65001421,
		desc            = "打上鲜血印记2",
		filters         = [1005,2002],
		re_tar          = 0,
		effect_type     = 0,
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [0],
		buff_rate       = 0,
		buff_round      = 0,
		mark_id         = [65001421],
		mark_rate       = 10000,
		mark_round      = 2,
		next_circuit    = 0,
		next_effects    = [0]
	};
get(65001131) ->
	#cfg_skill_effect{
		id              = 65001131,
		desc            = "巫妖王大招单体3",
		filters         = [1001],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 15000,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [0],
		buff_rate       = 0,
		buff_round      = 0,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 0,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001132) ->
	#cfg_skill_effect{
		id              = 65001132,
		desc            = "巫妖王大招全体3",
		filters         = [1005,2002],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 0,
		effect_tar      = [2],
		effect_attri    = hp,
		effect_per      = 600,
		effect_value    = 0,
		buff_id         = [65001132],
		buff_rate       = 10000,
		buff_round      = 3,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 3,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001231) ->
	#cfg_skill_effect{
		id              = 65001231,
		desc            = "霜之哀伤前排伤害3",
		filters         = [1005,2003],
		re_tar          = 0,
		effect_type     = 1,
		effect_atk_rate = 10500,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [65001231],
		buff_rate       = 2500,
		buff_round      = 2,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 2,
		next_circuit    = 2,
		next_effects    = [0]
	};
get(65001331) ->
	#cfg_skill_effect{
		id              = 65001331,
		desc            = "灵魂收割自身buff3",
		filters         = [1002],
		re_tar          = 0,
		effect_type     = 3,
		effect_atk_rate = 0,
		effect_tar      = [1],
		effect_attri    = hp,
		effect_per      = 1000,
		effect_value    = 0,
		buff_id         = [65001331,65001332],
		buff_rate       = 10000,
		buff_round      = 0,
		mark_id         = [0],
		mark_rate       = 0,
		mark_round      = 0,
		next_circuit    = 0,
		next_effects    = [0]
	};
get(65001431) ->
	#cfg_skill_effect{
		id              = 65001431,
		desc            = "打上鲜血印记3",
		filters         = [1005,2002],
		re_tar          = 0,
		effect_type     = 0,
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_per      = 0,
		effect_value    = 0,
		buff_id         = [0],
		buff_rate       = 0,
		buff_round      = 0,
		mark_id         = [65001431],
		mark_rate       = 10000,
		mark_round      = 2,
		next_circuit    = 0,
		next_effects    = [0]
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_skill_effect:get(~p) not_match", [A]),
 not_match.

length() ->
 16.

id_list() ->
 [65001011, 65001111, 65001112, 65001211, 65001311, 65001411, 65001121, 65001122, 65001221, 65001321, 65001421, 65001131, 65001132, 65001231, 65001331, 65001431].

all() ->[data_skill_effect:get(ID) || ID<-id_list()].
