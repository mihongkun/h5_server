-module(nh_role).

-include("pt_role.hrl").
-include("log.hrl").
-include("role.hrl").
-behavior(b_nh_role).

-compile(export_all).


on_call_role(Type, UseDiamon,Times) ->
	Sid = get(sid),
	mod_role_call:call_role(Sid,Type,UseDiamon,Times).

on_upgrade_role(Uid) ->
	Sid = get(sid),
	mod_role:upgrade_role(Sid,Uid).

on_put_equip(Type, Uid, Item_id) ->
	Sid = get(sid),
	mod_role:put_equip(Sid,Type, Uid, Item_id).

on_up_quality(Uid) ->
	Sid = get(sid),
	mod_role:up_quality(Sid,Uid).

on_up_star(Uid) ->
	Sid = get(sid),
	mod_role:up_star(Sid,Uid).

on_buy_grid() ->
	Sid = get(sid),
	mod_role:buy_grid(Sid).
