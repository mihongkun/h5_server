%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_market

-module(b_nh_market).


%% on_get_shop(Shop_id) ->
-callback on_get_shop(Shop_id :: integer()) -> term().

%% on_refresh_market(Shop_id) ->
-callback on_refresh_market(Shop_id :: integer()) -> term().

%% on_buy_market_props(Shop_id, Shop_index) ->
-callback on_buy_market_props(Shop_id :: integer(), Shop_index :: integer()) -> term().
