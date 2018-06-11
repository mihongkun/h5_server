%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_pub).
-include("pt_pub.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_pub{tasks = Tasks}) ->
	Bin = protocol_parser:encode_send_pub(Tasks),
	nw_util:proto_log_out(?MODULE,Bin,"Tasks=~p",[Tasks]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pub_start{id = Id}) ->
	Bin = protocol_parser:encode_send_pub_start(Id),
	nw_util:proto_log_out(?MODULE,Bin,"Id=~p",[Id]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pub_cancel{id = Id}) ->
	Bin = protocol_parser:encode_send_pub_cancel(Id),
	nw_util:proto_log_out(?MODULE,Bin,"Id=~p",[Id]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pub_use{id = Id,name = Name,starid = Starid,time = Time,item = Item,num = Num,lock = Lock,start = Start,cons = Cons}) ->
	Bin = protocol_parser:encode_send_pub_use(Id,Name,Starid,Time,Item,Num,Lock,Start,Cons),
	nw_util:proto_log_out(?MODULE,Bin,"Id=~p,Name=~p,Starid=~p,Time=~p,Item=~p,Num=~p,Lock=~p,Start=~p,Cons=~p",[Id,Name,Starid,Time,Item,Num,Lock,Start,Cons]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pub_refresh{tasks = Tasks}) ->
	Bin = protocol_parser:encode_send_pub_refresh(Tasks),
	nw_util:proto_log_out(?MODULE,Bin,"Tasks=~p",[Tasks]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pub_acc{id = Id,num = Num}) ->
	Bin = protocol_parser:encode_send_pub_acc(Id,Num),
	nw_util:proto_log_out(?MODULE,Bin,"Id=~p,Num=~p",[Id,Num]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pub_done{id = Id,num = Num}) ->
	Bin = protocol_parser:encode_send_pub_done(Id,Num),
	nw_util:proto_log_out(?MODULE,Bin,"Id=~p,Num=~p",[Id,Num]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_pub_lock{id = Id,type = Type}) ->
	Bin = protocol_parser:encode_send_pub_lock(Id,Type),
	nw_util:proto_log_out(?MODULE,Bin,"Id=~p,Type=~p",[Id,Type]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_pub,"pt_pub:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 获取酒馆的基本信息点击酒馆时触发
decode_pub(Data) ->
	{} = protocol_parser:decode_on_pub(Data),
	nw_util:proto_log_in(?MODULE,?CS_PUB,"on_pub()",[]),
	{nh_pub,on_pub,[]}.

%% @doc 点击开始任务按钮
decode_pub_start(Data) ->
	{Id,Heros} = protocol_parser:decode_on_pub_start(Data),
	nw_util:proto_log_in(?MODULE,?CS_PUB_START,"on_pub_start(Id=~p,Heros=~p)",[Id,Heros]),
	{nh_pub,on_pub_start,[Id,Heros]}.

%% @doc 取消任务
decode_pub_cancel(Data) ->
	{Id} = protocol_parser:decode_on_pub_cancel(Data),
	nw_util:proto_log_in(?MODULE,?CS_PUB_CANCEL,"on_pub_cancel(Id=~p)",[Id]),
	{nh_pub,on_pub_cancel,[Id]}.

%% @doc 使用任务卷轴
decode_pub_use(Data) ->
	{Type} = protocol_parser:decode_on_pub_use(Data),
	nw_util:proto_log_in(?MODULE,?CS_PUB_USE,"on_pub_use(Type=~p)",[Type]),
	{nh_pub,on_pub_use,[Type]}.

%% @doc 刷新任务列表
decode_pub_refresh(Data) ->
	{} = protocol_parser:decode_on_pub_refresh(Data),
	nw_util:proto_log_in(?MODULE,?CS_PUB_REFRESH,"on_pub_refresh()",[]),
	{nh_pub,on_pub_refresh,[]}.

%% @doc 加速任务
decode_acc(Data) ->
	{Id} = protocol_parser:decode_on_acc(Data),
	nw_util:proto_log_in(?MODULE,?CS_ACC,"on_acc(Id=~p)",[Id]),
	{nh_pub,on_acc,[Id]}.

%% @doc 完成
decode_pub_done(Data) ->
	{Id} = protocol_parser:decode_on_pub_done(Data),
	nw_util:proto_log_in(?MODULE,?CS_PUB_DONE,"on_pub_done(Id=~p)",[Id]),
	{nh_pub,on_pub_done,[Id]}.

%% @doc 加解锁操作
decode_pub_lock(Data) ->
	{Id,Type} = protocol_parser:decode_on_pub_lock(Data),
	nw_util:proto_log_in(?MODULE,?CS_PUB_LOCK,"on_pub_lock(Id=~p,Type=~p)",[Id,Type]),
	{nh_pub,on_pub_lock,[Id,Type]}.



