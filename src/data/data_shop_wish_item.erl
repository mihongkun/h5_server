%% this file is auto maked!
-module(data_shop_wish_item).
-include("data_shop_item.hrl").
-compile(export_all).

%% S-商店相关表格\许愿池商店物品表.xlsx

get(101) ->
	#cfg_shop_item{
		id            = 101,
		goodsid       = 10001,
		number        = 1,
		frequency     = 1,
		currency_type = 5,
		price         = 1000
	};
get(102) ->
	#cfg_shop_item{
		id            = 102,
		goodsid       = 10001,
		number        = 50,
		frequency     = 1,
		currency_type = 5,
		price         = 1000
	};
get(103) ->
	#cfg_shop_item{
		id            = 103,
		goodsid       = 10001,
		number        = 1,
		frequency     = 1,
		currency_type = 5,
		price         = 1000
	};
get(104) ->
	#cfg_shop_item{
		id            = 104,
		goodsid       = 10001,
		number        = 1,
		frequency     = 1,
		currency_type = 5,
		price         = 1000
	};
get(105) ->
	#cfg_shop_item{
		id            = 105,
		goodsid       = 10001,
		number        = 50,
		frequency     = 2,
		currency_type = 5,
		price         = 1000
	};
get(106) ->
	#cfg_shop_item{
		id            = 106,
		goodsid       = 10001,
		number        = 1,
		frequency     = 4,
		currency_type = 5,
		price         = 1000
	};
get(107) ->
	#cfg_shop_item{
		id            = 107,
		goodsid       = 10001,
		number        = 1,
		frequency     = 3,
		currency_type = 5,
		price         = 1000
	};
get(108) ->
	#cfg_shop_item{
		id            = 108,
		goodsid       = 10001,
		number        = 1,
		frequency     = 1,
		currency_type = 5,
		price         = 1000
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_shop_wish_item:get(~p) not_match", [A]),
 not_match.

length() ->
 8.

id_list() ->
 [101, 102, 103, 104, 105, 106, 107, 108].

all() ->[data_shop_wish_item:get(ID) || ID<-id_list()].
