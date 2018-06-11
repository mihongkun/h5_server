%% 战报管理模块
%% 2018-5-22 laojiajie@gmail.com

-module(battle_report).
-include("battle.hrl").
-compile(export_all).



insert(Battle,BRP) ->
	#pt_battle_report{battle_id = Battle_id,scene_id = Scene_id,sid = Sid,name = Name,level = Level,pic = Pic,tar_sid = Tar_sid,tar_name = Tar_name,tar_level = Tar_level,tar_pic = Tar_pic,entities = Entities,rounds = Rounds,total_hurts = Total_hurts,rewards = Rewards,result = Result}= BRP,
	Bin = protocol_parser:encode_send_battle_report(Battle_id,Scene_id,Sid,Name,Level,Pic,Tar_sid,Tar_name,Tar_level,Tar_pic,Entities,Rounds,Total_hurts,Rewards,Result),
	ZBin = zlib:compress(Bin),
	cache:insert(#battle_report{
        id          = Battle#battle.id,        % 战报ID
        type        = 1,        % 战报类型
        out_time    = 0,        % 失效时间
        sid         = Battle#battle.sid,        % 发起者ID
        name        = Battle#battle.name,       % 发起者名字
        level       = Battle#battle.level,        % 发起者等级
        pic         = Battle#battle.pic,        % 发起者头像
        tar_sid     = Battle#battle.tar_sid,        % 迎战者ID
        tar_name    = Battle#battle.tar_name,       % 迎战者名字
        tar_level   = Battle#battle.tar_level,        % 迎战者等级
        tar_pic     = Battle#battle.tar_pic,        % 迎战者头像
        bin         = ZBin        % 战报内容
    }).


