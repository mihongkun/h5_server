%% this file is auto maked!
-module(data_monster).
-include("data_monster.hrl").
-compile(export_all).

%% G-怪物相关配置表\怪物表.xlsx

get(65001) ->
	#cfg_monster{
		id        = 65001,
		name      = "巫妖王",
		model     = 65001,
		icon      = 65001,
		lv        = 1,
		star      = 5,
		hp        = 10000,
		atk       = 1000,
		def       = 1,
		speed     = 1,
		angry     = 50,
		skill_dmg = 0,
		hit       = 0,
		dodge     = 0,
		crit      = 0,
		crit_dmg  = 0,
		holy_dmg  = 0,
		arp       = 0,
		bs        = 0,
		hurt_imm  = 0,
		stun_imm  = 0,
		skill1    = 6500110,
		skill2    = 6500111,
		skill3    = 6500112,
		skill4    = 6500113,
		skill5    = 6500114
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_monster:get(~p) not_match", [A]),
 not_match.

length() ->
 1.

id_list() ->
 [65001].

all() ->[data_monster:get(ID) || ID<-id_list()].
