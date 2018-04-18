%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(game_server_sup).
-behaviour(supervisor).

-include("common.hrl").

%% API.
-export([start_link/0]).

%% supervisor.
-export([init/1]).

%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% supervisor.

init([]) ->
	Procs = 
	[
		?CHILD(global_sup, supervisor),		%% 全局进程监督者
		?CHILD(player_sup, supervisor)		%% 玩家进程监督者
	],
	{ok, {{one_for_one, 10, 10}, Procs}}.