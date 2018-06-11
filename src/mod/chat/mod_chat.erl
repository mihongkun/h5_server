-module(mod_chat).


-include ("pt_chat.hrl").
-include ("common.hrl").
-include ("chat.hrl").
-compile(export_all).


% 提供给客户端的接口
-export ([
	client_chat/5,
	history/1
	]).


%% 登陆处理
login(Sid,Pid,Socket)->
	put(sid,Sid),
	put(socket,Socket),
	?DBG(mod_chat,"login sid = ~p,pid = ~p",[Sid,Pid]),
	gen_server:cast(Pid,{login_load_mod_finish,?MODULE}).


client_chat(Sid,ChatType, Msg, ShareType, ShareID) ->
	case mod_gm:check_gm(Sid,Msg) of
		true ->
			void;
		false ->
			chat_data:push(Sid,ChatType,Msg,ShareType,ShareID),
			% chat_util:brocast(ChatType,).

			void
			% todo chat
	end.
	
history(Sid) ->
	{Winfs,Ginfs} = chat_data:find_all(Sid),
	chat_util:send_pt_history_infos(Sid,Winfs,Ginfs).














