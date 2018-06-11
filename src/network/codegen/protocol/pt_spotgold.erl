%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_spotgold).
-include("pt_spotgold.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_get_spotgold{refresh_time = Refresh_time,ordinary = Ordinary,intermediate = Intermediate,senior = Senior}) ->
	Bin = protocol_parser:encode_send_get_spotgold(Refresh_time,Ordinary,Intermediate,Senior),
	nw_util:proto_log_out(?MODULE,Bin,"Refresh_time=~p,Ordinary=~p,Intermediate=~p,Senior=~p",[Refresh_time,Ordinary,Intermediate,Senior]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_spotgold,"pt_spotgold:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 点金信息
decode_get_spotgold(Data) ->
	{} = protocol_parser:decode_on_get_spotgold(Data),
	nw_util:proto_log_in(?MODULE,?CS_GET_SPOTGOLD,"on_get_spotgold()",[]),
	{nh_spotgold,on_get_spotgold,[]}.

%% @doc 点金使用
decode_buy_spotgold(Data) ->
	{Type} = protocol_parser:decode_on_buy_spotgold(Data),
	nw_util:proto_log_in(?MODULE,?CS_BUY_SPOTGOLD,"on_buy_spotgold(Type=~p)",[Type]),
	{nh_spotgold,on_buy_spotgold,[Type]}.



