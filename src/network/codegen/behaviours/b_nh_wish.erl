%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_wish

-module(b_nh_wish).


%% on_wish(Type) ->
-callback on_wish(Type :: integer()) -> term().

%% on_pay(Type, Num) ->
-callback on_pay(Type :: integer(), Num :: integer()) -> term().

%% on_logs(Type) ->
-callback on_logs(Type :: integer()) -> term().

%% on_guest(Type, Num) ->
-callback on_guest(Type :: integer(), Num :: integer()) -> term().

%% on_refresh_wish(Type) ->
-callback on_refresh_wish(Type :: integer()) -> term().
