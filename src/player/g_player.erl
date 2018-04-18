-module(g_player).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-include("log.hrl").
-include("guild.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).


start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [],[]).


init([]) ->
    {ok, #state{}}.
    

get_player_pid(PlayerID) ->
	list_to_atom("player_"++integer_to_list(PlayerID)).


