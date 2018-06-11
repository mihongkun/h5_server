-module(nh_market).

-include("pt_market.hrl").
-include("log.hrl").
-include("market.hrl").
-behavior(b_nh_market).

-compile(export_all).


on_get_shop(Shop_id) ->
	Sid = get(sid),
	mod_market:send_client_shop(Sid,Shop_id).

on_refresh_market(Shop_id) ->
	Sid = get(sid),
	mod_market:refresh_market(Sid,Shop_id).

on_buy_market_props(Shop_id, Shop_index) ->
	Sid = get(sid),
	mod_market:buy_market_props(Sid,Shop_id,Shop_index).
