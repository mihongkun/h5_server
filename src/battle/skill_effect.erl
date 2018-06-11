%% 技能效果实现
%% 2018-5-23 laojiajie@gmail.com

-module(skill_effect).
-include("battle.hrl").
-compile(export_all).


-record(e_args,{
		battle 			= undefined,		%% 战斗结构体
		stats_hurts		= [],				%% 统计伤害列表 [{pos,value}] 少于0为伤害，大于0为治疗
		total_steps 	= [],				%% [#ps_step_event{}] 所有步骤战报
		step 			= #ps_step_event{},	%% 当前技能战报
		add_skil_step 	= [],				%% 额外触发的下一批技能 #add_skil{}
		entity 			= undefined,		%% 当前佣兵
		circuit 		= undefined,		%% 效果互联类型
		cur_eff 		= undefined,		%% 当前效果
		cur_tar 		= undefined,		%% 当前目标
		effects 		= [],				%% 效果ID列表
		pos_list 		= []				%% 目标位置列表
	}).


handle(Battle,Entity,PosList) ->
	% 处理技能效果
	EArgs = handle_effect(#e_args{
			step  = #ps_step_event{
						pos 		= Entity#entity.pos,
						skill_id 	= Entity#entity.cur_skill#cfg_skill.id,
						hurts  		= gb_trees:empty(),
						buffs   	= []
						},
			battle 	= Battle,
			entity 	= Entity,
			circuit = Entity#entity.cur_skill#cfg_skill.circuit,
			effects = Entity#entity.cur_skill#cfg_skill.effects,
			pos_list = PosList
		}),
	% 处理怒气
	EArgs1 = handle_angry(EArgs),
	case battle_util:format_step_gb_trees(EArgs1#e_args.step) of
		#ps_step_event{
						hurts  		= [],
						buffs   	= []
						} ->
			handle_add_skill(EArgs1#e_args{total_steps = EArgs1#e_args.total_steps});
		Step ->
			handle_add_skill(EArgs1#e_args{total_steps = [Step|EArgs1#e_args.total_steps]})
	end.


% 处理额外触发的技能
handle_add_skill(EArgs=#e_args{add_skil_step = []}) ->
	{EArgs#e_args.battle,EArgs#e_args.total_steps,EArgs#e_args.stats_hurts};
handle_add_skill(EArgs=#e_args{
						add_skil_step = [AddSkillStep|ResStep],
						battle = Battle
				}) ->
	#add_skill{
		pos         = Pos,        % 站位
        skill_id    = SkillID,    % 技能
        tar_pos     = PosList     % 对象
	} = AddSkillStep,
	Entity = battle_util:get_entity(Battle,Pos),
	Skill = data_skill:get(SkillID),
	{Battle1,TotalSteps,StatsHurts} = handle(Battle,Entity#entity{cur_skill = Skill},PosList),
	handle_add_skill(EArgs#e_args{
						add_skil_step = ResStep,
						total_steps = [TotalSteps|EArgs#e_args.total_steps],
						stats_hurts = StatsHurts++EArgs#e_args.stats_hurts,
						battle = Battle1
					}).


handle_effect(EArgs=#e_args{effects = [],battle = Battle,step = Step}) ->
	EArgs;

handle_effect(EArgs=#e_args{
							effects 	= [EffectID|EffectIDs],
							circuit 	= Circuit,
							pos_list 	= PosList,
							battle 		= Battle,
							entity 		= Entity
							}) ->
	Effect = data_skill_effect:get(EffectID),
	TarPosList = skill_target_filter:handle(Battle,Entity,Effect,PosList),	%% 选择目标
	EArgs1 = do_effect(EArgs#e_args{pos_list = TarPosList,cur_eff = Effect}),
	%% 处理效果里的效果(可多层嵌套)
	EArgs2 = handle_effect(EArgs1#e_args{
									circuit 	= Effect#cfg_skill_effect.next_circuit, 
									effects 	= Effect#cfg_skill_effect.next_effects--[0],
									pos_list 	= TarPosList
									}),
	NewPosList =
	case Circuit of
		?SKILL_CIRCUIT_SERIES ->
			%% 串联效果-前一个效果截取对象后,后面效果不再作用该对象
			PosList--TarPosList;
		?SKILL_CIRCUIT_PARALLEL ->
			%% 并联效果-效果之间互不干扰	
			PosList;
		_ ->
			PosList
	end,
	handle_effect(EArgs2#e_args{
							pos_list  = NewPosList,
							effects   = EffectIDs
							}).

%% 技能效果处理
do_effect(EArgs=#e_args{pos_list = []}) ->
	EArgs;
do_effect(EArgs=#e_args{
					pos_list 	= [Pos|TarPosList],
					cur_eff 	= Effect,
					battle 		= Battle,
					entity 		= Entity
				}) ->
	TarEntity = battle_util:get_entity(Battle,Pos),
	EArgs1 = EArgs#e_args{cur_tar = TarEntity},
	EArgs2 = hurt_entity(EArgs1),	%% 处理伤害/治疗
	EArgs3 = add_buff(EArgs2),		%% 处理加buff
	do_effect(EArgs3#e_args{pos_list = TarPosList}).


%% 伤害
hurt_entity(EArgs=#e_args{
					step  	= Step=#ps_step_event{
								hurts  	= Hurts
								},

					battle  = Battle,
					cur_eff = Effect=#cfg_skill_effect{id = EffectID,effect_type = EffectType},
					entity 	= Entity,
					cur_tar = TarEntity
				})
				when EffectType == ?SKILL_HUTR_TYPE_ATK_HURT 
				orelse EffectType == ?SKILL_HUTR_TYPE_HURT_HURT ->
	HurtEvent = battle_util:get_hurt_event(Hurts,TarEntity),	% 获取伤害战报 #ps_hurt_event
	{NewHurtEvent,NewBattle,StatsHurts} =
	case battle_util:isDodge(Entity,TarEntity) of % 判断闪避
		true ->
			{HurtEvent#ps_hurt_event{hurt_effect = ?BATTLE_HURT_EFFECT_DODGE},Battle,[]};
		false ->
			{HurtRate,NewHurtEffect} =
			case battle_util:isCrit(Entity,TarEntity) of % 判断暴击
				true  -> {1+1+Entity#entity.attri#attri.crit_hurt/?ROLE_ATTRI_DENO,?BATTLE_HURT_EFFECT_CRIT};
				false -> {1,0}
			end,
			{HurtValue,StatsHurts1} = battle_math:cal_hurt(Battle,Step,Entity,TarEntity,Effect,HurtRate),
			case HurtValue > 0 of
				true ->
					NewHp = erlang:max(0,TarEntity#entity.cur_hp - HurtValue),
					% 更新属性
					Battle1 = battle_util:enter_entity(Battle,TarEntity#entity{cur_hp = NewHp}),
					% 更新战报
					HurtEvent1 = HurtEvent#ps_hurt_event{hurt_effect = NewHurtEffect,hp = NewHp,hp_shows = HurtEvent#ps_hurt_event.hp_shows ++[-HurtValue]},
					{HurtEvent1,Battle1,StatsHurts1};
				false ->
					% 配了伤害效果，缺没配伤害值
					%?ERR(battle,"no hurt value, EffectID = ~p",[EffectID]),
					{undefined,Battle,[]}
			end
	end,
	case NewHurtEvent of
		undefined ->
			EArgs;
		_ ->
			% 被动技能触发
			{NewBattle1,AddSkillSteps} = triger_skill:handle_atk(NewBattle,battle_util:get_entity(NewBattle,Entity#entity.pos),battle_util:get_entity(NewBattle,TarEntity#entity.pos),HurtEvent,NewHurtEvent),
			NewHurts = battle_util:enter_hurt_event(Hurts,NewHurtEvent),
			% ?DBG(battle,"hurt_entity = ~p",[NewHurts]),
			EArgs#e_args{
				step  			= Step#ps_step_event{
									hurts  	= NewHurts
									},
				battle  		= NewBattle1,
				stats_hurts		= StatsHurts ++ EArgs#e_args.stats_hurts,
				add_skil_step 	= AddSkillSteps ++ EArgs#e_args.add_skil_step
			}
	end;


%% 治疗
hurt_entity(EArgs=#e_args{
					step  	= Step=#ps_step_event{
								hurts  	= Hurts
								},
					battle  = Battle,
					cur_eff = Effect=#cfg_skill_effect{effect_type = EffectType},
					entity 	= Entity,
					cur_tar = TarEntity
				})
				when EffectType == ?SKILL_HUTR_TYPE_ATK_HEAL 
				orelse EffectType == ?SKILL_HUTR_TYPE_HURT_HEAL ->
	HurtEvent = battle_util:get_hurt_event(Hurts,TarEntity),	% 获取伤害战报 #ps_hurt_event
	{HealValue,StatsHurts} = battle_math:cal_heal(Battle,Step,Entity,TarEntity,Effect),
	case HealValue > 0 of
		true ->
			NewHp = erlang:min(TarEntity#entity.attri#attri.hp,TarEntity#entity.cur_hp + HealValue),
			% 更新属性
			Battle1 = battle_util:enter_entity(Battle,TarEntity#entity{cur_hp = NewHp}),
			% 更新战报
			HurtEvent1 = HurtEvent#ps_hurt_event{hp = NewHp,hp_shows = HurtEvent#ps_hurt_event.hp_shows ++ [HealValue]},
			% 被动技能触发
			{Battle2,AddSkillSteps} = triger_skill:handle_heal(Battle1,battle_util:get_entity(Battle,Entity#entity.pos),battle_util:get_entity(Battle,TarEntity#entity.pos),HurtEvent,HurtEvent1),
			NewHurts = battle_util:enter_hurt_event(Hurts,HurtEvent1),
			EArgs#e_args{
				step  	= Step#ps_step_event{
							hurts  	= NewHurts
							},
				battle  = Battle2,
				stats_hurts = StatsHurts ++ EArgs#e_args.stats_hurts,
				add_skil_step = AddSkillSteps ++ EArgs#e_args.add_skil_step
			};
		false ->
			EArgs
	end;

hurt_entity(EArgs)->
	EArgs.

%% 加buff
add_buff(EArgs=#e_args{
					step  	= Step=#ps_step_event{
								buffs  	= BuffEvens
								},
					stats_hurts		= StatsHurts,
					battle  = Battle,
					cur_eff = Effect=#cfg_skill_effect{
										effect_type = EffectType,
										buff_id         =  BuffIDs,   	% buff - buffID，调取buff表
										buff_rate       =  BuffRate,   	% buff概率 - 万分数
										buff_round      =  BuffRound,   % buff回合数 - 大回合 0为无限回合
										mark_id         =  MarkIDs,   	% 印记ID - 印记ID，调取印记表
										mark_rate       =  MarkRate,   	% 印记概率 - 万分数
										mark_round      =  MarkRound   % 印记回合数 - 大回合
									},
					entity 	= Entity,
					cur_tar = TarEntity
				}) ->
	{Battle3,ABEvents1,AddStaticHurts} = 
	case util:check_deno(BuffRate) of
		true -> % 附加buff
			{Battle1,Seq} = battle_util:get_seq(Battle),
			LastRound = battle_util:get_last_round(BuffRound),
			AddBuffs = [#skill_buff{
						        pos    = Entity#entity.pos, % 施加者位置
						        id     = Seq, 				% buffID(本场战斗唯一)
						        cfg_id = BuffID, 			% buff的配置ID
						        e_type = battle_util:get_buff_e_type(BuffID), 				% 作用类型 const@SKILL_BUFF_E_TYPE
        						e_value = battle_math:get_buff_hurt_value(Battle,TarEntity,Entity#entity.pos,data_buff:get(BuffID)), 				% 作用数值(如果为0，每次伤害重新根据属性计算)
						        rounds = LastRound  		% 持续回合
						    } || BuffID <- BuffIDs,BuffID /= 0],
			{TarEntity1,AddStaticHurts1} = deal_buff_attach_hurt(TarEntity,AddBuffs,[]),
			AddBuffEvens1 = [#ps_buff_event{
							    pos         = TarEntity#entity.pos,
							    type        = ?BATTLE_BUFF_TYPE_BUFF, 
							    id          = AddBuff#skill_buff.id,
							    cfg_id      = AddBuff#skill_buff.cfg_id,
							    last_round  = AddBuff#skill_buff.rounds,
							    hp 			= TarEntity1#entity.cur_hp,
							    hp_show     = battle_util:get_buff_hurt_value_show(AddBuff#skill_buff.e_type,AddBuff#skill_buff.e_value,data_buff:get(AddBuff#skill_buff.cfg_id))
							} || AddBuff <- AddBuffs],
			
			
			Battle2 = battle_util:enter_entity(Battle1,TarEntity1#entity{buffs = AddBuffs++TarEntity#entity.buffs}),
			{Battle2,AddBuffEvens1,AddStaticHurts1};
		false ->
			{Battle,[],[]}
	end,
	{NewBattle,ABEvents2} = 
	case util:check_deno(MarkRate) of
		true -> % 附加印记
			{Battle4,Seq1} = battle_util:get_seq(Battle3),
			LastRound1 = battle_util:get_last_round(MarkRound),
			AddBuffEvens2 = [#ps_buff_event{
							    pos         = TarEntity#entity.pos, 	%% integer() 站位
							    type        = ?BATTLE_BUFF_TYPE_MARK, 	%% integer() 状态类型 const@BATTLE_BUFF_TYPE
							    id          = Seq1,						%% integer() 附加的buff/mark唯一ID
							    cfg_id      = MarkID, 					%% integer() 附加的buff/mark配置ID
							    last_round  = LastRound1 				%% integer() 持续的回合数
							} || MarkID <- MarkIDs,MarkID /= 0],
			AddMarks = [#skill_mark{
						        pos    = Entity#entity.pos, % 施加者位置
						        id     = Seq1, 				% 印记ID(本场战斗唯一)
						        cfg_id = MarkID, 			% 印记的配置ID
						        rounds = LastRound1, 		% 持续回合
						        times  = battle_util:get_mark_times(MarkID) % 可触发次数
						    }|| MarkID <- MarkIDs,MarkID /= 0],
			Battle5 = battle_util:enter_entity(Battle4,TarEntity#entity{marks = AddMarks++TarEntity#entity.marks}),
			{Battle5,AddBuffEvens2};
		false ->
			{Battle3,[]}
	end,
	AddSkillSteps = [],
	EArgs#e_args{
		step  	= Step#ps_step_event{
					buffs  	= ABEvents2++ABEvents1++BuffEvens
					},
		battle  = NewBattle,
		stats_hurts = AddStaticHurts ++ EArgs#e_args.stats_hurts,
		add_skil_step = AddSkillSteps ++ EArgs#e_args.add_skil_step
	}.

% 处理怒气
handle_angry(EArgs=#e_args{
			step  = Step =#ps_step_event{
						hurts  		= Hurts
						},
			battle 	= Battle,
			entity 	= Entity1=#entity{pos = Pos,cur_skill = Skill}
		}) ->
	{Battle1,Hurts1} = battle_util:add_angry(Battle,Hurts,Pos,Skill#cfg_skill.atk_angry), 	% 释放技能伤害加怒气
	{Battle3,Hurts3} =
	case Skill#cfg_skill.def_angry > 0 of
		true ->
			% 收到技能伤害加怒气
			Fun = fun({Pos1,#ps_hurt_event{hp_shows = HpShows,pos = Pos1}},PostList) ->
				case HpShows of
					[] ->
						PostList;
					[HpShow|_Res] ->
						case HpShow < 0 andalso Pos /= Pos1 of
							true ->
								[Pos1|PostList];
							false ->
								PostList
						end
				end
			end,
			PostList = lists:foldl(Fun,[],gb_trees:to_list(Hurts)),

			Fun2 = fun(Pos2,{Battle2,Hurts2}) ->
				battle_util:add_angry(Battle2,Hurts2,Pos2,Skill#cfg_skill.def_angry)
			end,
			lists:foldl(Fun2,{Battle1,Hurts1},PostList);
		false ->
			{Battle1,Hurts1}
	end,
	EArgs#e_args{
		step  	= Step#ps_step_event{
					hurts  	= Hurts3
					},
		battle  = Battle3
	}.


% buff附加时，根据配置可能会伤害一次目标
deal_buff_attach_hurt(Entity,AddBuffs,StatsHurts) ->
	deal_buff_attach_hurt_helper(Entity,AddBuffs,StatsHurts).

deal_buff_attach_hurt_helper(Entity,[],StatsHurts) ->
	% ?DBG(skill,"deal_buff_attach_hurt",[StatsHurts]),
	{Entity,StatsHurts};

deal_buff_attach_hurt_helper(Entity,[Buff=#skill_buff{
						        pos    = Pos,
						        cfg_id = BuffID,
						        e_type = EType,
        						e_value = EValue
						    		}|Res],StatsHurts) when EType == ?SKILL_BUFF_E_TYPE_HURT andalso EValue > 0 andalso Entity#entity.cur_hp > 0 ->
	BuffCfg = data_buff:get(BuffID),
	case BuffCfg#cfg_buff.add_jump == 1 of
		true ->
			NewHp = erlang:max(0,Entity#entity.cur_hp - EValue),
			deal_buff_attach_hurt_helper(Entity#entity{cur_hp = NewHp},Res,[{Pos,-EValue}|StatsHurts]);
		false ->
			deal_buff_attach_hurt_helper(Entity,Res,StatsHurts)
	end;

deal_buff_attach_hurt_helper(Entity,[Buff=#skill_buff{
						        pos    = Pos,
						        cfg_id = BuffID,
						        e_type = EType,
        						e_value = EValue
						    		}|Res],StatsHurts) when EType == ?SKILL_BUFF_E_TYPE_HEAL andalso EValue > 0 andalso Entity#entity.cur_hp > 0 ->
	BuffCfg = data_buff:get(BuffID),
	case BuffCfg#cfg_buff.add_jump == 1 of
		true ->
			NewHp = erlang:min(Entity#entity.attri#attri.hp,Entity#entity.cur_hp + EValue),
			deal_buff_attach_hurt_helper(Entity#entity{cur_hp = NewHp},Res,[{Pos,EValue}|StatsHurts]);
		false ->
			deal_buff_attach_hurt_helper(Entity,Res,StatsHurts)
	end;

deal_buff_attach_hurt_helper(Entity,[Buff|Res],StatsHurts) ->
	deal_buff_attach_hurt_helper(Entity,Res,StatsHurts).

