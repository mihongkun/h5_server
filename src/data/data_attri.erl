%% this file is auto maked!
-module(data_attri).
-include("data_attri.hrl").
-compile(export_all).

%% Z-战斗\属性表-Ability.xlsx

get(hp) ->
	#cfg_attri{
		key           = hp,
		name          = "最大生命",
		belong        = 1,
		type          = 1,
		v_type        = 1,
		default       = 0,
		max           = 0.0,
		sword         = 16,
		power_formula = "生命战力 = 生命 / 参数",
		hurt_formula  = "生命 = （（ 英雄初始值 + 英雄等级 * 生命成长 * 英雄星级修正系数 ）* （ 1 + 被动技能修正 ） * 英雄品级修正系数 * 英雄星级修正系数 + 装备附加值 + 神器附加值 + 法宝附加值 ）* （ 1+ 科技修正系数 + 装备修正系数 + 神器修正系数 + 法宝修正系数 ）+ 魔兽附加值",
		des           = "英雄最大生命值"
	};
get(atk) ->
	#cfg_attri{
		key           = atk,
		name          = "攻击",
		belong        = 1,
		type          = 1,
		v_type        = 1,
		default       = 0,
		max           = 0.0,
		sword         = 2,
		power_formula = "攻击战力 = 攻击 / 参数",
		hurt_formula  = "攻击 = （（ 英雄初始值 + 英雄等级 * 攻击成长 * 英雄星级修正系数 ）* （ 1 + 被动技能修正 ） * 英雄品级修正系数 * 英雄星级修正系数 + 装备附加值 + 神器附加值 + 法宝附加值 ）* （ 1+ 科技修正系数 + 装备修正系数 + 神器修正系数 + 法宝修正系数 ）+ 魔兽附加值",
		des           = "英雄攻击值"
	};
get(def) ->
	#cfg_attri{
		key           = def,
		name          = "护甲",
		belong        = 1,
		type          = 1,
		v_type        = 1,
		default       = 0,
		max           = 0.0,
		sword         = 10,
		power_formula = "护甲战力 = 护甲 /（ 50 * 英雄等级 + 500 ）* 生命战力 / 参数",
		hurt_formula  = "护甲 = （ 英雄初始值 + 英雄等级 * 护甲成长 ）*  （ 1 + 被动技能修正 ） * （ 1+ 魔兽修正值 ）",
		des           = "英雄护甲值"
	};
get(speed) ->
	#cfg_attri{
		key           = speed,
		name          = "速度",
		belong        = 1,
		type          = 1,
		v_type        = 1,
		default       = 0,
		max           = 0.0,
		sword         = 40000,
		power_formula = "速度战力 =（ 生命战力 + 攻击战力 ）* 速度 / 参数",
		hurt_formula  = "速度 =英雄初始值 + 英雄等级 * 速度成长 * 英雄品级修正系数  + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄速度值"
	};
get(angry) ->
	#cfg_attri{
		key           = angry,
		name          = "能量",
		belong        = 1,
		type          = 3,
		v_type        = 1,
		default       = 0,
		max           = 0.0,
		sword         = 1000,
		power_formula = "能量战力 = 攻击战力 * 能量 / 参数",
		hurt_formula  = "能量 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄初始能量"
	};
get(skill_dmg) ->
	#cfg_attri{
		key           = skill_dmg,
		name          = "技能伤害",
		belong        = 1,
		type          = 1,
		v_type        = 2,
		default       = 0,
		max           = 3.0,
		sword         = 10,
		power_formula = "技能伤害战力 = 攻击战力 * 技能伤害% / 参数",
		hurt_formula  = "技能伤害 =英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄攻击时的伤害系数，伤害 = 攻击 * 伤害系数"
	};
get(hit) ->
	#cfg_attri{
		key           = hit,
		name          = "命中",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 1.5,
		sword         = 10,
		power_formula = "命中战力 = 攻击战力 * 命中% / 参数",
		hurt_formula  = "命中 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄命中率"
	};
get(dodge) ->
	#cfg_attri{
		key           = dodge,
		name          = "闪避",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 0.8,
		sword         = 10,
		power_formula = "闪避战力 = 生命战力 * 闪避% / 参数",
		hurt_formula  = "闪避 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄闪避率"
	};
get(crit) ->
	#cfg_attri{
		key           = crit,
		name          = "暴击",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 1.0,
		sword         = 10,
		power_formula = "暴击战力 = 攻击战力 * 暴击% * 暴击伤害% / 参数",
		hurt_formula  = "暴击 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄暴击率"
	};
get(crit_dmg) ->
	#cfg_attri{
		key           = crit_dmg,
		name          = "暴击伤害",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 2.5,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "暴击伤害 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄暴击伤害"
	};
get(holy_dmg) ->
	#cfg_attri{
		key           = holy_dmg,
		name          = "真实伤害",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 3.0,
		sword         = 10,
		power_formula = "真实伤害战力 = 攻击战力 * 真实伤害% / 参数",
		hurt_formula  = "真实伤害 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄真实伤害，真实伤害在攻击时候额外增加攻击*真实伤害%的最终伤害"
	};
get(arp) ->
	#cfg_attri{
		key           = arp,
		name          = "破甲",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 1.0,
		sword         = 20,
		power_formula = "破甲战力 = 攻击战力 * 破甲% / 参数",
		hurt_formula  = "破甲 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄破甲，在攻击时减伤对方护甲 = 对方护甲*破甲%"
	};
get(bs) ->
	#cfg_attri{
		key           = bs,
		name          = "生命吸取",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 0.4,
		sword         = 10,
		power_formula = "生命吸取战力 = 攻击战力 * 生命吸取% / 参数",
		hurt_formula  = "生命吸取 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄生命吸取，在攻击时获得该次攻击最终伤害*生命吸取%的治疗"
	};
get(hurt_imm) ->
	#cfg_attri{
		key           = hurt_imm,
		name          = "减伤率",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 0.7,
		sword         = 10,
		power_formula = "减伤率战力 = 生命战力 * 减伤率% / 参数",
		hurt_formula  = "减伤率 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄受到伤害时，减少%的伤害"
	};
get(stun_imm) ->
	#cfg_attri{
		key           = stun_imm,
		name          = "免控率",
		belong        = 1,
		type          = 2,
		v_type        = 2,
		default       = 0,
		max           = 1.0,
		sword         = 10,
		power_formula = "免控率战力 = 攻击战力 * 免控率% / 参数",
		hurt_formula  = "免控率 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值",
		des           = "英雄在受到冰冻、晕眩、沉默、石化时，有几率免除该次状态"
	};
get(hp_per) ->
	#cfg_attri{
		key           = hp_per,
		name          = "生命万分比",
		belong        = 1,
		type          = 3,
		v_type        = 1,
		default       = 1,
		max           = 0.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = "生命万分比"
	};
get(atk_per) ->
	#cfg_attri{
		key           = atk_per,
		name          = "攻击万分比",
		belong        = 1,
		type          = 3,
		v_type        = 1,
		default       = 1,
		max           = 0.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = "攻击万分比"
	};
get(def_per) ->
	#cfg_attri{
		key           = def_per,
		name          = "防御万分比",
		belong        = 1,
		type          = 3,
		v_type        = 1,
		default       = 1,
		max           = 0.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = "防御万分比"
	};
get(cur_hp) ->
	#cfg_attri{
		key           = cur_hp,
		name          = "当前生命",
		belong        = 1,
		type          = 4,
		v_type        = 1,
		default       = 0,
		max           = 0.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = "英雄当前生命，当前生命小于等于0时英雄进入死亡状态"
	};
get(career_z) ->
	#cfg_attri{
		key           = career_z,
		name          = "对战士伤害加成",
		belong        = 1,
		type          = 3,
		v_type        = 2,
		default       = 0,
		max           = 2.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = ""
	};
get(career_f) ->
	#cfg_attri{
		key           = career_f,
		name          = "对法师伤害加成",
		belong        = 1,
		type          = 3,
		v_type        = 2,
		default       = 0,
		max           = 2.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = ""
	};
get(career_y) ->
	#cfg_attri{
		key           = career_y,
		name          = "对游侠伤害加成",
		belong        = 1,
		type          = 3,
		v_type        = 2,
		default       = 0,
		max           = 2.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = ""
	};
get(career_c) ->
	#cfg_attri{
		key           = career_c,
		name          = "对刺客伤害加成",
		belong        = 1,
		type          = 3,
		v_type        = 2,
		default       = 0,
		max           = 2.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = ""
	};
get(career_m) ->
	#cfg_attri{
		key           = career_m,
		name          = "对牧师伤害加成",
		belong        = 1,
		type          = 3,
		v_type        = 2,
		default       = 0,
		max           = 2.0,
		sword         = 0,
		power_formula = "",
		hurt_formula  = "",
		des           = ""
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_attri:get(~p) not_match", [A]),
 not_match.

length() ->
 24.

id_list() ->
 ['hp', 'atk', 'def', 'speed', 'angry', 'skill_dmg', 'hit', 'dodge', 'crit', 'crit_dmg', 'holy_dmg', 'arp', 'bs', 'hurt_imm', 'stun_imm', 'hp_per', 'atk_per', 'def_per', 'cur_hp', 'career_z', 'career_f', 'career_y', 'career_c', 'career_m'].

all() ->[data_attri:get(ID) || ID<-id_list()].
