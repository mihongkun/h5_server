%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_role

-module(b_nh_role).


%% on_call_role(Type, Use_diamond, Times) ->
-callback on_call_role(Type :: integer(), Use_diamond :: integer(), Times :: integer()) -> term().

%% on_upgrade_role(Uid) ->
-callback on_upgrade_role(Uid :: integer()) -> term().

%% on_put_equip(Type, Uid, Item_id) ->
-callback on_put_equip(Type :: integer(), Uid :: integer(), Item_id :: integer()) -> term().

%% on_up_quality(Uid) ->
-callback on_up_quality(Uid :: integer()) -> term().

%% on_up_star(Uid) ->
-callback on_up_star(Uid :: integer()) -> term().

%% on_buy_grid() ->
-callback on_buy_grid() -> term().
