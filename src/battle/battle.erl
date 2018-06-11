%% 战斗模块
%% 2018-5-22 laojiajie@gmail.com

%% 战斗流程:
% 0. 回合开始
% 1. 魔兽出手
% 2. 魔兽伤害触发的即时技能
% 3. 正式技能流程(包含即时技能)
% 4. buff结算
% 5. buff结算触发的即时技能
% 6. 胜负判定
% 7. 下一回合


-module(battle).
-include("battle.hrl").
-compile(export_all).


-export([start/1,
		 pve/3		% 发起pve战斗 Sid,[{Pos,Role}],BattleCfgID -> true/false
		]).


pve(Sid,Roles,BattleCfgID) ->
	BattleCfg = data_battle:get(BattleCfgID),
	Battle = #battle{
		id          = 1,        % 战报ID
        sid         = Sid,      % 发起者ID
        name        = mod_account:get_name(Sid),        % 发起者名字
        level       = mod_account:get_level(Sid),        % 发起者等级
        pic         = 1,        % 发起者头像
        tar_sid     = 0,        % 迎战者ID
        tar_name    = "",       % 迎战者名字
        tar_level   = 0,        % 迎战者等级
        tar_pic     = 1         % 发起者头像
	},
	Battle1 = battle_util:enter_roles(Battle,Roles),
	Battle2 = battle_util:enter_monsters(Battle1,BattleCfg),
	{Result,Report} = battle:start(Battle2),
	battle_report:insert(Battle,Report),
	pt_battle:send(Sid,Report),
	Result.




start(Battle) ->
	Report = battle_util:init_battle_report(Battle),	%% 初始化战报
	handle_round(Battle#battle{round = 1},Report).			%% 开始回合循环

handle_round(Battle,Report) ->
	%?DBG(battle,"handle_round"),
	case battle_util:is_battle_finish(Battle) of
		{true,Result} ->
			%% 回合结束
			{Result == ?BATTLE_RESULT_WIN,Report#pt_battle_report{
														result = Result,
														rounds = lists:reverse(Report#pt_battle_report.rounds),
														total_hurts = battle_util:trees_to_list(Report#pt_battle_report.total_hurts)
														}};
		false ->
			%% 初始化佣兵的回合状态(重置出手状态,移除过期buff/mark)
			Battle1 = battle_util:deal_before_round(Battle),
			%% 技能处理
			{Battle2,StepInfos,StatsHurtList} = handle_step(Battle1,[],[]),
			%% buff结算
			{Battle3,BuffEndInfos,AddSkillSteps,StatcList} = handle_buff(Battle2,[]),
			%% 下一回合战斗
			RoundInfo = #ps_battle_round{
			    cur_round  = Battle3#battle.round,  %% integer() 当前回合
			    steps      = lists:reverse(StepInfos), %% list(ps_step_event) 步骤信息
			    buff_end   = BuffEndInfos  %% list(ps_buff_end_event) buff结算信息
			},
			handle_round(Battle3#battle{
								round = Battle3#battle.round + 1
						},
						Report#pt_battle_report{
							rounds = [RoundInfo|Report#pt_battle_report.rounds],
							total_hurts = battle_util:merge_hurts(Report#pt_battle_report.total_hurts,StatcList++StatsHurtList)
						})
	end.


handle_step(Battle,StepInfos,StatsHurtList) ->
	% ?DBG(battle,"handle_step"),
	case battle_util:find_next_hand(Battle) of	% 寻找下一次出手的佣兵
		undefined ->
			{Battle,StepInfos,StatsHurtList};
		Entity ->
			{Battle1,AddStepInfos,StatsHurts} = skill:handle(Battle,Entity,battle_util:get_all_entity_pos(Battle)), 	% 使用技能
			Entity1 = battle_util:get_entity(Battle1,Entity#entity.pos),
			Battle2 = battle_util:enter_entity(Battle1,Entity1#entity{active = false}),
			handle_step(Battle2,AddStepInfos ++ StepInfos, StatsHurts ++ StatsHurtList)
	end.


handle_buff(Battle,[]) ->
	{Battle1,BuffEvents,AddSkillSteps,StatcList} = skill_buff:handle_end(Battle),
	{Battle1,BuffEvents,AddSkillSteps,StatcList}.




