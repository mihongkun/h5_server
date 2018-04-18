%% laojiajie@gmail.com
%% 全局进程监督者
%% 2018-4-18

-module(player_sup).
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
    Procs = [],
    {ok, {{one_for_one, 5, 10}, Procs}}.