%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_battle

-module(b_nh_battle).


%% on_start_battle(Type, Id) ->
-callback on_start_battle(Type :: integer(), Id :: integer()) -> term().

%% on_battle_report(Battle_id) ->
-callback on_battle_report(Battle_id :: integer()) -> term().

%% on_get_team_info(Type) ->
-callback on_get_team_info(Type :: integer()) -> term().

%% on_set_team(Type, Team) ->
-callback on_set_team(Type :: integer(), Team :: team_info) -> term().
