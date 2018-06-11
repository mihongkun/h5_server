%% 战斗测试工具
%% 2018-5-22 laojiajie@gmail.com

-module(battle_test).
-include("battle.hrl").
-compile(export_all).



start_spawn(Num) ->
	Fun = fun(Sid) ->
		spawn(battle_test,start_spawn_test,[self()])
	end,
	lists:foreach(Fun,lists:seq(1,Num)),
	FunR = fun(Sid) ->
		receive
			ok ->	ok
		end
	end,
	lists:foreach(Fun,lists:seq(1,Num)),
	all_finish.

start_spawn_test(Pid) ->
	start(),
	Pid!ok.


test_zip()->
	{Result1,BRP} = start(),
	#pt_battle_report{battle_id = Battle_id,sid = Sid,name = Name,level = Level,pic = Pic,tar_sid = Tar_sid,tar_name = Tar_name,tar_level = Tar_level,tar_pic = Tar_pic,entities = Entities,rounds = Rounds,total_hurts = Total_hurts,rewards = Rewards,result = Result} = BRP,
	Bin = protocol_parser:encode_send_battle_report(Battle_id,Sid,Name,Level,Pic,Tar_sid,Tar_name,Tar_level,Tar_pic,Entities,Rounds,Total_hurts,Rewards,Result),
	ZBin = zlib:compress(Bin),
	{byte_size(Bin),byte_size(ZBin)}.


test_tc() ->
	start(),
	ok.


start()->
	Battle = #battle{
		id          = 1,        % 战报ID
        sid         = 100100001,        % 发起者ID
        name        = "小柴多宝",        % 发起者名字
        level       = 110,        % 发起者等级
        pic         = 1,        % 发起者头像
        tar_sid     = 100100002,        % 迎战者ID
        tar_name    = "阿呆",        % 迎战者名字
        tar_level   = 120,        % 迎战者等级
        tar_pic     = 1,        % 发起者头像
        round       = 0        % 当前轮数
	},
	Fun = fun(Pos,Battle1) ->
		Role = make_role(util_lists:rand(data_role:id_list())),
		battle_util:enter_roles(Battle1,[{Pos,Role}])
	end,
	Battle2 = lists:foldl(Fun,Battle,lists:seq(1,12)),
	battle:start(Battle2).


make_role(RoleCfgID) ->
	Role = role_util:make_init_role(1,1,RoleCfgID),
	NewRole = Role#role{lv = util:rand(1,100),quality = 6,star = 10},
	NewRole1 = role_math:build_role_attri(NewRole),
	NewRole1.
	% #entity{
	% 	type = 0,                       % 单位类型
	% 	cfg_id 	= RoleCfgID,				% 配置ID
 %        pos    	= 0,        			% 位置
 %        level   = 0,
 %        star    = 0,

 %        active      = true,                 % false表示本轮出过手了

 %        cur_skill   = 0,                    % 当前技能
 %        cur_hp	    = 10000,				% 当前血量
 %        cur_angry   = 0,					% 当前怒气
 %        total_hurt  = 0,					% 总伤害
 %        total_heal  = 0,					% 总治疗
 %        skills      = [6500110,6500111],					% 主动技能ID列表
 %        triger_skills = [#triger_skill{cfg_id = 65001131, times = 999},#triger_skill{cfg_id = 65001141, times = 999}],	% 被动技能列表 #triger_skill
 %        buffs 	    = [],					% buffID列表
 %        marks       = [],                   % 印记列表 #skill_mark
 %        attri 	    = #attri{
 %        					%% 一级属性
	% 						atk			= 100,	%% 攻击
	% 						def 		= 0,	%% 防御
	% 						hp  		= 10000,	%% 血量
	% 						speed 		= 100,	%% 速度
	% 						angry 		= 0,	%% 怒气上限
	% 						%% 二级属性
	% 						skill_hurt	= 0,	%% 技能伤害（千分比）
	% 						hit			= 0,	%% 精准
	% 						dodge		= 0,	%% 格挡
	% 						crit 		= 0,	%% 暴击率
	% 						crit_hurt 	= 0,	%% 暴击伤害（千分比）
	% 						arp 		= 0,	%% 破甲
	% 						stun_imm	= 0,	%% 免控率
	% 						hurt_imm 	= 0,	%% 免伤率
	% 						holy_hurt 	= 0 	%% 神圣伤害
 %        				} 	       

	% }.
