%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_vip

-module(b_nh_vip).


%% on_get_vip_base_info() ->
-callback on_get_vip_base_info() -> term().

%% on_buy_vip_gift(Vip_level) ->
-callback on_buy_vip_gift(Vip_level :: integer()) -> term().

%% on_get_first_recharge_info() ->
-callback on_get_first_recharge_info() -> term().

%% on_get_first_recharge_award() ->
-callback on_get_first_recharge_award() -> term().
