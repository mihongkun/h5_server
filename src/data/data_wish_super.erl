%% this file is auto maked!
-module(data_wish_super).
-include("data_wish_super.hrl").
-compile(export_all).

%% X-许愿池相关表格\高级许愿池奖励表.xlsx

get(1) ->
	#cfg_wish_super{
		lattice     = 1,
		type        =  0,
		item_order1 =  0,
		min1        =  0,
		max1        =  0,
		frequency1  =  0,
		item_order2 =  0,
		min2        =  0,
		max2        =  0,
		frequency2  =  0,
		item_order3 =  0,
		min3        =  0,
		max3        =  0,
		frequency3  =  0,
		weight      =  0
	};
get(2) ->
	#cfg_wish_super{
		lattice     = 2,
		type        =  0,
		item_order1 =  0,
		min1        =  0,
		max1        =  0,
		frequency1  =  0,
		item_order2 =  0,
		min2        =  0,
		max2        =  0,
		frequency2  =  0,
		item_order3 =  0,
		min3        =  0,
		max3        =  0,
		frequency3  =  0,
		weight      =  0
	};
get(3) ->
	#cfg_wish_super{
		lattice     = 3,
		type        =  0,
		item_order1 =  0,
		min1        =  0,
		max1        =  0,
		frequency1  =  0,
		item_order2 =  0,
		min2        =  0,
		max2        =  0,
		frequency2  =  0,
		item_order3 =  0,
		min3        =  0,
		max3        =  0,
		frequency3  =  0,
		weight      =  0
	};
get(4) ->
	#cfg_wish_super{
		lattice     = 4,
		type        =  0,
		item_order1 =  0,
		min1        =  0,
		max1        =  0,
		frequency1  =  0,
		item_order2 =  0,
		min2        =  0,
		max2        =  0,
		frequency2  =  0,
		item_order3 =  0,
		min3        =  0,
		max3        =  0,
		frequency3  =  0,
		weight      =  0
	};
get(5) ->
	#cfg_wish_super{
		lattice     = 5,
		type        =  0,
		item_order1 =  0,
		min1        =  0,
		max1        =  0,
		frequency1  =  0,
		item_order2 =  0,
		min2        =  0,
		max2        =  0,
		frequency2  =  0,
		item_order3 =  0,
		min3        =  0,
		max3        =  0,
		frequency3  =  0,
		weight      =  0
	};
get(6) ->
	#cfg_wish_super{
		lattice     = 6,
		type        =  0,
		item_order1 =  0,
		min1        =  0,
		max1        =  0,
		frequency1  =  0,
		item_order2 =  0,
		min2        =  0,
		max2        =  0,
		frequency2  =  0,
		item_order3 =  0,
		min3        =  0,
		max3        =  0,
		frequency3  =  0,
		weight      =  0
	};
get(7) ->
	#cfg_wish_super{
		lattice     = 7,
		type        =  0,
		item_order1 =  0,
		min1        =  0,
		max1        =  0,
		frequency1  =  0,
		item_order2 =  0,
		min2        =  0,
		max2        =  0,
		frequency2  =  0,
		item_order3 =  0,
		min3        =  0,
		max3        =  0,
		frequency3  =  0,
		weight      =  0
	};
get(8) ->
	#cfg_wish_super{
		lattice     = 8,
		type        =  0,
		item_order1 =  0,
		min1        =  0,
		max1        =  0,
		frequency1  =  0,
		item_order2 =  0,
		min2        =  0,
		max2        =  0,
		frequency2  =  0,
		item_order3 =  0,
		min3        =  0,
		max3        =  0,
		frequency3  =  0,
		weight      =  0
	};
get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_wish_super:get(~p) not_match", [A]),
 not_match.

length() ->
 8.

id_list() ->
 [1, 2, 3, 4, 5, 6, 7, 8].

all() ->[data_wish_super:get(ID) || ID<-id_list()].
