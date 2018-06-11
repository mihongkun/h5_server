%% cowboy 控制的socket进程，处理玩家网络连接，bin解码
%% 2018-4-29 by laojiajie@gmail.com
-module(ws_handler).

-include("log.hrl").
-include("login.hrl").

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2,terminate/3]).


-record(state,{
			sid 		= 0,			%% 对应的玩家ID
			pid 		= undefined,	%% 玩家的pid
			status 		= ?LOGIN_STATUS_NONE,		%% 状态
			ip 			= none,			%% ip
			port 		= none,			%% 端口
			proto       = 0,			%% 最近一次接收的协议号(不严格，因为异步调用player进程，但对分析player崩溃有一定参考价值)
			proto_data  = none			%% 数据
	}).

init(Req, Opts) ->
	{IP, Port} = cowboy_req:peer(Req),
	?INF(ws_handler,"websocket init ~p ~p ~p ~n",[IP,Port,self()]),
	{cowboy_websocket, Req, #state{ip = IP,port = Port},#{
        idle_timeout => 120000,
        max_frame_size => 2048}}.

websocket_init(State=#state{ip = IP,port = Port}) ->
	?INF(ws_handler,"websocket_init ~p ~n",[self()]),
	%erlang:start_timer(1000, self(), <<"Hello!">>),
	put(ws_ip, IP),
	{ok, State}.


websocket_handle({text,Msg},State) ->
	?INF(ws_handler,"websocket handle text ~p",[util:to_list(Msg)]),
	{ok,State};


%% 接收客户端协议，并转发给player
websocket_handle({binary,Binary},State=#state{sid = Sid,pid = Pid,status = Status}) ->
	<<ProtoID:16,ProtoData/binary>> = Binary,
	g_flow:recv(ProtoID,byte_size(Binary)),
	{DecodeMod,Decoder} = protocol_selector:get_decoder(ProtoID),
	case Status of
		?LOGIN_STATUS_NONE -> %% 未验证，走验证流程
			{nh_login,on_login,Args} = DecodeMod:Decoder(ProtoData),
			NewStatus = erlang:apply(nh_login,on_login,Args),
			case NewStatus == ?LOGIN_STATUS_NORMAL of
				true ->
					self()!{bind_player};
				false ->
					void
			end;
		?LOGIN_STATUS_AUTH -> %% 验证通过，但未链接player(创角)
			{nh_login,on_create_player,Args} = DecodeMod:Decoder(ProtoData),
			NewStatus = erlang:apply(nh_login,on_create_player,Args),
			case NewStatus == ?LOGIN_STATUS_NORMAL of
				true ->
					self()!{bind_player};
				false ->
					void
			end;
		?LOGIN_STATUS_NORMAL -> %% 已经链接player,协议转发给player
			{Module,Func,Args} = DecodeMod:Decoder(ProtoData),
			gen_server:cast(Pid,{proto_recv,ProtoID,Module,Func,Args}),
			NewStatus = Status
	end,
	{ok,State#state{status = NewStatus,proto = ProtoID}};



websocket_handle(Data, State) ->
	?ERR(ws_handler,"handle error = ~p",[Data]),
	{ok, State}.


%% 向客户端发送协议
websocket_info({send_client, Binary}, State) ->
	<<Len:32,ProtoID:16,_Res/binary>> = Binary,
	g_flow:send(ProtoID,Len),
	{reply, {binary, Binary}, State};


%% 绑定player
websocket_info({bind_player},State) ->
	Sid = get(sid),
	case player_sup:creaet_player_process(Sid,self()) of
		{error,{already_started,OldPid}} ->
			gen_server:call(OldPid,{rebind_socket,self()}),
			Pid = OldPid;
		{ok,Pid} ->
			void
	end,
	player:login_init(Sid),
	{ok,State#state{sid = Sid,pid = Pid}};


%% gm测试
websocket_info({gm_apply,ProtoID,Module,Func,Args},State=#state{sid = Sid,pid = Pid,status = Status}) ->
	case Status of
		?LOGIN_STATUS_NONE -> %% 未验证，走验证流程
			NewStatus = erlang:apply(nh_login,on_login,Args),
			?INF(ws_handler,"login veriy status = ~p",[NewStatus]),
			case NewStatus == ?LOGIN_STATUS_NORMAL of
				true ->
					self()!{bind_player};
				false ->
					void
			end;
		?LOGIN_STATUS_AUTH -> %% 验证通过，但未链接player
			NewStatus = erlang:apply(nh_login,on_create_player,Args),
			?INF(ws_handler,"login create_player = ~p",[NewStatus]),
			case NewStatus == ?LOGIN_STATUS_NORMAL of
				true ->
					self()!{bind_player};
				false ->
					void
			end;
		?LOGIN_STATUS_NORMAL -> %% 已经链接player,协议转发给player
			?INF(ws_handler,"proto_recv = ~p ~p",[Module,Func]),
			gen_server:cast(Pid,{proto_recv,ProtoID,Module,Func,Args}),
			NewStatus = Status
	end,
	{ok,State#state{status = NewStatus,proto = ProtoID}};


websocket_info({timeout, _Ref, Msg}, State) ->
	%erlang:start_timer(1000, self(), <<"How' you doin'?">>),
	{reply, {text, Msg}, State};
websocket_info(Info, State) ->
	?INF(ws_handler,"websocket_info none ~p",[Info]),
	{ok, State}.


terminate(Reason, _Req,State=#state{sid = SID,pid = Pid}) ->
	?INF(ws_handler,"socket quick, reason = ~p",[Reason]),
	ok.

	