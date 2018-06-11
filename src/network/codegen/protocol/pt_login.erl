%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_login).
-include("pt_login.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_login_result{errorcode = ErrorCode,sid = Sid,suid = Suid}) ->
	Bin = protocol_parser:encode_send_login_result(ErrorCode,Sid,Suid),
	nw_util:proto_log_out(?MODULE,Bin,"ErrorCode=~p,Sid=~p,Suid=~p",[ErrorCode,Sid,Suid]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_player_info{name = Name,sex = Sex,level = Level,exp = Exp,pic = Pic,intro = Intro,open_infos = Open_infos,battle_power = Battle_power}) ->
	Bin = protocol_parser:encode_send_player_info(Name,Sex,Level,Exp,Pic,Intro,Open_infos,Battle_power),
	nw_util:proto_log_out(?MODULE,Bin,"Name=~p,Sex=~p,Level=~p,Exp=~p,Pic=~p,Intro=~p,Open_infos=~p,Battle_power=~p",[Name,Sex,Level,Exp,Pic,Intro,Open_infos,Battle_power]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_create_player_result{error = Error,sid = Sid}) ->
	Bin = protocol_parser:encode_send_create_player_result(Error,Sid),
	nw_util:proto_log_out(?MODULE,Bin,"Error=~p,Sid=~p",[Error,Sid]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_new_battle_power{battle_power = Battle_power}) ->
	Bin = protocol_parser:encode_send_new_battle_power(Battle_power),
	nw_util:proto_log_out(?MODULE,Bin,"Battle_power=~p",[Battle_power]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_new_name{name = Name}) ->
	Bin = protocol_parser:encode_send_new_name(Name),
	nw_util:proto_log_out(?MODULE,Bin,"Name=~p",[Name]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_new_intro{intro = Intro}) ->
	Bin = protocol_parser:encode_send_new_intro(Intro),
	nw_util:proto_log_out(?MODULE,Bin,"Intro=~p",[Intro]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pong{client_time = Client_time,time = Time}) ->
	Bin = protocol_parser:encode_send_pong(Client_time,Time),
	nw_util:proto_log_out(?MODULE,Bin,"Client_time=~p,Time=~p",[Client_time,Time]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_resp_get_assign_player_info{sid = Sid,nick_name = Nick_name,level = Level,pic = Pic,guild_name = Guild_name}) ->
	Bin = protocol_parser:encode_send_resp_get_assign_player_info(Sid,Nick_name,Level,Pic,Guild_name),
	nw_util:proto_log_out(?MODULE,Bin,"Sid=~p,Nick_name=~p,Level=~p,Pic=~p,Guild_name=~p",[Sid,Nick_name,Level,Pic,Guild_name]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_player_level_change{level = Level,exp = Exp}) ->
	Bin = protocol_parser:encode_send_player_level_change(Level,Exp),
	nw_util:proto_log_out(?MODULE,Bin,"Level=~p,Exp=~p",[Level,Exp]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_rep_heart_beat{state = State}) ->
	Bin = protocol_parser:encode_send_rep_heart_beat(State),
	nw_util:proto_log_out(?MODULE,Bin,"State=~p",[State]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_resp_notify_td_diamond_change{type = Type,type_desc = Type_desc,daimond = Daimond}) ->
	Bin = protocol_parser:encode_send_resp_notify_td_diamond_change(Type,Type_desc,Daimond),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Type_desc=~p,Daimond=~p",[Type,Type_desc,Daimond]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_notify_cross_day{}) ->
	Bin = protocol_parser:encode_send_notify_cross_day(),
	nw_util:proto_log_out(?MODULE,Bin,"",[]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_login,"pt_login:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 登陆
decode_login(Data) ->
	{Account,Server,Timestamp,Key,ConnectCount,Suid,PlatformID,Idfamac,PlatformInfo} = protocol_parser:decode_on_login(Data),
	nw_util:proto_log_in(?MODULE,?CS_LOGIN,"on_login(Account=~p,Server=~p,Timestamp=~p,Key=~p,ConnectCount=~p,Suid=~p,PlatformID=~p,Idfamac=~p,PlatformInfo=~p)",[Account,Server,Timestamp,Key,ConnectCount,Suid,PlatformID,Idfamac,PlatformInfo]),
	{nh_login,on_login,[Account,Server,Timestamp,Key,ConnectCount,Suid,PlatformID,Idfamac,PlatformInfo]}.

%% @doc 进入游戏
decode_enter_game(Data) ->
	{Os,Osver,Device,DeviceType,Resolution,Service,Network,Phoneid,Bind,Battle_type,Dun_id,Ext_dun_id} = protocol_parser:decode_on_enter_game(Data),
	nw_util:proto_log_in(?MODULE,?CS_ENTER_GAME,"on_enter_game(Os=~p,Osver=~p,Device=~p,DeviceType=~p,Resolution=~p,Service=~p,Network=~p,Phoneid=~p,Bind=~p,Battle_type=~p,Dun_id=~p,Ext_dun_id=~p)",[Os,Osver,Device,DeviceType,Resolution,Service,Network,Phoneid,Bind,Battle_type,Dun_id,Ext_dun_id]),
	{nh_login,on_enter_game,[Os,Osver,Device,DeviceType,Resolution,Service,Network,Phoneid,Bind,Battle_type,Dun_id,Ext_dun_id]}.

%% @doc 创建角色
decode_create_player(Data) ->
	{Name,Sex,Pic,InvideCode,Os,Osver,Device,DeviceType,Resolution,Service,Network,Phoneid} = protocol_parser:decode_on_create_player(Data),
	nw_util:proto_log_in(?MODULE,?CS_CREATE_PLAYER,"on_create_player(Name=~p,Sex=~p,Pic=~p,InvideCode=~p,Os=~p,Osver=~p,Device=~p,DeviceType=~p,Resolution=~p,Service=~p,Network=~p,Phoneid=~p)",[Name,Sex,Pic,InvideCode,Os,Osver,Device,DeviceType,Resolution,Service,Network,Phoneid]),
	{nh_login,on_create_player,[Name,Sex,Pic,InvideCode,Os,Osver,Device,DeviceType,Resolution,Service,Network,Phoneid]}.

%% @doc 玩家改名
decode_change_name(Data) ->
	{Name} = protocol_parser:decode_on_change_name(Data),
	nw_util:proto_log_in(?MODULE,?CS_CHANGE_NAME,"on_change_name(Name=~p)",[Name]),
	{nh_login,on_change_name,[Name]}.

%% @doc 修改个人说明
decode_change_intro(Data) ->
	{Intro} = protocol_parser:decode_on_change_intro(Data),
	nw_util:proto_log_in(?MODULE,?CS_CHANGE_INTRO,"on_change_intro(Intro=~p)",[Intro]),
	{nh_login,on_change_intro,[Intro]}.

%% @doc ping同步时间
decode_ping(Data) ->
	{Time} = protocol_parser:decode_on_ping(Data),
	nw_util:proto_log_in(?MODULE,?CS_PING,"on_ping(Time=~p)",[Time]),
	{nh_login,on_ping,[Time]}.

%% @doc 获取指定玩家信息
decode_get_assign_player_info(Data) ->
	{Sid} = protocol_parser:decode_on_get_assign_player_info(Data),
	nw_util:proto_log_in(?MODULE,?CS_GET_ASSIGN_PLAYER_INFO,"on_get_assign_player_info(Sid=~p)",[Sid]),
	{nh_login,on_get_assign_player_info,[Sid]}.

%% @doc 心跳包
decode_req_heart_beat(Data) ->
	{} = protocol_parser:decode_on_req_heart_beat(Data),
	nw_util:proto_log_in(?MODULE,?CS_REQ_HEART_BEAT,"on_req_heart_beat()",[]),
	{nh_login,on_req_heart_beat,[]}.



