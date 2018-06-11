%% buff效果实现
%% 2018-5-23 laojiajie@gmail.com

-module(skill_buff).

-include("battle.hrl").

-compile(export_all).


handle_end(Battle) ->
	PosList = battle_util:get_all_entity_pos(Battle),
	handle_end_helper(Battle,PosList,[],[],[]).

handle_end_helper(Battle,[],BuffEvents,AddSkillSteps,StatcList) ->
	{Battle,BuffEvents,AddSkillSteps,StatcList};
handle_end_helper(Battle,[Pos|Res],BuffEvents,AddSkillSteps,StatcList) ->
	Entity = battle_util:get_entity(Battle,Pos),
	{HurtValue,StatsHurtList,HealValue,StatsHealList} = handle_hurt_helper(Battle,Entity,Entity#entity.buffs,0,[],0,[]),
	{HpEvents1,Entity1,StatsHurtList1} = handle_hurt(Battle,Entity,HurtValue,StatsHurtList), 	% 先结算伤害
	{HpEvents2,Entity2,StatsHurtList2} = handle_heal(Battle,Entity1,HealValue,StatsHealList), 	% 再结算治疗

	case HpEvents1 ++ HpEvents2 of
		[] ->
			handle_end_helper(Battle,Res,BuffEvents,AddSkillSteps,StatcList);
		HpEvents ->
			BuffEvent = #ps_buff_end_event{
						    pos       = Pos, %% integer() 站位
						    buff_hps  = HpEvents  %% list(ps_buff_hp_event) buff加血/扣血
						},
			Battle1 = battle_util:enter_entity(Battle,Entity2),
			handle_end_helper(Battle1,Res,[BuffEvent|BuffEvents],AddSkillSteps,StatsHurtList1++StatsHurtList2++StatcList)
	end.



handle_hurt(Battle,Entity=#entity{cur_hp = 0},HurtValue,StatsHurtList) ->
	{[],Entity,[]};
handle_hurt(Battle,Entity=#entity{buffs = Buffs},HurtValue,StatsHurtList) ->
	case HurtValue > 0 of
		true->
			NewHp = erlang:max(0,Entity#entity.cur_hp - HurtValue),
			% 更新属性
			HpEvent = #ps_buff_hp_event{
			    hp       = NewHp, %% integer() 变化后的血量
			    hp_show  = -HurtValue  %% integer() 展示的伤害(正数为加血,负数为扣血)
			},
			{[HpEvent],Entity#entity{cur_hp = NewHp},StatsHurtList};
		false->
			{[],Entity,[]}
	end.

handle_heal(Battle,Entity=#entity{cur_hp = 0},HealValue,StatsHealList) ->
	{[],Entity,[]};
handle_heal(Battle,Entity=#entity{buffs = Buffs},HealValue,StatsHealList) ->
	
	case HealValue > 0 of
		true->
			NewHp = erlang:min(battle_math:get_hp(Entity),Entity#entity.cur_hp + HealValue),
			% 更新属性
			HpEvent = #ps_buff_hp_event{
			    hp       = NewHp, %% integer() 变化后的血量
			    hp_show  = HealValue  %% integer() 展示的伤害(正数为加血,负数为扣血)
			},
			{[HpEvent],Entity#entity{cur_hp = NewHp},StatsHealList};
		false->
			{[],Entity,[]}
	end.




handle_hurt_helper(Battle,Entity,[],HurtValue,StatsHurtList,HealValue,StatsHealList)->
	{HurtValue,StatsHurtList,HealValue,StatsHealList};

handle_hurt_helper(Battle,Entity,[Buff=#skill_buff{
									        pos    = APos,   % 施加者位置
									        cfg_id = CfgID,  % buff的配置ID
									        e_type = EType, 	 % 作用类型 const@SKILL_BUFF_E_TYPE
									        e_value = EValue 	 % 作用数值(如果为0，每次伤害重新根据属性计算)
    	}|Res],HurtValue,StatsHurtList,HealValue,StatsHealList)->
    case EType of
    	?SKILL_BUFF_E_TYPE_HURT ->
    		AddHurt = 
    		case EValue > 0 of
    			true ->
				    EValue;
				false ->
					CfgBuff = data_buff:get(CfgID),
					battle_math:get_buff_hurt_value(Battle,Entity,APos,CfgBuff)
			end,
			%?DBG(buff,"buff AddHurt = ~p",[AddHurt]),
			handle_hurt_helper(Battle,Entity,Res,HurtValue + AddHurt,[{APos,-AddHurt}|StatsHurtList],HealValue,StatsHealList);
		?SKILL_BUFF_E_TYPE_HEAL ->
			AddHeal =
			case EValue > 0 of
    			true ->
				    EValue;
				false ->
					CfgBuff = data_buff:get(CfgID),
					battle_math:get_buff_hurt_value(Battle,Entity,APos,CfgBuff)
			end,
			%?DBG(buff,"buff AddHeal = ~p",[AddHeal]),
			handle_hurt_helper(Battle,Entity,Res,HurtValue,StatsHurtList,HealValue + AddHeal,[{APos,AddHeal}|StatsHealList]);
		_ ->
			handle_hurt_helper(Battle,Entity,Res,HurtValue,StatsHurtList,HealValue,StatsHealList)
	end.


