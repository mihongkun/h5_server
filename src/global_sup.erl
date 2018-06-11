%% laojiajie@gmail.com
%% 全局进程监督者
%% 2018-4-18
-module(global_sup).
-behaviour(supervisor).

-include("log.hrl").
-include("common.hrl").

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).



%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok,SevID} = application:get_env(game_server, server_id),
    StartIndex = SevID*100000+1,
    Procs = 
    [
       ?CHILD(g_flow,worker),
       ?CHILD(g_rand,worker),
       ?CHILD(u_account,g_uid, worker, {account,io_lib:format("SELECT IFNULL(MAX(sid), ~w) FROM gd_account",[StartIndex])}),
       ?CHILD(g_player,worker)
    ],

    {ok, {{one_for_one, 5, 10}, Procs}}.