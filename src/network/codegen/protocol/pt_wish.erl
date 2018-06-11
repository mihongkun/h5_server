%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_wish).
-include("pt_wish.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_wish{type = Type,wish = Wish}) ->
	Bin = protocol_parser:encode_send_wish(Type,Wish),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Wish=~p",[Type,Wish]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pay{type = Type,luck_num = Luck_num}) ->
	Bin = protocol_parser:encode_send_pay(Type,Luck_num),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Luck_num=~p",[Type,Luck_num]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_logs{type = Type,logs = Logs}) ->
	Bin = protocol_parser:encode_send_logs(Type,Logs),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Logs=~p",[Type,Logs]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_guest{type = Type,awards = Awards}) ->
	Bin = protocol_parser:encode_send_guest(Type,Awards),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Awards=~p",[Type,Awards]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_refresh_wish{type = Type,grids = Grids}) ->
	Bin = protocol_parser:encode_send_refresh_wish(Type,Grids),
	nw_util:proto_log_out(?MODULE,Bin,"Type=~p,Grids=~p",[Type,Grids]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_wish,"pt_wish:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 获取许愿池信息
decode_wish(Data) ->
	{Type} = protocol_parser:decode_on_wish(Data),
	nw_util:proto_log_in(?MODULE,?CS_WISH,"on_wish(Type=~p)",[Type]),
	{nh_wish,on_wish,[Type]}.

%% @doc 充值幸运币
decode_pay(Data) ->
	{Type,Num} = protocol_parser:decode_on_pay(Data),
	nw_util:proto_log_in(?MODULE,?CS_PAY,"on_pay(Type=~p,Num=~p)",[Type,Num]),
	{nh_wish,on_pay,[Type,Num]}.

%% @doc 获取中奖纪录列表
decode_logs(Data) ->
	{Type} = protocol_parser:decode_on_logs(Data),
	nw_util:proto_log_in(?MODULE,?CS_LOGS,"on_logs(Type=~p)",[Type]),
	{nh_wish,on_logs,[Type]}.

%% @doc 抽奖
decode_guest(Data) ->
	{Type,Num} = protocol_parser:decode_on_guest(Data),
	nw_util:proto_log_in(?MODULE,?CS_GUEST,"on_guest(Type=~p,Num=~p)",[Type,Num]),
	{nh_wish,on_guest,[Type,Num]}.

%% @doc 刷新许愿池
decode_refresh_wish(Data) ->
	{Type} = protocol_parser:decode_on_refresh_wish(Data),
	nw_util:proto_log_in(?MODULE,?CS_REFRESH_WISH,"on_refresh_wish(Type=~p)",[Type]),
	{nh_wish,on_refresh_wish,[Type]}.



