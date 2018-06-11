-module (chat_util).

%% 聊天工具模块 
%% 2018-6-11 mihongkun@gmail.com
%% 因为要保持数据存储50条或其他固定数量的条目,如果在

-include ("pt_chat.hrl").
-compile (export_all).
-export ([
	send_pt_history_infos/3,		% 发送历史聊天信息 
	brocast_pt_chat_update/2		% 广播聊天数据 
	]).

% 发送历史消息
send_pt_history_infos(Sid,Winfs,Ginfs) ->
	pt_chat:send(Sid,write_pt_history_infos(Winfs,Ginfs)).

write_pt_history_infos(Winfs,Ginfs) ->
	#pt_history_infos{
		world_chat_infos = [
			write_ps_chat_info(Info) || Info <- Winfs
		],
		guild_chat_infos = [
			write_ps_chat_info(Info) || Info <- Ginfs
		]

	}.

write_ps_chat_info(Info) ->
	{Sid,Lv,Vip,Pic,Frame,Name,Msg,Time,ShareType,ShareId} = Info,
	#ps_chat_info{
		sid = Sid,
		lv = Lv,
		vip = Vip,
		pic = Pic,
		frame = Frame,
		name = Name,
		msg = Msg,
		time = Time,
		share_type = ShareType,
		share_id = ShareId
	}.	

brocast_pt_chat_update(Type,Info) ->
	proto:brocast(protocol_parser:encode_send_chat_update(Type,write_pt_chat_update(Type,Info))).

write_pt_chat_update(Type,Info) ->
	#pt_chat_update{
		type = Type,
		add_chat_info = write_ps_chat_info(Info)
	}.
