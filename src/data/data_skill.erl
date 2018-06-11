%% this file is auto maked!
-module(data_skill).
-include("data_skill.hrl").
-compile(export_all).

%% Z-战斗\技能表-Skill.xlsx

get(6500101) ->
	#cfg_skill{
		id           = 6500101,
		name         = "挥砍",
		desc         = "",
		skill_lv     = 1,
		pri          = 1,
		angry_const  = 0,
		type         = 1,
		use_type     = 1,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 50,
		def_angry    = 15,
		near_far     = 2,
		range        = 1,
		can_dodge    = 1,
		attri        = [0],
		triger_skill = [0],
		circuit      = 1,
		effects      = [65001011]
	};
get(6500111) ->
	#cfg_skill{
		id           = 6500111,
		name         = "死亡凋零",
		desc         = "",
		skill_lv     = 1,
		pri          = 3,
		angry_const  = 100,
		type         = 2,
		use_type     = 2,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 15,
		near_far     = 2,
		range        = 1,
		can_dodge    = 1,
		attri        = [0],
		triger_skill = [0],
		circuit      = 2,
		effects      = [65001111,65001112]
	};
get(6500121) ->
	#cfg_skill{
		id           = 6500121,
		name         = "霜之哀伤",
		desc         = "",
		skill_lv     = 1,
		pri          = 2,
		angry_const  = 0,
		type         = 3,
		use_type     = 1,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 50,
		def_angry    = 15,
		near_far     = 2,
		range        = 1,
		can_dodge    = 1,
		attri        = [0],
		triger_skill = [0],
		circuit      = 1,
		effects      = [65001211]
	};
get(6500131) ->
	#cfg_skill{
		id           = 6500131,
		name         = "灵魂收割",
		desc         = "",
		skill_lv     = 1,
		pri          = 0,
		angry_const  = 0,
		type         = 4,
		use_type     = 3,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 0,
		near_far     = 0,
		range        = 0,
		can_dodge    = 0,
		attri        = [0],
		triger_skill = [65001311],
		circuit      = 0,
		effects      = [65001311]
	};
get(6500141) ->
	#cfg_skill{
		id           = 6500141,
		name         = "鲜血印记",
		desc         = "",
		skill_lv     = 1,
		pri          = 0,
		angry_const  = 0,
		type         = 5,
		use_type     = 3,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 0,
		near_far     = 0,
		range        = 0,
		can_dodge    = 0,
		attri        = [0],
		triger_skill = [65001411],
		circuit      = 0,
		effects      = [65001411]
	};
get(6500112) ->
	#cfg_skill{
		id           = 6500112,
		name         = "死亡凋零",
		desc         = "",
		skill_lv     = 2,
		pri          = 3,
		angry_const  = 100,
		type         = 2,
		use_type     = 2,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 15,
		near_far     = 2,
		range        = 1,
		can_dodge    = 1,
		attri        = [0],
		triger_skill = [0],
		circuit      = 2,
		effects      = [65001121,65001122]
	};
get(6500122) ->
	#cfg_skill{
		id           = 6500122,
		name         = "霜之哀伤",
		desc         = "",
		skill_lv     = 2,
		pri          = 2,
		angry_const  = 0,
		type         = 3,
		use_type     = 1,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 50,
		def_angry    = 15,
		near_far     = 2,
		range        = 1,
		can_dodge    = 1,
		attri        = [0],
		triger_skill = [0],
		circuit      = 1,
		effects      = [65001221]
	};
get(6500132) ->
	#cfg_skill{
		id           = 6500132,
		name         = "灵魂收割",
		desc         = "",
		skill_lv     = 2,
		pri          = 0,
		angry_const  = 0,
		type         = 4,
		use_type     = 3,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 0,
		near_far     = 0,
		range        = 0,
		can_dodge    = 0,
		attri        = [0],
		triger_skill = [65001321],
		circuit      = 0,
		effects      = [65001321]
	};
get(6500142) ->
	#cfg_skill{
		id           = 6500142,
		name         = "鲜血印记",
		desc         = "",
		skill_lv     = 2,
		pri          = 0,
		angry_const  = 0,
		type         = 5,
		use_type     = 3,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 0,
		near_far     = 0,
		range        = 0,
		can_dodge    = 0,
		attri        = [0],
		triger_skill = [65001421],
		circuit      = 0,
		effects      = [65001421]
	};
get(6500113) ->
	#cfg_skill{
		id           = 6500113,
		name         = "死亡凋零",
		desc         = "",
		skill_lv     = 3,
		pri          = 3,
		angry_const  = 100,
		type         = 2,
		use_type     = 2,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 15,
		near_far     = 2,
		range        = 1,
		can_dodge    = 1,
		attri        = [0],
		triger_skill = [0],
		circuit      = 2,
		effects      = [65001131,65001132]
	};
get(6500123) ->
	#cfg_skill{
		id           = 6500123,
		name         = "霜之哀伤",
		desc         = "",
		skill_lv     = 3,
		pri          = 2,
		angry_const  = 0,
		type         = 3,
		use_type     = 1,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 50,
		def_angry    = 15,
		near_far     = 2,
		range        = 1,
		can_dodge    = 1,
		attri        = [0],
		triger_skill = [0],
		circuit      = 1,
		effects      = [65001231]
	};
get(6500133) ->
	#cfg_skill{
		id           = 6500133,
		name         = "灵魂收割",
		desc         = "",
		skill_lv     = 3,
		pri          = 0,
		angry_const  = 0,
		type         = 4,
		use_type     = 3,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 0,
		near_far     = 0,
		range        = 0,
		can_dodge    = 0,
		attri        = [0],
		triger_skill = [65001331],
		circuit      = 0,
		effects      = [65001331]
	};
get(6500143) ->
	#cfg_skill{
		id           = 6500143,
		name         = "鲜血印记",
		desc         = "",
		skill_lv     = 3,
		pri          = 0,
		angry_const  = 0,
		type         = 5,
		use_type     = 3,
		icon         = "",
		action_id    = "",
		dead_use     = 2,
		atk_angry    = 0,
		def_angry    = 0,
		near_far     = 0,
		range        = 0,
		can_dodge    = 0,
		attri        = [0],
		triger_skill = [65001431],
		circuit      = 0,
		effects      = [65001431]
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_skill:get(~p) not_match", [A]),
 not_match.

length() ->
 13.

id_list() ->
 [6500101, 6500111, 6500121, 6500131, 6500141, 6500112, 6500122, 6500132, 6500142, 6500113, 6500123, 6500133, 6500143].

all() ->[data_skill:get(ID) || ID<-id_list()].
