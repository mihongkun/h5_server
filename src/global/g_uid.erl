%% 唯一ID生成模块
%% laojiajie@gmail.com
%% 2013-7-1
-module(g_uid).

-include("log.hrl").

-export([get/1, lookup/1]).

-export([start_link/1]).
-export([init/1, handle_call/3, terminate/2, code_change/3]).


start_link({Type,Sql}) ->
    RegName = list_to_atom(atom_to_list(?MODULE) ++ "_" ++ atom_to_list(Type)),
    gen_server:start_link({local, RegName}, ?MODULE, {Type,Sql}, []).

init({Type,Sql}) -> 
    erlang:process_flag(trap_exit, true),
    case ets:lookup(ets_uid,Type) of
        [] ->
            case Sql of
                "" ->
                    Num = 0;
                _ ->
                    {ok, [[Num]]} = sql_operate:do_execute(Sql)
            end,
            Sql1 = io_lib:format("SELECT uid FROM g_uid WHERE Type='~s'", [atom_to_list(Type)]),
            case sql_operate:do_execute(Sql1) of
                {ok, []} ->
                    InsertSql = io_lib:format("INSERT INTO g_uid VALUES ('~s', 0)", [atom_to_list(Type)]),
                    sql_operate:do_execute(InsertSql),
                    UNum = 0;
                {ok, [[UNum]]} ->
                    skip
            end,
            ets:insert(ets_uid,{Type,max(Num, UNum)});
        _ ->
            void
    end,
    % ets:insert(ets_uid_pid,{Type,self()}),
    {ok, Type}.

get(Type) ->
    RegName = list_to_atom(atom_to_list(?MODULE) ++ "_" ++ atom_to_list(Type)),
    gen_server:call(RegName,get_uid).
    % [{Type,Pid}] = ets:lookup(ets_uid_pid,Type),
    % gen_server:call(Pid,get_uid).

lookup(Type) ->
    RegName = list_to_atom(atom_to_list(?MODULE) ++ "_" ++ atom_to_list(Type)),
    gen_server:call(RegName,lookup_uid).
    % [{Type,Pid}] = ets:lookup(ets_uid_pid,Type),
    % gen_server:call(Pid,lookup_uid).

handle_call(get_uid,_From,State) ->
    case ets:lookup(ets_uid,State) of
        [] ->
            ?ERR(uid,"cant find info by Type:~w",[State]),
            Reply = 0;
        [{State,Num}] ->
            Reply = Num+1,
            ets:insert(ets_uid,{State,Reply})
    end,
    {reply,Reply,State};

handle_call(lookup_uid,_From,State) ->
    case ets:lookup(ets_uid,State) of
        [] ->
            ?ERR(uid,"cant find info by Type:~w",[State]),
            Reply = 0;
        [{State,Num}] ->
            Reply = Num
    end,
    {reply,Reply,State}.

terminate(Reason, State) ->
    case ets:lookup(ets_uid,State) of
        [] ->
            skip;
        [{State,Num}] ->
            UpdSql = io_lib:format("update g_uid set uid=~p WHERE type='~s'", [Num, atom_to_list(State)]),
            ?DBG(g_uid, "UpdSql=~s", [UpdSql]),
            sql_operate:do_execute(UpdSql)
    end,
    ?DBG(g_uid, "~p terminating, Reason = ~p", [?MODULE, Reason]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.