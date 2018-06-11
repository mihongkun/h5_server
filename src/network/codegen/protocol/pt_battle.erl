%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_battle).
-include("pt_battle.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_battle_report{battle_id = Battle_id,scene_id = Scene_id,sid = Sid,name = Name,level = Level,pic = Pic,tar_sid = Tar_sid,tar_name = Tar_name,tar_level = Tar_level,tar_pic = Tar_pic,entities = Entities,rounds = Rounds,total_hurts = Total_hurts,rewards = Rewards,result = Result}) ->
	Bin = protocol_parser:encode_send_battle_report(Battle_id,Scene_id,Sid,Name,Level,Pic,Tar_sid,Tar_name,Tar_level,Tar_pic,Entities,Rounds,Total_hurts,Rewards,Result),
	nw_util:proto_log_out(?MODULE,Bin,"Battle_id=~p,Scene_id=~p,Sid=~p,Name=~p,Level=~p,Pic=~p,Tar_sid=~p,Tar_name=~p,Tar_level=~p,Tar_pic=~p,Entities=~p,Rounds=~p,Total_hurts=~p,Rewards=~p,Result=~p",[Battle_id,Scene_id,Sid,Name,Level,Pic,Tar_sid,Tar_name,Tar_level,Tar_pic,Entities,Rounds,Total_hurts,Rewards,Result]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_team_info_back{type = Type,team = Team}) ->
	Bin = protocol_parser:encode_send_team_info_back(Type,Team),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Team=~p",[Type,Team]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_battle,"pt_battle:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 发起战斗
decode_start_battle(Data) ->
	{Type,Id} = protocol_parser:decode_on_start_battle(Data),
	nw_util:proto_log_in(?MODULE,?CS_START_BATTLE,"on_start_battle(Type=~p,Id=~p)",[Type,Id]),
	{nh_battle,on_start_battle,[Type,Id]}.

%% @doc 请求战报
decode_battle_report(Data) ->
	{Battle_id} = protocol_parser:decode_on_battle_report(Data),
	nw_util:proto_log_in(?MODULE,?CS_BATTLE_REPORT,"on_battle_report(Battle_id=~p)",[Battle_id]),
	{nh_battle,on_battle_report,[Battle_id]}.

%% @doc 获取上阵信息
decode_get_team_info(Data) ->
	{Type} = protocol_parser:decode_on_get_team_info(Data),
	nw_util:proto_log_in(?MODULE,?CS_GET_TEAM_INFO,"on_get_team_info(Type=~p)",[Type]),
	{nh_battle,on_get_team_info,[Type]}.

%% @doc 设置上阵信息
decode_set_team(Data) ->
	{Type,Team} = protocol_parser:decode_on_set_team(Data),
	nw_util:proto_log_in(?MODULE,?CS_SET_TEAM,"on_set_team(Type=~p,Team=~p)",[Type,Team]),
	{nh_battle,on_set_team,[Type,Team]}.



