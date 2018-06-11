%% this file is auto maked!
-module(data_buff).
-include("data_buff.hrl").
-compile(export_all).

%% Z-战斗\Buff表-Buff.xlsx

get(65001112) ->
	#cfg_buff{
		id              = 65001112,
		type            = 2,
		desc            = 0,
		attri_type      = 0,
		attri_v_type    = 0,
		attri_value     = 0,
		effect_type     = 4,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [2],
		effect_attri    = hp,
		effect_rate     = 600,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 0,
		cover_times     = 0,
		add_jump        = 1
	};
get(65001211) ->
	#cfg_buff{
		id              = 65001211,
		type            = 3,
		desc            = 0,
		attri_type      = 0,
		attri_v_type    = 0,
		attri_value     = 0,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = freeze,
		status_effect   = "",
		cover           = 0,
		cover_times     = 0,
		add_jump        = 0
	};
get(65001311) ->
	#cfg_buff{
		id              = 65001311,
		type            = 1,
		desc            = 0,
		attri_type      = atk,
		attri_v_type    = 1,
		attri_value     = 1000,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 1,
		cover_times     = 999,
		add_jump        = 0
	};
get(65001312) ->
	#cfg_buff{
		id              = 65001312,
		type            = 1,
		desc            = 0,
		attri_type      = def,
		attri_v_type    = 1,
		attri_value     = 1500,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 1,
		cover_times     = 999,
		add_jump        = 0
	};
get(65001122) ->
	#cfg_buff{
		id              = 65001122,
		type            = 2,
		desc            = 0,
		attri_type      = 0,
		attri_v_type    = 0,
		attri_value     = 0,
		effect_type     = 4,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [2],
		effect_attri    = hp,
		effect_rate     = 600,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 0,
		cover_times     = 0,
		add_jump        = 1
	};
get(65001221) ->
	#cfg_buff{
		id              = 65001221,
		type            = 3,
		desc            = 0,
		attri_type      = 0,
		attri_v_type    = 0,
		attri_value     = 0,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = freeze,
		status_effect   = "",
		cover           = 0,
		cover_times     = 0,
		add_jump        = 0
	};
get(65001321) ->
	#cfg_buff{
		id              = 65001321,
		type            = 1,
		desc            = 0,
		attri_type      = atk,
		attri_v_type    = 1,
		attri_value     = 1000,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 1,
		cover_times     = 999,
		add_jump        = 0
	};
get(65001322) ->
	#cfg_buff{
		id              = 65001322,
		type            = 1,
		desc            = 0,
		attri_type      = def,
		attri_v_type    = 1,
		attri_value     = 1500,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 1,
		cover_times     = 999,
		add_jump        = 0
	};
get(65001132) ->
	#cfg_buff{
		id              = 65001132,
		type            = 2,
		desc            = 0,
		attri_type      = 0,
		attri_v_type    = 0,
		attri_value     = 0,
		effect_type     = 4,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [2],
		effect_attri    = hp,
		effect_rate     = 600,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 0,
		cover_times     = 0,
		add_jump        = 1
	};
get(65001231) ->
	#cfg_buff{
		id              = 65001231,
		type            = 3,
		desc            = 0,
		attri_type      = 0,
		attri_v_type    = 0,
		attri_value     = 0,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = freeze,
		status_effect   = "",
		cover           = 0,
		cover_times     = 0,
		add_jump        = 0
	};
get(65001331) ->
	#cfg_buff{
		id              = 65001331,
		type            = 1,
		desc            = 0,
		attri_type      = atk,
		attri_v_type    = 1,
		attri_value     = 1000,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 1,
		cover_times     = 999,
		add_jump        = 0
	};
get(65001332) ->
	#cfg_buff{
		id              = 65001332,
		type            = 1,
		desc            = 0,
		attri_type      = def,
		attri_v_type    = 1,
		attri_value     = 1500,
		effect_type     = 0,
		icon            = "",
		effect_atk_rate = 0,
		effect_tar      = [0],
		effect_attri    = 0,
		effect_rate     = 0,
		effect_value    = 0,
		status          = 0,
		status_effect   = "",
		cover           = 1,
		cover_times     = 999,
		add_jump        = 0
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_buff:get(~p) not_match", [A]),
 not_match.

length() ->
 12.

id_list() ->
 [65001112, 65001211, 65001311, 65001312, 65001122, 65001221, 65001321, 65001322, 65001132, 65001231, 65001331, 65001332].

all() ->[data_buff:get(ID) || ID<-id_list()].
