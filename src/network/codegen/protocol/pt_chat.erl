%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_chat).
-include("pt_chat.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_history_infos{world_chat_infos = World_chat_infos,guild_chat_infos = Guild_chat_infos}) ->
	Bin = protocol_parser:encode_send_history_infos(World_chat_infos,Guild_chat_infos),
	nw_util:proto_log_out(?MODULE,Bin,"World_chat_infos=~p,Guild_chat_infos=~p",[World_chat_infos,Guild_chat_infos]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_chat_update{type = Type,add_chat_info = Add_chat_info}) ->
	Bin = protocol_parser:encode_send_chat_update(Type,Add_chat_info),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Add_chat_info=~p",[Type,Add_chat_info]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_chat,"pt_chat:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 发送聊天
decode_chat(Data) ->
	{Chat_type,Msg,Share_type,Share_id} = protocol_parser:decode_on_chat(Data),
	nw_util:proto_log_in(?MODULE,?CS_CHAT,"on_chat(Chat_type=~p,Msg=~p,Share_type=~p,Share_id=~p)",[Chat_type,Msg,Share_type,Share_id]),
	{nh_chat,on_chat,[Chat_type,Msg,Share_type,Share_id]}.

%% @doc 发送好友聊天
decode_friend_chat(Data) ->
	{Friend_sid,Msg,Share_type,Share_id} = protocol_parser:decode_on_friend_chat(Data),
	nw_util:proto_log_in(?MODULE,?CS_FRIEND_CHAT,"on_friend_chat(Friend_sid=~p,Msg=~p,Share_type=~p,Share_id=~p)",[Friend_sid,Msg,Share_type,Share_id]),
	{nh_chat,on_friend_chat,[Friend_sid,Msg,Share_type,Share_id]}.



