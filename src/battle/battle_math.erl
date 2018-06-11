%% 战斗数值计算
%% 2018-5-30 laojiajie@gmail.com

-module(battle_math).
-include("battle.hrl").
-compile(export_all).


% 计算伤害（攻击*技能伤害率*暴击伤害率）
cal_hurt(Battle,Step,Entity,TarEntity,Effect,HurtRate) ->
    Hurt = util:ceil(Entity#entity.attri#attri.atk
    		* (Effect#cfg_skill_effect.effect_atk_rate/?ROLE_ATTRI_DENO)
    		* HurtRate),
    {Hurt,[{Entity#entity.pos,-Hurt}]}.

% 计算治疗（）
cal_heal(Battle,Step,Entity,TarEntity,Effect) ->
    Heal = util:ceil(Entity#entity.attri#attri.atk 
     	*(Effect#cfg_skill_effect.effect_atk_rate/?ROLE_ATTRI_DENO)),
    {Heal,[{Entity#entity.pos,Heal}]}.





get_atk(Entity) ->
	Entity#entity.attri#attri.atk.

get_hp(Entity) ->
	Entity#entity.attri#attri.hp.

get_attri(Entity,?ROLE_ATK) ->
	get_atk(Entity);
get_attri(Entity,?ROLE_HP) ->
	Entity#entity.attri#attri.hp;
get_attri(Entity,?ROLE_CUR_HP) ->
	Entity#entity.cur_hp;
get_attri(Entity,_) ->
	0.

get_buff_hurt_value(Battle,Entity,APos,CfgBuff = #cfg_buff{
													effect_atk_rate = AtkRate,   	% 效果攻击系数 - 单位：1/10000
													effect_tar      = Tars,   		% 效果属性目标 - 1.BUFF来源者 2.BUFF持有者
													effect_attri    = Attri,   		% 效果属性转化 - 属性名
													effect_rate     = Rate,   		% 效果折算比例 - 折算属性比例 万分数
													effect_value    = Value   		% 附加数值 - 额外附加值
					}) ->
	AtkEntity = battle_util:get_entity(Battle,APos),
	AtkValue = battle_math:get_atk(AtkEntity) * AtkRate/10000,
	AtkAttriValue = 
	case lists:member(1,Tars) of
		true ->
			battle_math:get_attri(AtkEntity,Attri)*Rate/10000;
		false ->
			0
	end,
	DefAttriValue = 
	case lists:member(2,Tars) of
		true ->
			battle_math:get_attri(Entity,Attri)*Rate/10000;
		false ->
			0
	end,
	EValueMy = util:ceil(AtkValue+AtkAttriValue+DefAttriValue),
	EValueMy.