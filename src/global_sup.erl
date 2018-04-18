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
    StartIndex = 0,
    Procs = 
    [
       ?CHILD(u_account,g_uid, worker, {account,io_lib:format("SELECT IFNULL(MAX(id), ~w) FROM gd_account",[StartIndex])})
    ],

    {ok, {{one_for_one, 5, 10}, Procs}}.