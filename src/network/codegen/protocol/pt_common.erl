%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_common).
-include("pt_common.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================



send(Sid,_Record) ->
	?ERR(pt_common,"pt_common:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================



