% 战斗播报头文件
% 2018-5-21 laojiajie@gmail.com
-ifndef(__BATTLE_REPORT_HRL__).
-define(__BATTLE_REPORT_HRL__, true).


% 战斗播报
-record(battle_report,{
        id     		= 0,        % 战报唯一ID
        sid 		= 0,		% 发起者ID
        name 		= 0,		% 发起者名字
        level		= 0,		% 发起者等级
        pic			= 0,		% 发起者头像
        tar_sid 	= 0,		% 迎战者ID
        tar_name 	= 0,		% 迎战者名字
        tar_level	= 0,		% 迎战者等级
        tar_pic		= 0,		% 发起者头像
        entities 	= [],		% 单位初始化 battle的#entity
        round_info	= [],		% 每回合概况 #battle_round
        result		= 0,		% 战斗结果
        rewards		= []		% 战斗奖励
    }).

-record(battle_round,{
		round 		= 0,		% round
		steps		= []		% 战斗步骤 #battle_step
	}).


-record(battle_step,{
		entity_id 	= 0,		% 单位id
		skill_id 	= 0,		% 技能id
		hps			= 0,		% 血量改变信息	#battle_hp_changes
		buffs		= 0			% buff改变信息	#battle_buff_changes
	}).


-record(battle_hp_changes,{
		entity_id 	= 0,
		hp 			= 0,
		angry 		= 0
	}).


-record(battle_buff_changes,{
		entity_id 	= 0,
		bufferID 	= 0,
		round 		= 0 	
	}).


-endif.

