%% 主动技能
%% 2018-5-23 laojiajie@gmail.com

-module(skill).
-include("battle.hrl").
-compile(export_all).


%% 选一个技能使用
handle(Battle,Entity,PosList) ->
	SkillID = battle_util:find_skill(Entity),
	% ?DBG(battle,"skill:handle = ~p =~p = ~p",[Entity#entity.pos,Entity#entity.skills,SkillID]),
	Skill = data_skill:get(SkillID),
	{Battle1,AngryRate,IsSkill} = 
	case Skill#cfg_skill.angry_const > 0 of
		true ->	% 怒气技能扣除全部怒气,溢出部分折算成附加伤害
			{battle_util:enter_entity(Battle,Entity#entity{cur_angry = 0}),Entity#entity.cur_angry/Skill#cfg_skill.angry_const,true};
		false ->
			{Battle,1,false}
	end,
	skill_effect:handle(Battle1,Entity#entity{cur_skill = Skill,is_skill = IsSkill,angry_rate = AngryRate},PosList).
	




