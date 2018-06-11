%% 战斗工具
%% 2018-5-22 laojiajie@gmail.com

-module(battle_util).
-include("battle.hrl").
-compile(export_all).


init_battle_report(Battle) ->
	#pt_battle_report{
        battle_id    = 0,   %% integer() 战报ID
        sid          = Battle#battle.sid,   %% integer() 发起者ID
        name         = Battle#battle.name,  %% list() 发起者名字
        level        = Battle#battle.level,   %% integer() 发起者等级
        pic          = Battle#battle.pic,   %% integer() 发起者头像ID
        tar_sid      = Battle#battle.tar_sid,   %% integer() 迎战者ID
        tar_name     = Battle#battle.tar_name,  %% list() 迎战者名字
        tar_level    = Battle#battle.tar_level,   %% integer() 迎战者等级
        tar_pic      = Battle#battle.tar_pic,   %% integer() 迎战者头像ID
        entities     = make_report_entities(gb_trees:to_list(Battle#battle.entities)),  %% list(ps_entity) 佣兵初始化信息
        rounds       = [],  %% list(ps_battle_round) 战斗回合信息
        total_hurts  = gb_trees:empty(),  %% list(ps_total_hurt) 战斗总伤害信息
        rewards      = [],  %% list(ps_reward) 奖励
        result       = 0    %% integer() 战斗结果 const@BATTLE_RESULT
    }.



make_report_entities(Entities) ->
    [#ps_entity{
        pos        = Pos,   %% integer() 站位
        type       = Type,  %% 单位类型
        cfg_id     = CfgID, %% integer() 配置ID
        level      = Level, %% integer() 等级
        star       = Star,  %% integer() 星级
        hp         = CurHp, %% integer() 初始血量
        max_hp     = Attri#attri.hp,     %% integer() 最大血量
        angry      = CurAngry,           %% integer() 初始怒气
        max_angry  = Attri#attri.angry   %% integer() 最大怒气
    } 
    || 
    {_Pos,Entity=#entity{
        cfg_id      = CfgID,        % 配置ID
        type        = Type,         % 单位类型
        pos         = Pos,          % 位置
        star        = Star,         % 星级
        level       = Level,        % 等级
        cur_hp      = CurHp,        % 当前血量
        cur_angry   = CurAngry,     % 当前怒气
        attri       = Attri
    }} <- Entities].

enter_roles(Battle,[]) ->
    Battle;
enter_roles(Battle,[{Pos,Role}|Res]) ->
    Entity = new_entity(Pos,Role),
    Battle1 = enter_entity(Battle,Entity),
    enter_roles(Battle1,Res).


enter_monsters(Battle,BattleCfg =#cfg_battle{
                                    mon_1     = MonID1,
                                    mon_2     = MonID2,
                                    mon_3     = MonID3,
                                    mon_4     = MonID4,
                                    mon_5     = MonID5,
                                    mon_6     = MonID6
                                }) ->
    enter_monsters_helper(Battle,[MonID1,MonID2,MonID3,MonID4,MonID5,MonID6],7).
    
enter_monsters_helper(Battle,[],Pos) ->
    Battle;
enter_monsters_helper(Battle,[MonID|Res],Pos) when MonID > 0 ->
    MonCfg = data_monster:get(MonID),
    Entity = new_entity_by_mon_cfg(Pos,MonCfg),
    Battle1 = enter_entity(Battle,Entity),
    enter_monsters_helper(Battle1,Res,Pos+1);
enter_monsters_helper(Battle,[MonID|Res],Pos) ->
    enter_monsters_helper(Battle,Res,Pos+1).


deal_before_round(Battle) ->
    Entities = gb_trees:to_list(Battle#battle.entities),
    deal_before_round_helper(Battle,Entities).

deal_before_round_helper(Battle,[])->
    Battle;
deal_before_round_helper(Battle,[{Pos,Entity}|Res]) ->
    NewBuffs = rm_expired_buff(Entity#entity.buffs,[]),
    Battle1 = enter_entity(Battle,Entity#entity{active = true,buffs = NewBuffs}),
    deal_before_round_helper(Battle1,Res).


find_next_hand(Battle)->
    Entities = gb_trees:to_list(Battle#battle.entities),
    find_next_hand_helper(Entities,0,[]).

find_next_hand_helper([],MaxSpeed,[]) ->
    undefined;
find_next_hand_helper([],MaxSpeed,[Entity]) ->
    Entity;
% 速度相同，敌方，排位靠前先出手
find_next_hand_helper([],MaxSpeed,[Entity1|Res]) ->
    Fun = fun(Entity,ResultEntity)->
        if 
            Entity#entity.pos < 7 andalso ResultEntity#entity.pos >= 7 -> ResultEntity;
            Entity#entity.pos >= 7 andalso ResultEntity#entity.pos < 7 -> Entity;
            Entity#entity.pos > ResultEntity#entity.pos -> ResultEntity;
            true -> Entity
        end
    end,
    lists:foldl(Fun,Entity1,Res);
find_next_hand_helper([{Pos,Entity=#entity{attri = #attri{speed = Speed},cur_hp = CurHp,active = true}}|Res],MaxSpeed,SelectEntities) when CurHp > 0 andalso Speed > MaxSpeed  ->
    find_next_hand_helper(Res,Speed,[Entity]);
find_next_hand_helper([{Pos,Entity=#entity{attri = #attri{speed = Speed},cur_hp = CurHp,active = true}}|Res],MaxSpeed,SelectEntities) when CurHp > 0 andalso Speed == MaxSpeed  ->
    find_next_hand_helper(Res,Speed,[Entity|SelectEntities]);
find_next_hand_helper([{Pos,Entity}|Res],MaxSpeed,SelectEntities)  ->
    find_next_hand_helper(Res,MaxSpeed,SelectEntities).



is_battle_finish(Battle=#battle{round = Round}) when Round > 15 ->
    {true,?BATTLE_RESULT_LOSE};
is_battle_finish(Battle) ->
	Entities = gb_trees:to_list(Battle#battle.entities),
    is_battle_finish_helper(Entities,{[],[]}).

is_battle_finish_helper([],{[],Team2}) ->
    {true,?BATTLE_RESULT_LOSE};
is_battle_finish_helper([],{Team1,[]}) ->
    {true,?BATTLE_RESULT_WIN};
is_battle_finish_helper(Entities,{[A|Team1],[B|Team2]}) ->
    false;
is_battle_finish_helper([{Pos,Entity}|Res],{Team1,Team2}) when Entity#entity.cur_hp > 0 andalso Pos =< 6 ->
    is_battle_finish_helper(Res,{[Pos|Team1],Team2});
is_battle_finish_helper([{Pos,Entity}|Res],{Team1,Team2}) when Entity#entity.cur_hp > 0 andalso Pos > 6 ->
    is_battle_finish_helper(Res,{Team1,[Pos|Team2]});
is_battle_finish_helper([_First|Res],{Team1,Team2}) ->
    is_battle_finish_helper(Res,{Team1,Team2}).
    


is_alive(Entity)->
    Entity#entity.cur_hp > 0.

enter_entity(Battle,Entity) ->
	Battle#battle{entities = gb_trees:enter(Entity#entity.pos,Entity,Battle#battle.entities)}.
	
get_entity(Battle,Pos) ->
    gb_trees:get(Pos,Battle#battle.entities).

get_all_entity_pos(Battle) ->
    gb_trees:keys(Battle#battle.entities).


get_friend_entities_not_dead(Battle,Entity) ->
    Entities = gb_trees:to_list(Battle#battle.entities),
    [Entity1 || {Pos,Entity1} <- Entities,is_friend(Pos,Entity#entity.pos),Entity1#entity.cur_hp > 0].


is_friend(Pos1,Pos1) -> false;
is_friend(Pos1,Pos2) when Pos1 =< 6 andalso Pos2 =< 6 -> true;
is_friend(Pos1,Pos2) when Pos1 > 6 andalso Pos2 > 6 -> true;
is_friend(Pos1,Pos2) -> false.

is_own(Pos1,Pos1) -> true;
is_own(Pos1,Pos2) when Pos1 =< 6 andalso Pos2 =< 6 -> true;
is_own(Pos1,Pos2) when Pos1 > 6 andalso Pos2 > 6 -> true;
is_own(Pos1,Pos2) -> false.


get_hurt_event(Hurts,Entity) ->
    case gb_trees:lookup(Entity#entity.pos,Hurts) of
        none -> 
            #ps_hurt_event{
                pos         = Entity#entity.pos,        %% integer() 站位
                hp          = Entity#entity.cur_hp,     %% integer() 变化后的血量
                hp_shows    = [],                        %% integer() 展示的伤害(正数为加血,负数为扣血)
                angry       = Entity#entity.cur_angry,  %% integer() 变化后的怒气
                hurt_effect = 0                         %% integer() 效果
            };
        {value,Hurt} ->
            Hurt
    end.

enter_hurt_event(Hurts,HurtEvent)->
    gb_trees:enter(HurtEvent#ps_hurt_event.pos,HurtEvent,Hurts).




trees_to_list(Trees) ->
   [Value || {_Key1,Value} <- gb_trees:to_list(Trees)].


format_step_gb_trees(Step)->
    Step#ps_step_event{
        hurts = [Hurt || {_Key1,Hurt} <- gb_trees:to_list(Step#ps_step_event.hurts)]
    }.


find_skill(Entity=#entity{skills = SkillIDs,cur_angry = CurAngry})->
    find_skill_helper(SkillIDs,0,CurAngry,0).

find_skill_helper([],CurPri,CurAngry,SkillID) ->
    SkillID;
find_skill_helper([SkillID|Res],CurPri,CurAngry,CurSkillID) ->
    CfgSKill = data_skill:get(SkillID),
    case CfgSKill#cfg_skill.angry_const =< CurAngry andalso
        CfgSKill#cfg_skill.pri > 0 andalso
        CfgSKill#cfg_skill.pri > CurPri
        of
    true ->
        find_skill_helper(Res,CfgSKill#cfg_skill.pri,CurAngry,SkillID);
    false ->
        find_skill_helper(Res,CurPri,CurAngry,CurSkillID)
    end.


isDodge(Entity,TarEntity) ->
    false.


isCrit(Entity,TarEntity) ->
    util:rand(1,?ROLE_ATTRI_DENO) < 5000.


get_seq(Battle)->
    Seq = Battle#battle.seq,
    {Battle#battle{seq = Seq +1},Seq}.



get_last_round(Round) ->
    case Round == 0 of
        true ->
            99;
        false->
            Round
    end.


get_mark_times(MarkID) ->
    CfgMark = data_mark:get(MarkID),
    case CfgMark#cfg_mark.effect_times == 0 of
        true ->
            999;
        false ->
            CfgMark#cfg_mark.effect_times
    end.


add_angry(Battle,Hurts,Pos,0) ->
    {Battle,Hurts};
add_angry(Battle,Hurts,Pos,AddValue) ->
    Entity = get_entity(Battle,Pos),
    case add_angry_helper(Battle,Entity,AddValue) of
        {Battle1,NewAngry} ->
            HurtEvent = get_hurt_event(Hurts,Entity),
            NewHurts  = enter_hurt_event(Hurts,HurtEvent#ps_hurt_event{angry = NewAngry}),
            {Battle1,NewHurts};
        false ->
            {Battle,Hurts}
    end.
       

add_angry_helper(Battle,Entity=#entity{cur_angry = CurAngry},AddValue) ->
    case CurAngry >= ?BATTLE_MAX_ANGRY of
        true ->
            false;
        false ->
            NewAngry = min(CurAngry + AddValue,?BATTLE_MAX_ANGRY),
            {enter_entity(Battle,Entity#entity{cur_angry = NewAngry}),NewAngry}
    end.


get_total_hurt_event(Hurts,Pos) ->
    case gb_trees:lookup(Pos,Hurts) of
        none -> 
            #ps_total_hurt{
                pos      = Pos, %% integer() 站位
                hurt     = 0, %% integer() 总伤害值
                heal     = 0, %% integer() 总治疗值
                be_hurt  = 0, %% integer() 总承伤值
                be_heal  = 0  %% integer() 总承疗值果
            };
        {value,Hurt} ->
            Hurt
    end.

merge_hurts(TotalHurts,Hurts) ->
    Fun = fun({Pos,Value},TempHurts) ->
        HurtEvent = get_total_hurt_event(TempHurts,Pos),
        case Value > 0 of
            true ->
                gb_trees:enter(Pos,HurtEvent#ps_total_hurt{heal = HurtEvent#ps_total_hurt.heal + Value},TempHurts);
            false ->
                gb_trees:enter(Pos,HurtEvent#ps_total_hurt{hurt = HurtEvent#ps_total_hurt.hurt - Value},TempHurts)
        end
    end,
    lists:foldl(Fun,TotalHurts,Hurts).


get_buff_e_type(BuffID) ->
    BuffCfg = data_buff:get(BuffID),
    case BuffCfg#cfg_buff.effect_type of
        4 ->    ?SKILL_BUFF_E_TYPE_HURT;
        5 ->    ?SKILL_BUFF_E_TYPE_HEAL;
        6 ->    ?SKILL_BUFF_E_TYPE_HURT;
        _ ->    0
    end.

rm_expired_buff([],SaveBuffs) ->
    SaveBuffs;
rm_expired_buff([Buff=#skill_buff{rounds = Rounds}|Res],SaveBuffs) when Rounds > 1 ->
    rm_expired_buff(Res,[Buff#skill_buff{rounds = Rounds - 1}|SaveBuffs]);
rm_expired_buff([Buff=#skill_buff{rounds = Rounds}|Res],SaveBuffs) ->
    rm_expired_buff(Res,SaveBuffs).



get_buff_hurt_value_show(EType,EValue,BuffCfg) when BuffCfg#cfg_buff.add_jump == 1 ->
    case EType of
        ?SKILL_BUFF_E_TYPE_HURT ->
            - EValue;
        ?SKILL_BUFF_E_TYPE_HEAL ->
            EValue;
        _ ->
            0
    end;
get_buff_hurt_value_show(EType,EValue,BuffCfg) ->
    0.


new_entity(Pos,Role) ->
    Attri = Role#role.attri,
    #entity{
        type    = ?ENTITY_TYPE_ROLE,                    % 单位类型
        cfg_id  = Role#role.cfg_id,                    % 配置ID
        pos     = Pos,                    % 位置
        level   = Role#role.lv,
        star    = Role#role.star,

        cur_hp      = Attri#attri.hp,       % 当前血量
        %cur_hp      = 200,
        cur_angry   = Attri#attri.angry,    % 当前怒气
        
        skills      = get_active_skill(Role#role.skills),    % 主动技能ID列表
        triger_skills = get_triger_skill(Role#role.skills),  % 被动技能列表 #triger_skill
        attri       = Attri
    }.

new_entity_by_mon_cfg(Pos,MonCfg) ->
     #entity{
        type    = ?ENTITY_TYPE_MONSTER,                    % 单位类型
        cfg_id  = MonCfg#cfg_monster.id,                    % 配置ID
        pos     = Pos,                    % 位置
        level   = MonCfg#cfg_monster.lv,
        star    = MonCfg#cfg_monster.star,

        active      = true,                 % false表示本轮出过手了

        cur_skill   = 0,                    % 当前技能
        cur_hp      = 10000,                % 当前血量
        cur_angry   = 0,                    % 当前怒气
        total_hurt  = 0,                    % 总伤害
        total_heal  = 0,                    % 总治疗
        skills      = [6500110,6500111],                    % 主动技能ID列表
        triger_skills = [#triger_skill{cfg_id = 65001131, times = 999},#triger_skill{cfg_id = 65001141, times = 999}],  % 被动技能列表 #triger_skill
        buffs       = [],                   % buffID列表
        marks       = [],                   % 印记列表 #skill_mark
        attri       = #attri{
                            %% 一级属性
                            atk         = 100,  %% 攻击
                            def         = 0,    %% 防御
                            hp          = 10000,    %% 血量
                            speed       = 100,  %% 速度
                            angry       = 0,    %% 怒气上限
                            %% 二级属性
                            skill_hurt  = 0,    %% 技能伤害（千分比）
                            hit         = 0,    %% 精准
                            dodge       = 0,    %% 格挡
                            crit        = 0,    %% 暴击率
                            crit_hurt   = 0,    %% 暴击伤害（千分比）
                            arp         = 0,    %% 破甲
                            stun_imm    = 0,    %% 免控率
                            hurt_imm    = 0,    %% 免伤率
                            holy_hurt   = 0     %% 神圣伤害
                        }          

    }.

get_active_skill(SkillIDs) ->
    get_active_skill_helper(SkillIDs,[]).

get_active_skill_helper([],ActiSKills) ->
    ActiSKills;
get_active_skill_helper([SkillID|Res],ActiSKills) ->
    case data_skill:get(SkillID) of
        SkillCfg =#cfg_skill{use_type = ?SKILL_USE_TYPE_NOAMAL} ->
            get_active_skill_helper(Res,[SkillID|ActiSKills]);
        SkillCfg =#cfg_skill{use_type = ?SKILL_USE_TYPE_SKILL} ->
            get_active_skill_helper(Res,[SkillID|ActiSKills]);
        _ ->
            get_active_skill_helper(Res,ActiSKills)
    end.

% [#triger_skill{cfg_id = 65001131, times = 999},#triger_skill{cfg_id = 65001141, times = 999}]
get_triger_skill(SkillIDs) ->
    get_triger_skill_helper(SkillIDs,[]).

get_triger_skill_helper([],TrigerSkills) ->
    %?DBG(battle_util,"get_triger_skill = ~p",[TrigerSkills]),
    TrigerSkills;
get_triger_skill_helper([SkillID|Res],TrigerSkills) ->
    case data_skill:get(SkillID) of
        SkillCfg =#cfg_skill{use_type = ?SKILL_USE_TYPE_TRIGER} ->
            TrigerSkillIDs = SkillCfg#cfg_skill.triger_skill,
            NewTrigerSkillIDs = add_triger_skils(TrigerSkillIDs,TrigerSkills),
            get_triger_skill_helper(Res,NewTrigerSkillIDs);
        _ ->
            get_triger_skill_helper(Res,TrigerSkills)
    end.

add_triger_skils([],TrigerSkills) ->
    TrigerSkills;
add_triger_skils([TrigerSkillID|Res],TrigerSkills) ->
    case data_triger_skill:get(TrigerSkillID) of
        TrigerSKillCfg = #cfg_triger_skill{max_times = MaxTimes} ->
            MaxTimes1 = 
            case MaxTimes of
                0 ->
                    999;
                _ ->
                    MaxTimes
            end,
            add_triger_skils(Res,[#triger_skill{cfg_id = TrigerSkillID, times = MaxTimes1}|TrigerSkills]);
        _ ->
            add_triger_skils(Res,TrigerSkills)
    end.

