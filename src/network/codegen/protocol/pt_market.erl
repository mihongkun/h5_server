%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_market).
-include("pt_market.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_get_shop{items = Items}) ->
	Bin = protocol_parser:encode_send_get_shop(Items),
	nw_util:proto_log_out(?MODULE,Bin,"Items=~p",[Items]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_buy_market_props{item_id = Item_id,num = Num}) ->
	Bin = protocol_parser:encode_send_buy_market_props(Item_id,Num),
	nw_util:proto_log_out(?MODULE,Bin,"Item_id=~p,Num=~p",[Item_id,Num]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_market,"pt_market:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 请求商店信息
decode_get_shop(Data) ->
	{Shop_id} = protocol_parser:decode_on_get_shop(Data),
	nw_util:proto_log_in(?MODULE,?CS_GET_SHOP,"on_get_shop(Shop_id=~p)",[Shop_id]),
	{nh_market,on_get_shop,[Shop_id]}.

%% @doc 市场刷新
decode_refresh_market(Data) ->
	{Shop_id} = protocol_parser:decode_on_refresh_market(Data),
	nw_util:proto_log_in(?MODULE,?CS_REFRESH_MARKET,"on_refresh_market(Shop_id=~p)",[Shop_id]),
	{nh_market,on_refresh_market,[Shop_id]}.

%% @doc 市场购买
decode_buy_market_props(Data) ->
	{Shop_id,Shop_index} = protocol_parser:decode_on_buy_market_props(Data),
	nw_util:proto_log_in(?MODULE,?CS_BUY_MARKET_PROPS,"on_buy_market_props(Shop_id=~p,Shop_index=~p)",[Shop_id,Shop_index]),
	{nh_market,on_buy_market_props,[Shop_id,Shop_index]}.



