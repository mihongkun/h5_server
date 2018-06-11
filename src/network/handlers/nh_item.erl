%%% 2018-5-24 mihongkun@gmail.com
%%% on_sell_item/2 出售物品 Cfg_id(物品配置ID), Num(要出售的物品数量) 
%%% on_compose_equipment/2 合成装备 Cfg_id(物品配置的ID)，Compose_times(合成次数或理解为合成数量 --> 要合成的物品数量 不是原料数量)
%%% on_chip_compose/2 碎片合成Cfg_id(物品配置的ID)，Compose_times(合成次数或理解为合成数量 --> 要合成的物品数量 不是原料数量)



-module(nh_item).
-compile(export_all).


%% 出售物品
on_sell_item(Cfg_id, Num) -> 
	Sid = get(sid),
	mod_item:sell_item(Sid,Cfg_id,Num).

%% 合成装备
on_compose_equipment(Cfg_id, Compose_times) ->
	Sid = get(sid),
	mod_item:equipment_compine(Sid,Cfg_id,Compose_times).


%% 碎片合成
on_chip_compose(Cfg_id, Compose_times) ->
	Sid = get(sid),
	mod_item:chip_compine(Sid,Cfg_id,Compose_times).






