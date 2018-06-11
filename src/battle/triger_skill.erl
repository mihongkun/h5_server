%% 触发技能
%% 2018-5-23 laojiajie@gmail.com

-module(triger_skill).
-include("battle.hrl").
-include("common.hrl").
-compile(export_all).





% 使用主动技能并造成伤害(首次触发)
handle_atk(Battle,AtkEntity,DefEntity,HurtEvent=#ps_hurt_event{hp_shows = []},NewHurtEvent=#ps_hurt_event{hp_shows = [Hurt|Res]}) when Hurt < 0 ->
	Skill = AtkEntity#entity.cur_skill,
	{Battle1,SkillSteps1} = find_triger_skill(Battle,DefEntity,AtkEntity,?TRIGER_ENTITY_SELF,?TRIGER_ACTION_BE_ATK),
	{Battle2,SkillSteps2} = find_firend_triger_skill(Battle1,DefEntity,AtkEntity,?TRIGER_ENTITY_FRIEND,?TRIGER_ACTION_BE_ATK),
	case DefEntity#entity.cur_hp == 0 of
		true ->
			%死亡处理
			{Battle3,SkillSteps3} = handle_dead(Battle2,AtkEntity,DefEntity),
			{Battle3,SkillSteps1++SkillSteps2++SkillSteps3};
		false ->
			{Battle2,SkillSteps1++SkillSteps2}
	end;

handle_atk(Battle,AtkEntity,DefEntity,HurtEvent,NewHurtEvent) ->
	{Battle,[]}.




handle_attri(Battle,AtkEntity,DefEntity,HurtEvent,NewHurtEvent) ->
	{Battle,[]}.




handle_heal(Battle,AtkEntity,DefEntity,HurtEvent,NewHurtEvent) ->
	{Battle,[]}.

% 死亡
handle_dead(Battle,AtkEntity,DefEntity) ->
	
	Skill = AtkEntity#entity.cur_skill,
	{Battle1,SkillSteps1} = find_triger_skill(Battle,DefEntity,DefEntity,?TRIGER_ENTITY_SELF,?TRIGER_ACTION_DIE),
	{Battle2,SkillSteps2} = find_firend_triger_skill(Battle1,DefEntity,AtkEntity,?TRIGER_ENTITY_FRIEND,?TRIGER_ACTION_DIE),
	{Battle3,SkillSteps3} = find_triger_skill(Battle2,AtkEntity,DefEntity,?TRIGER_ENTITY_ENEMY,?TRIGER_ACTION_DIE),
	{Battle4,SkillSteps4} = find_firend_triger_skill(Battle3,AtkEntity,DefEntity,?TRIGER_ENTITY_ENEMY,?TRIGER_ACTION_DIE),
	?DBG(triger_skill,"handle_dead = ~p ",[SkillSteps1++SkillSteps2++SkillSteps3++SkillSteps4]),
	{Battle4,SkillSteps1++SkillSteps2++SkillSteps3++SkillSteps4}.

find_triger_skill(Battle,Entity,TarEntity,FriendEntity,TrigerType,TrigerAction) ->
	{SkillIDs,NewEntity} = match_triger_skill(Entity,TrigerType,TrigerAction),

	SkillSteps = [#add_skill{
       				pos         = Entity#entity.pos,        % 站位
			        skill_id    = SkillID,        % 技能
			        tar_pos     = [Entity#entity.pos,TarEntity#entity.pos,FriendEntity#entity.pos]} || SkillID <- SkillIDs],
	{battle_util:enter_entity(Battle,NewEntity),SkillSteps}.

find_triger_skill(Battle,Entity,TarEntity,TrigerType,TrigerAction) ->
	{SkillIDs,NewEntity} = match_triger_skill(Entity,TrigerType,TrigerAction),
	

	SkillSteps = [#add_skill{
       				pos         = Entity#entity.pos,        % 站位
			        skill_id    = SkillID,        % 技能
			        tar_pos     = [Entity#entity.pos,TarEntity#entity.pos]         % 对象
			    } || SkillID <- SkillIDs],
	{battle_util:enter_entity(Battle,NewEntity),SkillSteps}.


find_firend_triger_skill(Battle,Entity,TarEntity,TrigerType,TrigerAction) ->
	FriendEntitys = battle_util:get_friend_entities_not_dead(Battle,Entity),
	Fun = fun(Entity1,{Battle1,SkillSteps1})->
		{Battle2,SkillSteps2} = find_triger_skill(Battle1,Entity1,TarEntity,Entity,TrigerType,TrigerAction),
		{Battle2,SkillSteps1++SkillSteps2}
	end,
	lists:foldl(Fun,{Battle,[]},FriendEntitys).



match_triger_skill(Entity,TrigerType,TrigerAction) ->
	{SkillIDs,NewTrigerSkill} = match_triger_skill_helper(Entity#entity.triger_skills,TrigerType,TrigerAction,{[],[]}),
	{SkillIDs,Entity#entity{triger_skills = NewTrigerSkill}}.

match_triger_skill_helper([],TrigerType,TrigerAction,{SkillIDs,NewTrigerSkill}) ->
	{SkillIDs,NewTrigerSkill};

match_triger_skill_helper([TrigerSkill=#triger_skill{cfg_id = CfgID, times = Times}|Res],TrigerType,TrigerAction,{SkillIDs,NewTrigerSkill}) when Times > 0 ->
	CfgTrigerSkill = data_triger_skill:get(CfgID),
	case CfgTrigerSkill#cfg_triger_skill.tar == TrigerType 
		andalso lists:member(TrigerAction,CfgTrigerSkill#cfg_triger_skill.pos) == true
		andalso (CfgTrigerSkill#cfg_triger_skill.rate >= 10000 orelse util:rand(1,10000) =< CfgTrigerSkill#cfg_triger_skill.rate)
		of
		true ->
			match_triger_skill_helper(Res,TrigerType,TrigerAction,{SkillIDs++CfgTrigerSkill#cfg_triger_skill.skill,[TrigerSkill#triger_skill{times = Times - 1}|NewTrigerSkill]});
		false ->
			match_triger_skill_helper(Res,TrigerType,TrigerAction,{SkillIDs,[TrigerSkill|NewTrigerSkill]})
	end;

match_triger_skill_helper([TrigerSkill|Res],TrigerType,TrigerAction,{SkillIDs,NewTrigerSkill})->
	match_triger_skill_helper(Res,TrigerType,TrigerAction,{SkillIDs,NewTrigerSkill}).

