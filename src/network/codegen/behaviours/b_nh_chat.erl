%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_chat

-module(b_nh_chat).


%% on_chat(Chat_type, Msg, Share_type, Share_id) ->
-callback on_chat(Chat_type :: integer(), Msg :: list(), Share_type :: integer(), Share_id :: integer()) -> term().

%% on_friend_chat(Friend_sid, Msg, Share_type, Share_id) ->
-callback on_friend_chat(Friend_sid :: integer(), Msg :: list(), Share_type :: integer(), Share_id :: integer()) -> term().
