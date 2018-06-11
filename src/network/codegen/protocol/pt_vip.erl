%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_vip).
-include("pt_vip.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_resp_get_vip_base_info{vip_base_info = Vip_base_info}) ->
	Bin = protocol_parser:encode_send_resp_get_vip_base_info(Vip_base_info),
	nw_util:proto_log_out(?MODULE,Bin,"Vip_base_info=~p",[Vip_base_info]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_resp_notify_vip_gift_change{vip_gift_info = Vip_gift_info}) ->
	Bin = protocol_parser:encode_send_resp_notify_vip_gift_change(Vip_gift_info),
	nw_util:proto_log_out(?MODULE,Bin,"Vip_gift_info=~p",[Vip_gift_info]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_resp_get_first_recharge_info{first_recharge_award_state = First_recharge_award_state,first_recharge_item_list = First_recharge_item_list}) ->
	Bin = protocol_parser:encode_send_resp_get_first_recharge_info(First_recharge_award_state,First_recharge_item_list),
	nw_util:proto_log_out(?MODULE,Bin,"First_recharge_award_state=~p,First_recharge_item_list=~p",[First_recharge_award_state,First_recharge_item_list]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_vip,"pt_vip:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 获取VIP基础信息
decode_get_vip_base_info(Data) ->
	{} = protocol_parser:decode_on_get_vip_base_info(Data),
	nw_util:proto_log_in(?MODULE,?CS_GET_VIP_BASE_INFO,"on_get_vip_base_info()",[]),
	{nh_vip,on_get_vip_base_info,[]}.

%% @doc 购买VIP礼包
decode_buy_vip_gift(Data) ->
	{Vip_level} = protocol_parser:decode_on_buy_vip_gift(Data),
	nw_util:proto_log_in(?MODULE,?CS_BUY_VIP_GIFT,"on_buy_vip_gift(Vip_level=~p)",[Vip_level]),
	{nh_vip,on_buy_vip_gift,[Vip_level]}.

%% @doc 获取首充礼包信息
decode_get_first_recharge_info(Data) ->
	{} = protocol_parser:decode_on_get_first_recharge_info(Data),
	nw_util:proto_log_in(?MODULE,?CS_GET_FIRST_RECHARGE_INFO,"on_get_first_recharge_info()",[]),
	{nh_vip,on_get_first_recharge_info,[]}.

%% @doc 获取首充礼包奖励
decode_get_first_recharge_award(Data) ->
	{} = protocol_parser:decode_on_get_first_recharge_award(Data),
	nw_util:proto_log_in(?MODULE,?CS_GET_FIRST_RECHARGE_AWARD,"on_get_first_recharge_award()",[]),
	{nh_vip,on_get_first_recharge_award,[]}.



