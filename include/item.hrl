-ifndef(__ITEM_HRL__).
-define(__ITEM_HRL__, true).


-include("common.hrl").


-define(ECONOMY_ITEMS,	[?gold,?diamond,?soul,?water,?stamen,?narc]).	% 经济物品
-define(CAN_SELL, 0). 													% 能够出售
-define(CAN_NOT_SELL, 1). 												% 不能够出售
-define(COMPOSE_HERO,1).												% 合成英雄的效果类型
-define(COMPOSE_ART,2).													% 合成神器的效果类型
-define(COMPOSE_WITCH_ID,0).											% 碎片合成时选择随机id还是固定id依据





-record(item, {
    key  		= {0,0},	%% {sid,cfg_id}
    stack_num 	= 0  		%% 堆叠数量
}).


%% 兑换商店
-record(cfg_exchange_item,{
	id						= 0,
	item_id					= 0,
	shop_type				= 0,
	shop_level				= 0,
	currency				= 0,
	cost					= 0,
	num						= 0
}).





-endif.