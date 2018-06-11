-module(item_util).
-include("item.hrl").
-include("pt_item.hrl").
-include("tips.hrl").
-include("data_item.hrl").

-compile(export_all).

% 根据品阶和类型随机找到一个
rand_item_by_type_and_order(Type,Order) ->
	% 找到候选列表
	Ids = [ID || #cfg_item{id = ID,type=T,quality = O} <- data_item:all(), Type =:= T andalso Order =:= O],
	% 在候选类表中找到一个
	util_lists:rand(Ids).

write_ps_reward_items(Type,CfgID,StackNum) ->
	#ps_reward_items{
	    type       = Type,
	    cfg_id     = CfgID,
	    stack_num  = StackNum
	}.

write_pt_chip_compose(List) ->
	#pt_chip_compose{
		items = [write_ps_reward_items(Type,CfgID,StackNum)|| {Type,CfgID,StackNum} <- List]
	}.

write_pt_compose_equipment(List) ->
	#pt_compose_equipment{
		items = [write_ps_reward_items(Type,CfgID,StackNum)|| {Type,CfgID,StackNum} <- List]
	}.

send_pt_equ(Sid,List) ->
	pt_item:send(Sid,write_pt_compose_equipment(List)).

send_pt_chip(Sid,List) ->
	pt_item:send(Sid,write_pt_chip_compose(List)).

