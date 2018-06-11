%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_item

-module(b_nh_item).


%% on_sell_item(Cfg_id, Num) ->
-callback on_sell_item(Cfg_id :: integer(), Num :: integer()) -> term().

%% on_compose_equipment(Cfg_id, Compose_times) ->
-callback on_compose_equipment(Cfg_id :: integer(), Compose_times :: integer()) -> term().

%% on_chip_compose(Cfg_id, Compose_times) ->
-callback on_chip_compose(Cfg_id :: integer(), Compose_times :: integer()) -> term().
