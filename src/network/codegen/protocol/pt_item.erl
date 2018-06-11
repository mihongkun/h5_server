%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_item).
-include("pt_item.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_get_items{items = Items}) ->
	Bin = protocol_parser:encode_send_get_items(Items),
	nw_util:proto_log_out(?MODULE,Bin,"Items=~p",[Items]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_update_items{items = Items}) ->
	Bin = protocol_parser:encode_send_update_items(Items),
	nw_util:proto_log_out(?MODULE,Bin,"Items=~p",[Items]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_sell_item{gold = Gold}) ->
	Bin = protocol_parser:encode_send_sell_item(Gold),
	nw_util:proto_log_out(?MODULE,Bin,"Gold=~p",[Gold]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_compose_equipment{items = Items}) ->
	Bin = protocol_parser:encode_send_compose_equipment(Items),
	nw_util:proto_log_out(?MODULE,Bin,"Items=~p",[Items]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_chip_compose{items = Items}) ->
	Bin = protocol_parser:encode_send_chip_compose(Items),
	nw_util:proto_log_out(?MODULE,Bin,"Items=~p",[Items]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_item,"pt_item:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 出售物品
decode_sell_item(Data) ->
	{Cfg_id,Num} = protocol_parser:decode_on_sell_item(Data),
	nw_util:proto_log_in(?MODULE,?CS_SELL_ITEM,"on_sell_item(Cfg_id=~p,Num=~p)",[Cfg_id,Num]),
	{nh_item,on_sell_item,[Cfg_id,Num]}.

%% @doc 合成装备
decode_compose_equipment(Data) ->
	{Cfg_id,Compose_times} = protocol_parser:decode_on_compose_equipment(Data),
	nw_util:proto_log_in(?MODULE,?CS_COMPOSE_EQUIPMENT,"on_compose_equipment(Cfg_id=~p,Compose_times=~p)",[Cfg_id,Compose_times]),
	{nh_item,on_compose_equipment,[Cfg_id,Compose_times]}.

%% @doc 碎片合成
decode_chip_compose(Data) ->
	{Cfg_id,Compose_times} = protocol_parser:decode_on_chip_compose(Data),
	nw_util:proto_log_in(?MODULE,?CS_CHIP_COMPOSE,"on_chip_compose(Cfg_id=~p,Compose_times=~p)",[Cfg_id,Compose_times]),
	{nh_item,on_chip_compose,[Cfg_id,Compose_times]}.



