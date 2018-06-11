-module(nh_battle).

-include("battle.hrl").
-compile(export_all).

on_start_battle(Type, Id) ->
	Sid = get(sid),
	{_Result,BRP} = battle_test:start(),
	pt_battle:send(Sid,BRP).
