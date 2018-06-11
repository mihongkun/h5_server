%% @doc proto interface .

-module(proto).

-include("log.hrl").
-include("pt_error.hrl").

-compile(export_all).


%% socket调用，账号还没初始化
send(0,Bin) ->
	self()!{send_client,Bin};

send(Sid,Bin) ->
	case get(sid) of
		Sid ->	%% 是玩家进程调用，而且是自己
			?DBG(proto,"send_socket = ~p ~p,~p",[Sid,get(socket),self()]),
			get(socket)!{send_client,Bin};
		_ ->	%% 其他调用直接发送信息到相应玩家进程
			case player_sup:get_player_pid(Sid) of
				undefined ->
					skip;
				Pid ->
					?DBG(proto,"send_pid = ~p",[Pid]),
					gen_server:cast(Pid, {proto_send, Bin})
			end
	end.


%% 发送错误码
send_error(Sid,ErrID) ->
	send_error(Sid,ErrID,[]).
send_error(Sid,0,StrList) -> skip;
send_error(Sid,ErrID,StrList) ->
	ProtoID = 
	case get(cur_proto_id) of
		undefined ->
			0;
		Num ->
			Num
	end,
	pt_error:send(Sid,#pt_error{code = ErrID,proto = ProtoID,parms = StrList}).


%% 向在线玩家广播
brocast(Bin) ->
	Fun = fun({_,Pid,_,_}) ->
		gen_server:cast(Pid,{proto_send, Bin})
	end,
	lists:foreach(Fun,supervisor:which_children(player_sup)).

