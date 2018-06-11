%% @doc network util .

-module(nw_util).

-include("log.hrl").

-compile(export_all).


-ifdef(GAME_DEBUG).
proto_log_out(Module,Bin,Fmt,Args) ->
	<<_:32, ProtoNum:16, _/binary>> = Bin,
	?DBG(Module,"out-proto:~w, "++ Fmt,[ProtoNum]++Args).

proto_log_in(Module,ProtoNum,Fmt,Args) ->
	?DBG(Module," in-proto:~w, "++ Fmt,[ProtoNum]++Args).

-else.
proto_log_out(Module,Bin,Fmt,Args) ->
	void.

proto_log_in(Module,ProtoNum,Fmt,Args) ->
	void.


-endif.


get_ip()->
	case get(ws_ip) of
		{A,B,C,D} ->
			lists:flatten(io_lib:format("~w.~w.~w.~w",[A,B,C,D]));
		_ ->
			"0.0.0.0"
	end.



%% @doc 读取列表 ItModule为
%% @spec read_list(binary, module, function) -> {list(), binary}
read_list(Bin, ItModule, ItFun) ->
	read_list(Bin, ItModule, ItFun, []).

read_list(Bin, ItModule, ItFun, ArgList) ->
	{Num,D0} = read_uint(Bin, 16),
	case Num =< 0 of 
		true ->
			{[], D0};
		false ->
			F = fun(_X, {List, Data}) ->						
						Args = [Data] ++ ArgList,
						{V, R} = erlang:apply(ItModule, ItFun, Args),
						{List ++ [V], R}
				end,
			lists:foldl(F, {[], D0}, lists:seq(1, Num))
	end.

write_list(List, ItModule, ItFun) ->
	write_list(List, ItModule, ItFun, []).

write_list(List, ItModule, ItFun, ArgList) ->
	L = erlang:length(List),
	if 
		L == 0 ->
			<<L:16>>;
		true ->
			F = fun(Value, Bin) ->
						Args = [Value] ++ ArgList,
						D = erlang:apply(ItModule, ItFun, Args),
						<<Bin/binary,D/binary>>
				end,
			B = lists:foldl(F, <<>>, List),
			<<L:16,B/binary>>
	end.

%% @doc read 32 bits singned int  
%% @see read_int/2
read_int(Bin) ->
	read_int(Bin, 32).

%% @doc read singned int by bits
%% @spec read_int(binary(), 8 | 16 | 32 ...)
read_int(Bin, Bits) ->
	<<I:Bits/integer-signed, Rest/binary>> = Bin,
	{I, Rest}.

write_int(Value) ->
	write_int(Value, 32).

write_int(Value, Bits) ->
	<<Value:Bits/integer-signed>>.

%% @doc read 32 bits unsingned int  
%% @see read_uint/2
read_uint(Bin) ->
	read_uint(Bin, 32).

%% @doc read unsingned int by bits
%% @spec read_int(binary(), 8 | 16 | 32 ...)
read_uint(Bin, Bits) ->
	<<I:Bits/integer, Rest/binary>> = Bin,
	{I, Rest}.

write_uint(Value) ->
	write_uint(Value, 32).

write_uint(Value, Bits) ->
	<<Value:Bits/integer>>.

read_float(Bin) ->
	read_float(Bin, 32).

read_float(Bin, Bits) ->
	<<F:Bits/float, Rest/binary>> = Bin,
	{F, Rest}.

write_float(Value) ->
	write_float(Value, 32).

write_float(Value, Bits) ->
	<<Value:Bits/float>>.

read_string(Bin) ->
	<<L:16,Rest/binary>> = Bin,
	
	case L =< 0 of
		true ->
			{"", Rest};
		false ->
			<<S:L/binary,Rest2/binary>> = Rest,
			Str = unicode:characters_to_binary(S),
			io:format("-----bin length = ~p  S= ~p str = ~p ~n",[L,S,Str]),
			{Str, Rest2}
	end.

write_string(Value) ->
	Bin = unicode:characters_to_binary(Value),
	L = byte_size(Bin),
	<<L:16, Bin/binary>>.
