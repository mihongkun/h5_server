%% laojiajie@gmail.com
%% 随机种子生成器
%% 2018-5-23

-module(g_rand).
-behaviour(gen_server).
-export([
        start_link/0,
        get_seed/0
    ]
).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-include("log.hrl").

-record(state, {seed}).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% 取得一个随机数种子
get_seed() ->
    gen_server:call(?MODULE, get_seed).


init([]) ->
	erlang:process_flag(trap_exit, true),
    State = #state{},
    {ok, State}.


handle_call(get_seed, _From, State) ->
    case State#state.seed of
        undefined -> rand:seed(exs1024s,os:timestamp());
        S -> rand:seed(exs1024s,S)
    end,
    Seed = {rand:uniform(99999), rand:uniform(999999), rand:uniform(999999)},
    {reply, Seed, State#state{seed = Seed}};

handle_call(_Request, _From, State) ->
    {noreply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({'EXIT', _, Reason}, State) ->
    ?INF(rand, "exit:~w", [Reason]),
    {stop, Reason, State};

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
