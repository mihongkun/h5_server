%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_counter).
-include("pt_counter.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_counter_infos{counters = Counters}) ->
	Bin = protocol_parser:encode_send_counter_infos(Counters),
	nw_util:proto_log_out(?MODULE,Bin,"Counters=~p",[Counters]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_counter_update{type = Type,num = Num}) ->
	Bin = protocol_parser:encode_send_counter_update(Type,Num),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Num=~p",[Type,Num]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_counter,"pt_counter:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================



