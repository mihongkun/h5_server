%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_economy).
-include("pt_economy.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_economy_info{diamond = Diamond,gold = Gold,soul = Soul,water = Water,water_time = Water_time,stamen = Stamen,stamen_time = Stamen_time,narc = Narc,narc_time = Narc_time}) ->
	Bin = protocol_parser:encode_send_economy_info(Diamond,Gold,Soul,Water,Water_time,Stamen,Stamen_time,Narc,Narc_time),
	nw_util:proto_log_out(?MODULE,Bin,"Diamond=~p,Gold=~p,Soul=~p,Water=~p,Water_time=~p,Stamen=~p,Stamen_time=~p,Narc=~p,Narc_time=~p",[Diamond,Gold,Soul,Water,Water_time,Stamen,Stamen_time,Narc,Narc_time]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_diamond_update{diamond = Diamond}) ->
	Bin = protocol_parser:encode_send_diamond_update(Diamond),
	nw_util:proto_log_out(?MODULE,Bin,"Diamond=~p",[Diamond]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_gold_update{gold = Gold}) ->
	Bin = protocol_parser:encode_send_gold_update(Gold),
	nw_util:proto_log_out(?MODULE,Bin,"Gold=~p",[Gold]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_soul_update{soul = Soul}) ->
	Bin = protocol_parser:encode_send_soul_update(Soul),
	nw_util:proto_log_out(?MODULE,Bin,"Soul=~p",[Soul]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_water_update{water = Water,water_time = Water_time}) ->
	Bin = protocol_parser:encode_send_water_update(Water,Water_time),
	nw_util:proto_log_out(?MODULE,Bin,"Water=~p,Water_time=~p",[Water,Water_time]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_stamen_update{stamen = Stamen,stamen_time = Stamen_time}) ->
	Bin = protocol_parser:encode_send_stamen_update(Stamen,Stamen_time),
	nw_util:proto_log_out(?MODULE,Bin,"Stamen=~p,Stamen_time=~p",[Stamen,Stamen_time]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_narc_update{narc = Narc,narc_time = Narc_time}) ->
	Bin = protocol_parser:encode_send_narc_update(Narc,Narc_time),
	nw_util:proto_log_out(?MODULE,Bin,"Narc=~p,Narc_time=~p",[Narc,Narc_time]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_economy,"pt_economy:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================



