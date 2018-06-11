%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc b_nh_login

-module(b_nh_login).


%% on_login(Account, Server, Timestamp, Key, ConnectCount, Suid, PlatformID, Idfamac, PlatformInfo) ->
-callback on_login(Account :: list(), Server :: integer(), Timestamp :: integer(), Key :: list(), ConnectCount :: integer(), Suid :: list(), PlatformID :: integer(), Idfamac :: list(), PlatformInfo :: list()) -> term().

%% on_enter_game(Os, Osver, Device, DeviceType, Resolution, Service, Network, Phoneid, Bind, Battle_type, Dun_id, Ext_dun_id) ->
-callback on_enter_game(Os :: list(), Osver :: list(), Device :: list(), DeviceType :: list(), Resolution :: list(), Service :: list(), Network :: list(), Phoneid :: list(), Bind :: integer(), Battle_type :: integer(), Dun_id :: integer(), Ext_dun_id :: integer()) -> term().

%% on_create_player(Name, Sex, Pic, InvideCode, Os, Osver, Device, DeviceType, Resolution, Service, Network, Phoneid) ->
-callback on_create_player(Name :: list(), Sex :: integer(), Pic :: integer(), InvideCode :: list(), Os :: list(), Osver :: list(), Device :: list(), DeviceType :: list(), Resolution :: list(), Service :: list(), Network :: list(), Phoneid :: list()) -> term().

%% on_change_name(Name) ->
-callback on_change_name(Name :: list()) -> term().

%% on_change_intro(Intro) ->
-callback on_change_intro(Intro :: list()) -> term().

%% on_ping(Time) ->
-callback on_ping(Time :: integer()) -> term().

%% on_get_assign_player_info(Sid) ->
-callback on_get_assign_player_info(Sid :: integer()) -> term().

%% on_req_heart_beat() ->
-callback on_req_heart_beat() -> term().
