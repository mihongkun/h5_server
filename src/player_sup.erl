%% laojiajie@gmail.com
%% 玩家进程监督者
%% 2018-4-18

-module(player_sup).
-behaviour(supervisor).

-include("log.hrl").
-include("common.hrl").

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-export([get_player_pid_name/1,
	 	 get_player_pid/1,
	 	 creaet_player_process/2,
	 	 shutdown_player_process/1,
	 	 cast_player/2,
	 	 call_player/2
	 	 ]).


%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================



%% Restart标识一个进程终止后将怎样重启，一个permanent 进程总会被重启；一个temporary 进程从不会被重启；一个transient 进程仅仅当是不正常的被终止后才重启，例如非normal等退出原因
%% Shutdown 定义一个进程将怎样被终止，brutal_kill意味着子进程被exit(Child, kill)无条件的终止；一个整数值的超时时间意味着监督者告诉子进程通过调用exit(Child, shutdown)而被终止，然后等待一个返回的退出信号，假如在指定的时间里没有收到退出信号，那么子进程用exit(Child, kill)被无条件终止。
init([]) ->
    {ok, {{simple_one_for_one, 10, 60},  %% 60秒内崩溃10次则不再重启
            [
                {player, {player, start_link, []},
                        transient, 5000, worker, [player]}
                ]}}.



get_player_pid_name(SID) ->
	list_to_atom("player_"++integer_to_list(SID)).


get_player_pid(SID) ->
	PidName = get_player_pid_name(SID),
	whereis(PidName).


creaet_player_process(SID,Socket) ->
	supervisor:start_child(player_sup,[SID,Socket]).


shutdown_player_process(SID) ->
	PidName = get_player_pid_name(SID),
	Pid = whereis(PidName),
	case Pid of
		undefined ->
			ok;
		_ ->
			gen_server:call(PidName,shutdown_normal),
			supervisor:terminate_child(player_sup,Pid)
	end.


cast_player(SID,Content) ->
	PidName = get_player_pid_name(SID),
	gen_server:cast(PidName,Content).


call_player(SID,Content) ->
	PidName = get_player_pid_name(SID),
	gen_server:call(PidName,Content).

