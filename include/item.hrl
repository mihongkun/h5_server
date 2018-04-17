-ifndef(__ITEM_HRL__).
-define(__ITEM_HRL__, true).

-define(ITEM_TYPE_EQUIP,		1).		% 装备
-define(ITEM_TYPE_ROLE,			2).		% 佣兵类 备注：佣兵是不属于道具，这个类基本用不到，暂时放着吧
-define(ITEM_TYPE_STAR_EQUIP,	3).		% 升星装备
-define(ITEM_TYPE_STONE,		4).		% 宝石　
-define(ITEM_TYPE_RUNE,			5).		% 符文
-define(ITEM_TYPE_PACKAGE,		6).		% 礼包类
-define(ITEM_TYPE_BUILDING,		7).		% 建筑类
-define(ITEM_TYPE_CHIP,			8).		% 碎片类



-record(item, {
    key  	= {0,0},	%%{accountID,WorldID}
    bag_type = 0,  %% 0普通，1存放交易行
    cfg_id = 0,  %% 
    role_id = 0,  %% 
    stack_num = 0,  %% 
    is_bind = 0,  %% 
    state = 1,  %% 状态（是否新获得）
    strong = 0,  %% 
    exp = 0,
    random_attr = [],  %% 
    create_time = 0  %%  				    
}).



-record(cfg_item,{
	cfg_id          = 0,
	icon            = 0,
	name            = "",
	career          = 0,
	level           = 0,
	quality         = 1,
	type_1          = 4,
	type_2          = 0, 
	sale_price      = 0,
	is_stack        = 0,
	auto_compose_id = 0,
	is_auto_compose = 0,
	desc            = "",
	attr_desc       = "",
	is_auto_use     = 0,
	is_pop_tip      = 0,
	use_effect		= 0,
	role_id         = 0,
	role_icon       = 0,
	bulletin_id     = 0,
	pop_box_id      = 0,
	need_exp        = 0,
	eat_exp         = 0,
	need_gold       = 0,
	buff 	        = []
}).

%% 兑换商店
-record(cfg_exchange_item,{
	id							= 0,
	item_id					= 0,
	shop_type				= 0,
	shop_level			= 0,
	currency				= 0,
	cost						= 0,
	num							= 0
}).





-endif.