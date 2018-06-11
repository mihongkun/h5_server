%% 物品操作模块
%% 2018-5-21	mihongkun@gmail.com

-module(item_op).
-include("data_item.hrl").
-include("data_item_com.hrl").
-include("pt_item.hrl").
-include("common.hrl").
-include("item.hrl").
-include("data_effect.hrl").
-compile(export_all).


% 客户端调用需要的API
-export ([
		chip_compine/3,						% 碎片合成 Sid,CfgID,Num -> 消耗原料，合成物品（通知客户端原料剩余，物品合成数量，物品总数）
		equipment_compine/3,				% 装备合成 Sid,CfgID,Num -> 消耗原料，消费资产，合成装备（通知客户端原料余额，物品合成数量，物品总数，资产余额）
		sell_items/3						% 出售物品 Sid,CfgID,Num -> 物品余量，资产增量，资产总量
	]).


%% 碎片合成 %% Sid玩家id CfgID物品id Num要合成的数量 
chip_compine(Sid,CfgID,Num) -> 
	Rem = call_one_use_num(CfgID) * Num,
	try
		case get_effect_type_by_cfg_id(CfgID) of
			?COMPOSE_HERO ->
				?TRY(mod_role:check_grid_enough(Sid,Num)),
				% 减少原料
				?TRY(mod_item:use(Sid,CfgID,Rem,?OP_TYPE_ITEM_CHIP_COMPOSE)),
				HeroId = get_hero_id_by_cfg_id(CfgID),
				mod_role:add_roles(Sid,[{HeroId,Num}],?OP_TYPE_ROLE_COMPILE),
				item_util:send_chip(Sid,[{?REWARD_ITEM_TYPE_ROLE,HeroId,Num}]);
			?COMPOSE_ART ->
				?TRY(mod_item:use(Sid,CfgID,Rem,?OP_TYPE_ITEM_CHIP_COMPOSE)),
				ArtID = get_art_id_by_cfg_id(CfgID),
				mod_item:add(Sid,ArtID,Num,?OP_TYPE_ITEM_CHIP_COMPOSE),
				item_util:send_chip(Sid,[{?REWARD_ITEM_TYPE_ITEM,ArtID,Num}])
		end
	catch throw:?break ->
		void 
	end.

%% 召唤一个所需要的碎片数量
call_one_use_num(CfgID) -> 
	E = get_cfg_item(CfgID),
	E#cfg_item.call_num.


%% 通过配置id获取英雄id
get_hero_id_by_cfg_id(CfgID) ->
	get_hero_id(get_effect_id(CfgID)).
get_art_id_by_cfg_id(CfgID) ->
	get_art_id(get_effect_id(CfgID)).
get_effect_type_by_cfg_id(CfgID) ->
	get_effect_type(get_effect_id(CfgID)).

%% 因为召唤英雄（背包中碎片合成用到道具表中的配置数据）需要先获取效果id再根据效果id获取英雄ID
get_hero_id(EffectID) ->
	E = get_effect(EffectID),
	case E#cfg_effect.hero_id of
		0 ->
			E#cfg_effect.herosjid;
		A -> A
	end.

%% 通过道具配置ID获取效果ID
get_effect_id(CfgID) ->
	E = get_cfg_item(CfgID),
	E#cfg_item.eff_type.

%% 获取效果
get_effect(EffectID) ->
	data_effect:get(EffectID).

get_effect_type(EffectID) ->
	E = get_effect(EffectID),
	E#cfg_effect.effect_type.

get_art_id(EffectID) ->
	E = get_effect(EffectID),
	case E#cfg_effect.sqid of
		0 -> E#cfg_effect.sqsjid;
		A -> A
	end.



%% 装备合成 
% 检查碎片够不够 如果不足要向客户端发送物品不足的提示 
% 检查检查金币够不够 如果不够要向客户端发送金币不够的提示
equipment_compine(Sid,CfgID,Num) ->
	Total = get_com_price(CfgID) * Num,
	Mid = get_material_id(CfgID),
	Consume = get_com_items_num(CfgID) * Num,
	try ?TRY(mod_item:check(Sid,?gold,Total)),
		?TRY(mod_item:check(Sid,Mid, Consume)),
		?TRY(mod_item:use(Sid,?gold,Total,?OP_TYPE_ITEM_EQUIPMENT_COMPOSE)),
		?TRY(mod_item:use(Sid,Mid,Consume,?OP_TYPE_ITEM_EQUIPMENT_COMPOSE)),
		mod_item:add(Sid,CfgID,Num,?OP_TYPE_ITEM_EQUIPMENT_COMPOSE),
		item_util:send_equ(Sid,[?REWARD_ITEM_TYPE_ITEM,CfgID,Num])
	catch 
		throw:?break ->
			void
	end.

%% 获取材料ID
get_material_id(CfgID) ->
	E = get_com_cfg(CfgID),
	E#cfg_item_com.stuff_num.


%% 获取合成需要的材料数量
get_com_items_num(CfgID) ->
	E = get_com_cfg(CfgID),
	E#cfg_item_com.stuff_num.

%% 获取合成配置信息
get_com_cfg(CfgID) ->
	data_item_com:get(CfgID). 

%% 获取合成单价
get_com_price(CfgID) ->
	E = get_com_cfg(CfgID),
	E#cfg_item_com.gold.



%% 出售物品
sell_items(Sid,CfgID,Num) ->
	try ?TRY(can_sell(Sid,CfgID)),
		?TRY(mod_item:use(Sid,CfgID,Num)),	
		Total = get_cfg_price(CfgID) * Num,
		mod_item:add(Sid,?gold,Total,?OP_TYPE_ITEM_SELL),
		send_client_pt_sell_ret(Sid,Total)	
	catch throws:?break ->
		void
	end.

%% 是否可以出售
can_sell(Sid,CfgID) ->
	E = get_cfg_item(CfgID),
	case E#cfg_item.can_sell of
		?CAN_SELL -> 
			true;
		?CAN_NOT_SELL -> 
			proto:send_error(Sid,?TIPS_CAN_NOT_SELL),
			false
	end.

% 获取物品售出价格
get_cfg_price(CfgID) ->
	E = get_cfg_item(CfgID),
	E#cfg_item.price.

% 获取物品配置信息
get_cfg_item(CfgID) -> 
	 data_item:get(CfgID).

%% 向客户端发送物品出售的应答数据
send_client_pt_sell_ret(Sid,Gold) ->
	pt_item:send(
			Sid,write_ps_sell_ret(Gold)
		).

write_ps_sell_ret(Gold) ->
	#pt_sell_item{
		gold = Gold
	}.
