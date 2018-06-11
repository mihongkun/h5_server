%%市场模块

-module(mod_market).
-include("common.hrl").
-include("market.hrl").
-include("data_shop.hrl").
-include("data_shop_item.hrl").
-include("pt_market.hrl").
-include("sys_macro.hrl").
-include("log_type.hrl").
-include("tips.hrl").
-compile(export_all).

-export([
	login/4,
	check_market/2,                    %%查询商店信息 Sid,Shop_id ->  列出玩家对应商店信息
	init_market/2,				       %%刷新商店根据随机规则列出物品  Sid,Shop_id ->#data_shop_item  根据配置随机出列表插入一条数据
	random_market/1,
	consump_refresh_market/2           %%刷新商店 Sid,Shop_id  -> 判断是否到免费刷新时间，刷新商店列出物品
	%buy_item/3                       %%购买物品 Sid,Shop_id,Goods_id -> 查看商店物品是否还有购买次数，购买物品扣除货币
	]).

%%登录
login(Sid,Pid,Socket,ShopID)->
	put(sid,Sid),
	put(socket,Socket),
	?DBG(mod_market,"login sid = ~p,pid = ~p",[Sid,Pid]),
	check_market(Sid,ShopID),
	gen_server:cast(Pid,{login_load_mod_finish,?MODULE}).

%%查询市场的物品列表
check_market(Sid,ShopID)->
	case cache:lookup(market,{Sid,ShopID}) of 
	[]->  										%没有数据初始化市场信息
		case ShopID of
			ShopID when ShopID == 1 ->          %市场数据初始化
				init_market(Sid,ShopID);
			ShopID when ShopID > 1 ->   		%其他商店数据初始化
				ordinary_market(Sid,ShopID)
		end;
	[Item] ->
			Item
	end.

%其他商店刷新规则
ordinary_market(Sid,ShopID)->
	ShopCfg = data_shop:get(ShopID),
	Number = ShopCfg#cfg_shop.prop_number,
	Reset_time = util:unixtime() + ShopCfg#cfg_shop.reset_time*?SECONDS_PER_HOUR,
	Refresh_time = util:unixtime() + ShopCfg#cfg_shop.refresh_time*?SECONDS_PER_HOUR,

	M = get_data_mod(ShopID),
 	ShopItems = apply(M,all,[]),
 	Items = [{Cfg#cfg_shop_item.goodsid,Cfg#cfg_shop_item.frequency} || Cfg <- ShopItems],
 	cache:insert(#market{
	key={Sid,ShopID}, 					 %sid,shop_id 玩家ID 商店ID
	items=Items,  					 %[{freshid,buytime}] 物品id ，购买次数
	free_refresh_time=Reset_time, 	 %免费刷新时间，如果少于当前时间可免费刷新
	force_fresh_time=Refresh_time    %强制刷新时间
	}).

%%刷新商店根据随机规则列出物品
init_market(Sid,ShopID)->
	ShopCfg = data_shop:get(ShopID),              %获取市场配置
	Number = ShopCfg#cfg_shop.prop_number,

	Reset_time = util:unixtime() + ShopCfg#cfg_shop.reset_time*?SECONDS_PER_HOUR,
	Refresh_time = util:unixtime() + ShopCfg#cfg_shop.refresh_time*?SECONDS_PER_HOUR,

	M = get_data_mod(ShopID),
 	ShopItems = apply(M,all,[]),
	%ShopItems = data_shop_item:all(),

	CfgList = [random_market(ShopItems) || A <- lists:duplicate(Number,1)],
	Items = [{Cfg#cfg_shop_item.id,Cfg#cfg_shop_item.frequency} || Cfg <- CfgList ],

	cache:insert(#market{
	key={Sid,ShopID}, 					 %sid,shop_id 玩家ID 商店ID
	items=Items,  					 %[{freshid,buytime}] 物品id ，购买次数
	free_refresh_time=Reset_time, 	 %免费刷新时间，如果少于当前时间可免费刷新
	force_fresh_time=Refresh_time    %强制刷新时间
	}).
	%%[{Cfg_shop_item,Item_id,Goods_id,Number,Frequency,Currency_type,Price,Weight}|Rest] =Shop_item,
	%%{Cfg_shop_item,Item_id,Goods_id,Number,Frequency,Currency_type,Price,Weight}.

update_market(Sid,ShopID)->
	ShopCfg = data_shop:get(ShopID),              %%获取市场配置
	Number = ShopCfg#cfg_shop.prop_number,

	Reset_time = util:unixtime() + ShopCfg#cfg_shop.reset_time*?SECONDS_PER_HOUR,
	Refresh_time = util:unixtime() + ShopCfg#cfg_shop.refresh_time*?SECONDS_PER_HOUR,

	M = get_data_mod(ShopID),
 	ShopItems = apply(M,all,[]),
	%ShopItems = data_shop_item:all(),

	CfgList = [random_market(ShopItems) || A <- lists:duplicate(Number,1)],
	Items = [{Cfg#cfg_shop_item.id,Cfg#cfg_shop_item.frequency} || Cfg <- CfgList ],

	cache:update(#market{
	key={Sid,1}, 					 %%sid,shop_id 玩家ID 商店ID
	items=Items,  					 %%[{freshid,buytime}] 物品id ，购买次数
	free_refresh_time=Reset_time 	 %%免费刷新时间，如果少于当前时间可免费刷新
	}).


%%根据data_shop_item随机取一个
random_market(Shop_item)->
	Length_item = erlang:length(Shop_item),
	Prosum = lists:foldl(fun({Cfg_shop_item,Item_id,Goods_id,Number,Frequency,Currency_type,Price,Weight},Total)->Total+Weight end, 0,Shop_item),
	Rannum = util:rand(1,Prosum),
	%[{Cfg_shop_item,Item_id,Goods_id,Number,Frequency,Currency_type,Price,Weight}|Rest] =Shop_item,
	total_item(Shop_item,Rannum).


%%根据权重取值
total_item([Cfg=#cfg_shop_item{weight = Weight}|Res],Total) when Weight >= Total -> 
  Cfg;
total_item([Cfg=#cfg_shop_item{weight = Weight}|Res],Total) ->
  total_item(Res,Total - Weight).


%%前端协议   获取市场信息
send_client_shop(Sid,ShopID)->
	[Market] = cache:lookup(market,{Sid,ShopID}),
	Items = Market#market.items,
	pt_market:send(Sid,#pt_get_shop{
    items  = market_ps_items(Items)  % list(ps_shop_item) 商店物品信息
}).

market_ps_items(Items)->
	[#ps_shop_item{
		shop_item_id  = Shop_item_id,  % integer() 商店物品配置
	    res_num       = Res_num        % integer() 物品剩余数量
		}|| {Shop_item_id,Res_num} <- Items].
	

%%刷新商店消耗货币或免费
consump_refresh_market(Sid,ShopID)->
	ShopCfg = data_shop:get(ShopID), 
	[Market] = cache:lookup(market,{Sid,ShopID}),
	Free_refresh_time = Market#market.free_refresh_time,
	Refresh_type = ShopCfg#cfg_shop.refresh_type,     				 %类型
	Refresh_money = ShopCfg#cfg_shop.refresh_money,     			 %价格
	%%Force_fresh_time = Market#market.force_fresh_time,
	
	case (util:unixtime() - ShopCfg#cfg_shop.reset_time*?SECONDS_PER_HOUR - Free_refresh_time) of 
		Free_time when Free_time > 0 ->
				update_market(Sid,ShopID);          %执行免费刷新
		Free_time when Free_time < 0 ->
			case mod_item:use(Sid, turn_type(Refresh_type),Refresh_money,?OP_TYPE_MARKET_REFRESH) of   %执行消耗货币刷新
				true -> 
					update_market(Sid,ShopID),
					send_client_shop(Sid,ShopID);
				false -> void
			end
	end.

%%购买并扣除玩家货币
buy_props(Sid,ShopID,Index)->
	[Market] = cache:lookup(market,{Sid,ShopID}),
	Items = Market#market.items,
	buy_item(Sid,ShopID,Items,Index).

	
%%购买商品
buy_item(Sid,ShopID,Items,Index)->
	{Goodsid,Frequency} = lists:nth(Index,Items),
	
	M = get_data_mod(ShopID),
 	ShopItems = apply(M,get,[Goodsid]),

	%ShopItems = data_shop_item:get(Goodsid),  				 %获取道具表
	CurrencyType = ShopItems#cfg_shop_item.currency_type,    %货币类型
	Price = ShopItems#cfg_shop_item.price,     				 %价格
	Number = ShopItems#cfg_shop_item.number,                 %数量

	case Frequency >0 of
		true ->
			case (mod_item:use(Sid, [{turn_type(CurrencyType),Price}],?OP_TYPE_MARKET_REFRESH)) of %检查并使用货币
				true->
				NewItems = util_lists:replace(Index,{Goodsid,Frequency-1},Items                                                                                                                                                            ),
				mod_item:add(Sid,Goodsid,Number,?OP_TYPE_MARKET_PROPS),                       %添加物品
				cache:update(#market{                    %扣除物品购买次数
					key={Sid,ShopID}, 					 %%sid,shop_id 玩家ID 商店ID
					items=NewItems  					 %%[{freshid,buytime}] 物品id ，购买次数
					}),
				send_client_shop(Sid,ShopID);
				{false,TipsID}->
				{false,TipsID}
			end;
		false -> proto:send_error(Sid,?TIPS_NOT_ENOUGH_ITEM)
	end.

turn_type(?MARKET_TYPE_DIAMOND)->?diamond;
turn_type(?MARKET_TYPE_GOLD)->?gold;
turn_type(_)->-0.

%%前端协议   刷新获取市场信息
refresh_market(Sid,ShopID)->
	consump_refresh_market(Sid,ShopID).
	

%%前端协议  商店购买
buy_market_props(Sid,ShopID,Index)->
	buy_props(Sid,ShopID,Index).


get_data_mod(1) ->  data_shop_item;
get_data_mod(2) ->  data_shop_guild_item;
get_data_mod(3) ->  data_shop_wish_item;
get_data_mod(4) ->  data_shop_altat_item;
get_data_mod(_) ->  undefined.


