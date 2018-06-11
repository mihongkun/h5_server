%% 玩家进程,处理具体逻辑业务的进程
%% 2018-4-29 by laojiajie@gmail.com

-module(player).
-include("player.hrl").
-include("pt_login.hrl").
-include("log.hrl").
-compile(export_all).


%% 登陆加载的模块。(同一批次的会不分先后异步加载,缩短玩家等待数据的时间;优先加载有依赖的模块)
-define(PLAYER_MOD_LISTS,[
		[mod_counter,mod_item,mod_role],	%% 首先加载这两个模块
		[mod_economy]
	]).


-record(state,{
			sid 		= 0,
			socket 		= undefined,
			load_cnt 	= 0,
			load_start_t = 0,
			load_list 	= ?PLAYER_MOD_LISTS,
			status 		= ?PLAYER_STATE_NONE,			%% 玩家状态
			quick_time 	= 0								%% 进程销毁时间（开服第一天延长进程销毁时间,用内存换性能）
	}).

start_link(Sid,Socket) ->
	PidName = player_sup:get_player_pid_name(Sid),
	gen_server:start_link({local, PidName}, ?MODULE, {Sid,Socket}, []).

login_init(Sid)->
	player_sup:cast_player(Sid,{login_load_mod,?PLAYER_MOD_LISTS}).

init({Sid,Socket}) ->
	%% erlang:process_flag(trap_exit, true),
	put(sid,Sid),
	put(socket,Socket),
	?INF(player,"player pid init,sid = ~p",[Sid]),
    {ok, #state{sid = Sid,socket = Socket}}.



send_client_msg(Sid,Msg) ->
	PidName = player_sup:get_player_pid_name(Sid),
	gen_server:cast(PidName,{send_mgs,Msg}).


%% 接收socket发过来的协议，并解析（是客户端操作的唯一入口）
handle_cast({proto_recv,ProtoID,Module,Func,Args},State=#state{socket = Socket,sid = Sid}) ->
	put(cur_proto_id,ProtoID),	%% 记录当前动作的协议号。错误码返回的协议标识
	{MicroSeconds,_} = timer:tc(Module,Func,Args),
	?DBG(player,"handle pt = ~w, MicroSeconds = ~w",[ProtoID,MicroSeconds]),
	g_flow:op(ProtoID,MicroSeconds),
	{noreply,State};


handle_cast({proto_send, Bin},State=#state{socket = Socket}) ->
	Socket!{send_client,Bin},
	{noreply, State};

%% 玩家之间发送协议的接口（例如玩家A调用proto:send(B,Sender, Args),通知玩家B一些事情）
handle_cast({proto_send, Sender, Args},State) ->
	erlang:apply(proto, Sender, Args),
	{noreply, State};


%% 玩家登陆后处理，发送各个系统的初始化信息
handle_cast({login_load_mod,[]},State=#state{sid = Sid,load_start_t = LoadST})->
	case LoadST > 0 of
		true ->
			T2 = erlang:monotonic_time(),
    		Time = erlang:convert_time_unit(T2 - LoadST, native, microsecond),
    		g_flow:op(?SC_LOGIN_RESULT,Time);
    	false ->
    		void
    end,
	{noreply, State#state{load_cnt = 0,load_list = []}};

handle_cast({login_load_mod,[ModList|ResList]=List},State=#state{socket = Socket,sid = Sid,load_start_t = LoadST})->
	NewLoadSt = 
	case List == ?PLAYER_MOD_LISTS of
		true ->
			erlang:monotonic_time();
		false ->
			LoadST
	end,
	Pids = [spawn_link(Mod, login, [Sid,self(),Socket]) || Mod <- ModList],
	?DBG(player,"player login_load_mod Pids = ~p ~n",[Pids]),
	{noreply, State#state{load_cnt = length(ModList),load_list = ResList,load_start_t = NewLoadSt}};


handle_cast({login_load_mod_finish,Mod},State=#state{sid = Sid})->
	?DBG(player,"player load_mod_finish sid ~p ~n",[Mod]),
	case State#state.load_cnt - 1 > 0 of
		true->
			{noreply, State#state{load_cnt = State#state.load_cnt - 1}};
		false ->
			gen_server:cast(self(),{login_load_mod,State#state.load_list}),
			{noreply, State#state{load_cnt = 999}}
	end;

		


%% 玩家登陆处理
handle_cast({login_mod},State) ->
	{noreply, State};



%% socket断开(玩家退出游戏或断线)
handle_cast({socket_quick,Socket},State=#state{socket = MSocket,sid = Sid}) ->
	?DBG(player,"player socket_quick ~p ~p ~n",[Sid,Socket]),
	case Socket of
		MSocket ->
			NewState = State#state{socket = undefined};
		_ ->
			NewState = State,
			?ERR(player,"player socket_quick not_match sid =~p mSocket=~p socket=~n",[Sid,MSocket,Socket]),
			skip
	end,
	{noreply,NewState};


handle_cast(Else,State=#state{sid = Sid}) ->
	?DBG(error,"player handle_cast undefined ~p ~p",[Else]),
	{noreply,State}.


%% 重新绑定socket进程(断线重连 或 顶号)
handle_call({rebind_socket,NewSocket},_From,State=#state{socket = Socket,sid = Sid}) ->
	put(socket,NewSocket),
	?DBG(player,"player rebind_socket ~p ~p ~n",[Sid,NewSocket]),
	{reply,ok,State#state{socket = NewSocket}};


%% 正常关闭玩家进程
handle_call(shutdown_normal,_From,State=#state{socket = Socket,sid = Sid}) ->
	?INF(player,"player shutdown_normal,sid = ~p, socket = ~p",[Sid,Socket]),
	{reply,none,State};


handle_call(_,_From,State) ->
	P = util:to_integer("g"),
	{reply,none,State}.


handle_info({'EXIT', _, Reason}, State) ->
    ?INF(player,"player exit: sid = ~p, reason = ~p", [State#state.sid,Reason]),
    {stop, Reason, State}.


terminate(Reason, State) ->
	?INF(player,"player terminate:sid = ~p, reason = ~p", [State#state.sid,Reason]),
    ok.



