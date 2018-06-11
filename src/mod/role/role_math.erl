%% 佣兵数值模块
%% 2018-5-2 laojiajie@gmail.com

-module(role_math).
-include("role.hrl").
-include("data_role_grid.hrl").
-include("data_role_star.hrl").
-include("data_role.hrl").
-include("data_role_quality.hrl").
-include("log.hrl").
-compile(export_all).

% 生命 = （（ 英雄初始值 + 英雄等级 * 生命成长 * 英雄星级修正系数 ）* 被动技能修正 * 英雄品级修正系数 * 英雄星级修正系数 + 装备附加值 + 神器附加值 + 法宝附加值 ）* （ 科技修正系数 + 装备修正系数 + 神器修正系数 + 法宝修正系数 ）+ 魔兽附加值
% 攻击 = （（ 英雄初始值 + 英雄等级 * 攻击成长 * 英雄星级修正系数 ）* 被动技能修正 * 英雄品级修正系数 * 英雄星级修正系数 + 装备附加值 + 神器附加值 + 法宝附加值 ）* （ 科技修正系数 + 装备修正系数 + 神器修正系数 + 法宝修正系数 ）+ 魔兽附加值
% 护甲 = （ 英雄初始值 + 英雄等级 * 护甲成长 ）* 被动技能修正 * 魔兽修正值
% 速度 =英雄初始值 + 英雄等级 * 速度成长 * 英雄品级修正系数  + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 能量 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 技能伤害 =英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 命中 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 闪避 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 暴击 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 暴击伤害 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 真实伤害 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 破甲 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 生命吸取 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 减伤率 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值
% 免控率 = 英雄初始值 + 被动技能附加值 + 装备附加值 + 神器附加值 + 法宝附加值 + 科技附加值 + 魔兽附加值



get_lv_max(Star,Quality) when Star >= 7 ->
	Cfg = data_role_star:get(Star),
	Cfg#cfg_role_star.lv_max;

get_lv_max(Star,Quality) ->
	Cfg = data_role_star:get(min(Star,Quality)),
	Cfg#cfg_role_star.lv_max.

build_role_attri(RawRole) ->
	Role = gen_skills(RawRole),
	RoleCfg = data_role:get(Role#role.cfg_id),
	StarCfg = data_role_star:get(Role#role.star),
	QualityCfg = data_role_quality:get(Role#role.quality),
	Hp  = (RoleCfg#cfg_role.hp + Role#role.lv * RoleCfg#cfg_role.hp_grow * StarCfg#cfg_role_star.grow_rate)*StarCfg#cfg_role_star.attri_rate*QualityCfg#cfg_role_quality.hp_rate,
	Def = (RoleCfg#cfg_role.def + Role#role.lv * RoleCfg#cfg_role.def_grow)*QualityCfg#cfg_role_quality.def_rate,
	Atk = (RoleCfg#cfg_role.atk + Role#role.lv * RoleCfg#cfg_role.atk_grow * StarCfg#cfg_role_star.grow_rate)*StarCfg#cfg_role_star.attri_rate*QualityCfg#cfg_role_quality.atk_rate,
	Speed = (RoleCfg#cfg_role.speed + Role#role.lv * RoleCfg#cfg_role.speed_grow )*StarCfg#cfg_role_star.attri_rate*QualityCfg#cfg_role_quality.speed_rate,
	Role1 = Role#role{attri = #attri{
				atk			= erlang:ceil(Atk),
				def 		= erlang:ceil(Def),
				hp  		= erlang:ceil(Hp),
				
				atk_per		= 0,
				def_per		= 0,
				hp_per  	= 0,

				speed 		= erlang:ceil(Speed),
				angry 		= 0,
				%% 二级属性
				skill_hurt	= 0,	%% 技能伤害（万分比）
				hit			= 0,	%% 命中
				dodge		= 0,	%% 闪避
				crit 		= 0,	%% 暴击率
				crit_hurt 	= 0,	%% 暴击伤害（万分比）
				arp 		= 0,	%% 破甲
				bs 			= 0,	%% 吸血
				stun_imm	= 0,	%% 免控率
				hurt_imm 	= 0,	%% 免伤率
				holy_hurt 	= 0 	%% 神圣伤害
	}},
	Role1#role{power = cal_power(Role1#role.attri)}.


cal_power(Attri) ->
	100.



gen_skills(Role) ->
	RoleCfg = data_role:get(Role#role.cfg_id),
	% 普攻
	NormalSKillID = RoleCfg#cfg_role.skill,
	% 技能1
	SkillID1 = 
	case Role#role.quality >= RoleCfg#cfg_role.unlock_1 andalso RoleCfg#cfg_role.unlock_1 > 0 of
		true ->
			SkillLv1 = getSkillLv(RoleCfg#cfg_role.skill_lv_1,Role#role.star,0),
			case SkillLv1 > 0 of
				true ->
					RoleCfg#cfg_role.skill_1*10 + SkillLv1;
				false ->
					0
			end;
		false ->
			0
	end,
	SkillID2 = 
	case Role#role.quality >= RoleCfg#cfg_role.unlock_2 andalso RoleCfg#cfg_role.unlock_2 > 0 of
		true ->
			SkillLv2 = getSkillLv(RoleCfg#cfg_role.skill_lv_2,Role#role.star,0),
			case SkillLv2 > 0 of
				true ->
					RoleCfg#cfg_role.skill_2*10 + SkillLv2;
				false ->
					0
			end;
		false ->
			0
	end,
	SkillID3 = 
	case Role#role.quality >= RoleCfg#cfg_role.unlock_3 andalso RoleCfg#cfg_role.unlock_3 > 0 of
		true ->
			SkillLv3 = getSkillLv(RoleCfg#cfg_role.skill_lv_3,Role#role.star,0),
			case SkillLv3 > 0 of
				true ->
					RoleCfg#cfg_role.skill_3*10 + SkillLv3;
				false ->
					0
			end;
		false ->
			0
	end,
	SkillID4 = 
	case Role#role.quality >= RoleCfg#cfg_role.unlock_4 andalso RoleCfg#cfg_role.unlock_4 > 0 of
		true ->
			SkillLv4 = getSkillLv(RoleCfg#cfg_role.skill_lv_4,Role#role.star,0),
			case SkillLv4 > 0 of
				true ->
					RoleCfg#cfg_role.skill_4*10 + SkillLv4;
				false ->
					0
			end;
		false ->
			0
	end,
	Role#role{skills = [NormalSKillID,SkillID1,SkillID2,SkillID3,SkillID4] -- [0,0,0,0]}.





getSkillLv([Star|Res],MyStar,Lv) when MyStar >= Star ->
	getSkillLv(Res,MyStar,Lv+1);
getSkillLv(StarList,MyStar,Lv) ->
	% ?DBG(role_math,"getSkillLv = ~p star = ~p",[StarList,MyStar]),
	Lv.