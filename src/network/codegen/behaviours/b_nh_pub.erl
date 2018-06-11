%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_pub

-module(b_nh_pub).


%% on_pub() ->
-callback on_pub() -> term().

%% on_pub_start(Id, Heros) ->
-callback on_pub_start(Id :: integer(), Heros :: list(integer())) -> term().

%% on_pub_cancel(Id) ->
-callback on_pub_cancel(Id :: integer()) -> term().

%% on_pub_use(Type) ->
-callback on_pub_use(Type :: integer()) -> term().

%% on_pub_refresh() ->
-callback on_pub_refresh() -> term().

%% on_acc(Id) ->
-callback on_acc(Id :: integer()) -> term().

%% on_pub_done(Id) ->
-callback on_pub_done(Id :: integer()) -> term().

%% on_pub_lock(Id, Type) ->
-callback on_pub_lock(Id :: integer(), Type :: integer()) -> term().
