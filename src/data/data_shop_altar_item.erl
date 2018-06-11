%% this file is auto maked!
-module(data_shop_altar_item).
-include("data_shop_item.hrl").
-compile(export_all).

%% S-商店相关表格\祭坛商店物品表.xlsx

get(1) ->
	#cfg_shop_item{
		id            = 1,
		goodsid       = 10001,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(2) ->
	#cfg_shop_item{
		id            = 2,
		goodsid       = 10002,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(3) ->
	#cfg_shop_item{
		id            = 3,
		goodsid       = 10003,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(4) ->
	#cfg_shop_item{
		id            = 4,
		goodsid       = 10004,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(5) ->
	#cfg_shop_item{
		id            = 5,
		goodsid       = 10005,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(6) ->
	#cfg_shop_item{
		id            = 6,
		goodsid       = 10006,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(7) ->
	#cfg_shop_item{
		id            = 7,
		goodsid       = 10007,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(8) ->
	#cfg_shop_item{
		id            = 8,
		goodsid       = 10008,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(9) ->
	#cfg_shop_item{
		id            = 9,
		goodsid       = 10009,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(10) ->
	#cfg_shop_item{
		id            = 10,
		goodsid       = 10010,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(11) ->
	#cfg_shop_item{
		id            = 11,
		goodsid       = 10011,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(12) ->
	#cfg_shop_item{
		id            = 12,
		goodsid       = 10012,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(13) ->
	#cfg_shop_item{
		id            = 13,
		goodsid       = 10013,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(14) ->
	#cfg_shop_item{
		id            = 14,
		goodsid       = 10014,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(15) ->
	#cfg_shop_item{
		id            = 15,
		goodsid       = 10015,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(16) ->
	#cfg_shop_item{
		id            = 16,
		goodsid       = 10016,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(17) ->
	#cfg_shop_item{
		id            = 17,
		goodsid       = 10017,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(18) ->
	#cfg_shop_item{
		id            = 18,
		goodsid       = 10018,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(19) ->
	#cfg_shop_item{
		id            = 19,
		goodsid       = 10019,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(20) ->
	#cfg_shop_item{
		id            = 20,
		goodsid       = 10020,
		number        = 50,
		frequency     = 1,
		currency_type = 4,
		price         = 5000
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_shop_altar_item:get(~p) not_match", [A]),
 not_match.

length() ->
 20.

id_list() ->
 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20].

all() ->[data_shop_altar_item:get(ID) || ID<-id_list()].
