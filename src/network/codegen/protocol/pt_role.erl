%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols

-module(pt_role).
-include("pt_role.hrl").
-include("log.hrl").
-compile(export_all).


%% ================== send methods=====================


send(SID,_PT=#pt_roles{roles = Roles}) ->
	Bin = protocol_parser:encode_send_roles(Roles),
	nw_util:proto_log_out(?MODULE,Bin,"Roles=~p",[Roles]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_roles_update{roles = Roles}) ->
	Bin = protocol_parser:encode_send_roles_update(Roles),
	nw_util:proto_log_out(?MODULE,Bin,"Roles=~p",[Roles]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_roles_delete{roles = Roles}) ->
	Bin = protocol_parser:encode_send_roles_delete(Roles),
	nw_util:proto_log_out(?MODULE,Bin,"Roles=~p",[Roles]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_role_grid_info{grid = Grid,buy_cost = Buy_cost,buy_add = Buy_add}) ->
	Bin = protocol_parser:encode_send_role_grid_info(Grid,Buy_cost,Buy_add),
	nw_util:proto_log_out(?MODULE,Bin,"Grid=~p,Buy_cost=~p,Buy_add=~p",[Grid,Buy_cost,Buy_add]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_role_call_info{free_ts1 = Free_ts1,free_ts2 = Free_ts2,free_ts3 = Free_ts3}) ->
	Bin = protocol_parser:encode_send_role_call_info(Free_ts1,Free_ts2,Free_ts3),
	nw_util:proto_log_out(?MODULE,Bin,"Free_ts1=~p,Free_ts2=~p,Free_ts3=~p",[Free_ts1,Free_ts2,Free_ts3]),
	proto:send(SID,Bin);


send(SID,_PT=#pt_call_result{roles = Roles}) ->
	Bin = protocol_parser:encode_send_call_result(Roles),
	nw_util:proto_log_out(?MODULE,Bin,"Roles=~p",[Roles]),
	proto:send(SID,Bin);



send(Sid,_Record) ->
	?ERR(pt_role,"pt_role:send error record, sid = ~p, record = ~p",[Sid,_Record]),
	invalid.


%% ===================handler methods===================

%% @doc 召唤佣兵
decode_call_role(Data) ->
	{Type,Use_diamond,Times} = protocol_parser:decode_on_call_role(Data),
	nw_util:proto_log_in(?MODULE,?CS_CALL_ROLE,"on_call_role(Type=~p,Use_diamond=~p,Times=~p)",[Type,Use_diamond,Times]),
	{nh_role,on_call_role,[Type,Use_diamond,Times]}.

%% @doc 佣兵升级
decode_upgrade_role(Data) ->
	{Uid} = protocol_parser:decode_on_upgrade_role(Data),
	nw_util:proto_log_in(?MODULE,?CS_UPGRADE_ROLE,"on_upgrade_role(Uid=~p)",[Uid]),
	{nh_role,on_upgrade_role,[Uid]}.

%% @doc 佣兵穿戴
decode_put_equip(Data) ->
	{Type,Uid,Item_id} = protocol_parser:decode_on_put_equip(Data),
	nw_util:proto_log_in(?MODULE,?CS_PUT_EQUIP,"on_put_equip(Type=~p,Uid=~p,Item_id=~p)",[Type,Uid,Item_id]),
	{nh_role,on_put_equip,[Type,Uid,Item_id]}.

%% @doc 佣兵进化
decode_up_quality(Data) ->
	{Uid} = protocol_parser:decode_on_up_quality(Data),
	nw_util:proto_log_in(?MODULE,?CS_UP_QUALITY,"on_up_quality(Uid=~p)",[Uid]),
	{nh_role,on_up_quality,[Uid]}.

%% @doc 佣兵觉醒
decode_up_star(Data) ->
	{Uid} = protocol_parser:decode_on_up_star(Data),
	nw_util:proto_log_in(?MODULE,?CS_UP_STAR,"on_up_star(Uid=~p)",[Uid]),
	{nh_role,on_up_star,[Uid]}.

%% @doc 购买格子
decode_buy_grid(Data) ->
	{} = protocol_parser:decode_on_buy_grid(Data),
	nw_util:proto_log_in(?MODULE,?CS_BUY_GRID,"on_buy_grid()",[]),
	{nh_role,on_buy_grid,[]}.



