%% 流量统计模块
%% laojiajie@gmail.com
%% 2018-6-2
-module(g_flow).

-include("nw.hrl").

-export([send/2, recv/2, op/2]).

-export([start_link/0]).
-export([init/1, handle_cast/2, terminate/2, code_change/3]).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
	erlang:process_flag(trap_exit, true),
	erlang:process_flag(priority, high),
    State = undefined,
    {ok, State}.



send(ProtoID,ByteSize) ->
    gen_server:cast(?MODULE, {send,ProtoID,ByteSize}).

recv(ProtoID,ByteSize) ->
    gen_server:cast(?MODULE, {recv,ProtoID,ByteSize}).

op(ProtoID,MicroSeconds) ->
	gen_server:cast(?MODULE, {op,ProtoID,MicroSeconds}).

handle_cast({send,ProtoID,ByteSize}, State) ->
	Flow = get_flow(ProtoID),
	cache:update(Flow#flow{
						send_times = Flow#flow.send_times + 1,
						send_bytes = Flow#flow.send_bytes + ByteSize,
						send_max   = max(Flow#flow.send_max,ByteSize)
				}),
    {noreply, State};


handle_cast({recv,ProtoID,ByteSize}, State) ->
	Flow = get_flow(ProtoID),
	cache:update(Flow#flow{
						recv_times = Flow#flow.recv_times + 1,
						recv_bytes = Flow#flow.recv_bytes + ByteSize,
						recv_max   = max(Flow#flow.recv_max,ByteSize)
				}),
    {noreply, State};

handle_cast({op,ProtoID,MicroSeconds},State) ->
	Flow = get_flow(ProtoID),
	case MicroSeconds > Flow#flow.op_time_max of
		true ->
			cache:update(Flow#flow{
								op_time 		= Flow#flow.op_time + MicroSeconds,
								op_time_max 	= MicroSeconds,
								op_time_max_ts 	= util:unixtime()
						});
		false ->
			cache:update(Flow#flow{
								op_time = Flow#flow.op_time + MicroSeconds
						})
	end,
    {noreply, State}.


terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

get_flow(ProtoID) ->
	{Hour,_,_} = time(),
	ID = util:today()*100+Hour,
	case cache:lookup(flow,{ID,ProtoID}) of
		[] ->
			Flow = #flow{
                key = {ID,ProtoID}
            },
			cache:insert(Flow),
			Flow;
		[Flow] ->
			Flow
	end.

