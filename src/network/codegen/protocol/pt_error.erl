%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_error).
-include("pt_error.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_error{proto = Proto,code = Code,parms = Parms}) ->
	Bin = protocol_parser:encode_send_error(Proto,Code,Parms),
	nw_util:proto_log_out(?MODULE,Bin,"Proto=~p,Code=~p,Parms=~p",[Proto,Code,Parms]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_error,"pt_error:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================



