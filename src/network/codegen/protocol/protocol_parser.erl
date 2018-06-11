%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocol_parser

-module(protocol_parser).

-include("nw.hrl").
-include("proto.hrl").

-compile(export_all).

decode_on_start_battle(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Id, _D2} = nw_util:read_uint(D1, 32),
    {Type,Id}.

decode_on_battle_report(D0) ->
    {Battle_id, _D1} = nw_util:read_uint(D0, 32),
    {Battle_id}.

decode_on_get_team_info(D0) ->
    {Type, _D1} = nw_util:read_uint(D0, 8),
    {Type}.

decode_on_set_team(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Team, _D2} = protocol_parser:decode_ps_team_info(D1),
    {Type,Team}.

decode_on_chat(D0) ->
    {Chat_type, D1} = nw_util:read_int(D0, 8),
    {Msg, D2} = nw_util:read_string(D1),
    {Share_type, D3} = nw_util:read_int(D2, 8),
    {Share_id, _D4} = nw_util:read_uint(D3, 32),
    {Chat_type,Msg,Share_type,Share_id}.

decode_on_friend_chat(D0) ->
    {Friend_sid, D1} = nw_util:read_uint(D0, 32),
    {Msg, D2} = nw_util:read_string(D1),
    {Share_type, D3} = nw_util:read_int(D2, 8),
    {Share_id, _D4} = nw_util:read_uint(D3, 32),
    {Friend_sid,Msg,Share_type,Share_id}.

decode_on_sell_item(D0) ->
    {Cfg_id, D1} = nw_util:read_int(D0, 32),
    {Num, _D2} = nw_util:read_int(D1, 32),
    {Cfg_id,Num}.

decode_on_compose_equipment(D0) ->
    {Cfg_id, D1} = nw_util:read_int(D0, 16),
    {Compose_times, _D2} = nw_util:read_int(D1, 8),
    {Cfg_id,Compose_times}.

decode_on_chip_compose(D0) ->
    {Cfg_id, D1} = nw_util:read_int(D0, 16),
    {Compose_times, _D2} = nw_util:read_int(D1, 8),
    {Cfg_id,Compose_times}.

decode_on_login(D0) ->
    {Account, D1} = nw_util:read_string(D0),
    {Server, D2} = nw_util:read_uint(D1, 32),
    {Timestamp, D3} = nw_util:read_uint(D2, 32),
    {Key, D4} = nw_util:read_string(D3),
    {ConnectCount, D5} = nw_util:read_uint(D4, 8),
    {Suid, D6} = nw_util:read_string(D5),
    {PlatformID, D7} = nw_util:read_uint(D6, 32),
    {Idfamac, D8} = nw_util:read_string(D7),
    {PlatformInfo, _D9} = nw_util:read_string(D8),
    {Account,Server,Timestamp,Key,ConnectCount,Suid,PlatformID,Idfamac,PlatformInfo}.

decode_on_enter_game(D0) ->
    {Os, D1} = nw_util:read_string(D0),
    {Osver, D2} = nw_util:read_string(D1),
    {Device, D3} = nw_util:read_string(D2),
    {DeviceType, D4} = nw_util:read_string(D3),
    {Resolution, D5} = nw_util:read_string(D4),
    {Service, D6} = nw_util:read_string(D5),
    {Network, D7} = nw_util:read_string(D6),
    {Phoneid, D8} = nw_util:read_string(D7),
    {Bind, D9} = nw_util:read_int(D8, 8),
    {Battle_type, D10} = nw_util:read_int(D9, 8),
    {Dun_id, D11} = nw_util:read_int(D10, 32),
    {Ext_dun_id, _D12} = nw_util:read_int(D11, 32),
    {Os,Osver,Device,DeviceType,Resolution,Service,Network,Phoneid,Bind,Battle_type,Dun_id,Ext_dun_id}.

decode_on_create_player(D0) ->
    {Name, D1} = nw_util:read_string(D0),
    {Sex, D2} = nw_util:read_int(D1, 8),
    {Pic, D3} = nw_util:read_uint(D2, 16),
    {InvideCode, D4} = nw_util:read_string(D3),
    {Os, D5} = nw_util:read_string(D4),
    {Osver, D6} = nw_util:read_string(D5),
    {Device, D7} = nw_util:read_string(D6),
    {DeviceType, D8} = nw_util:read_string(D7),
    {Resolution, D9} = nw_util:read_string(D8),
    {Service, D10} = nw_util:read_string(D9),
    {Network, D11} = nw_util:read_string(D10),
    {Phoneid, _D12} = nw_util:read_string(D11),
    {Name,Sex,Pic,InvideCode,Os,Osver,Device,DeviceType,Resolution,Service,Network,Phoneid}.

decode_on_change_name(D0) ->
    {Name, _D1} = nw_util:read_string(D0),
    {Name}.

decode_on_change_intro(D0) ->
    {Intro, _D1} = nw_util:read_string(D0),
    {Intro}.

decode_on_ping(D0) ->
    {Time, _D1} = nw_util:read_uint(D0, 32),
    {Time}.

decode_on_get_assign_player_info(D0) ->
    {Sid, _D1} = nw_util:read_int(D0, 32),
    {Sid}.

decode_on_req_heart_beat(_D0) ->
    {}.

decode_on_get_shop(D0) ->
    {Shop_id, _D1} = nw_util:read_uint(D0, 8),
    {Shop_id}.

decode_on_refresh_market(D0) ->
    {Shop_id, _D1} = nw_util:read_uint(D0, 8),
    {Shop_id}.

decode_on_buy_market_props(D0) ->
    {Shop_id, D1} = nw_util:read_uint(D0, 8),
    {Shop_index, _D2} = nw_util:read_uint(D1, 8),
    {Shop_id,Shop_index}.

decode_on_pub(_D0) ->
    {}.

decode_on_pub_start(D0) ->
    {Id, D1} = nw_util:read_uint(D0, 16),
    {Heros, _D2} = nw_util:read_list(D1,nw_util,read_uint,[16]),
    {Id,Heros}.

decode_on_pub_cancel(D0) ->
    {Id, _D1} = nw_util:read_uint(D0, 16),
    {Id}.

decode_on_pub_use(D0) ->
    {Type, _D1} = nw_util:read_uint(D0, 8),
    {Type}.

decode_on_pub_refresh(_D0) ->
    {}.

decode_on_acc(D0) ->
    {Id, _D1} = nw_util:read_uint(D0, 16),
    {Id}.

decode_on_pub_done(D0) ->
    {Id, _D1} = nw_util:read_uint(D0, 16),
    {Id}.

decode_on_pub_lock(D0) ->
    {Id, D1} = nw_util:read_uint(D0, 16),
    {Type, _D2} = nw_util:read_uint(D1, 8),
    {Id,Type}.

decode_on_call_role(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Use_diamond, D2} = nw_util:read_uint(D1, 8),
    {Times, _D3} = nw_util:read_int(D2, 8),
    {Type,Use_diamond,Times}.

decode_on_upgrade_role(D0) ->
    {Uid, _D1} = nw_util:read_uint(D0, 32),
    {Uid}.

decode_on_put_equip(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Uid, D2} = nw_util:read_uint(D1, 32),
    {Item_id, _D3} = nw_util:read_uint(D2, 16),
    {Type,Uid,Item_id}.

decode_on_up_quality(D0) ->
    {Uid, _D1} = nw_util:read_int(D0, 32),
    {Uid}.

decode_on_up_star(D0) ->
    {Uid, _D1} = nw_util:read_int(D0, 32),
    {Uid}.

decode_on_buy_grid(_D0) ->
    {}.

decode_on_get_spotgold(_D0) ->
    {}.

decode_on_buy_spotgold(D0) ->
    {Type, _D1} = nw_util:read_uint(D0, 8),
    {Type}.

decode_on_get_vip_base_info(_D0) ->
    {}.

decode_on_buy_vip_gift(D0) ->
    {Vip_level, _D1} = nw_util:read_int(D0, 16),
    {Vip_level}.

decode_on_get_first_recharge_info(_D0) ->
    {}.

decode_on_get_first_recharge_award(_D0) ->
    {}.

decode_on_wish(D0) ->
    {Type, _D1} = nw_util:read_int(D0, 8),
    {Type}.

decode_on_pay(D0) ->
    {Type, D1} = nw_util:read_int(D0, 8),
    {Num, _D2} = nw_util:read_int(D1, 32),
    {Type,Num}.

decode_on_logs(D0) ->
    {Type, _D1} = nw_util:read_int(D0, 8),
    {Type}.

decode_on_guest(D0) ->
    {Type, D1} = nw_util:read_int(D0, 8),
    {Num, _D2} = nw_util:read_int(D1, 16),
    {Type,Num}.

decode_on_refresh_wish(D0) ->
    {Type, _D1} = nw_util:read_int(D0, 8),
    {Type}.



encode_send_battle_report(Battle_id, Scene_id, Sid, Name, Level, Pic, Tar_sid, Tar_name, Tar_level, Tar_pic, Entities, Rounds, Total_hurts, Rewards, Result) ->
    Battle_id_Bin = nw_util:write_uint(Battle_id, 32),
    Scene_id_Bin = nw_util:write_uint(Scene_id, 32),
    Sid_Bin = nw_util:write_uint(Sid, 32),
    Name_Bin = nw_util:write_string(Name),
    Level_Bin = nw_util:write_uint(Level, 16),
    Pic_Bin = nw_util:write_uint(Pic, 16),
    Tar_sid_Bin = nw_util:write_uint(Tar_sid, 32),
    Tar_name_Bin = nw_util:write_string(Tar_name),
    Tar_level_Bin = nw_util:write_uint(Tar_level, 16),
    Tar_pic_Bin = nw_util:write_uint(Tar_pic, 16),
    Entities_Bin = nw_util:write_list(Entities, protocol_parser, encode_ps_entity),
    Rounds_Bin = nw_util:write_list(Rounds, protocol_parser, encode_ps_battle_round),
    Total_hurts_Bin = nw_util:write_list(Total_hurts, protocol_parser, encode_ps_total_hurt),
    Rewards_Bin = nw_util:write_list(Rewards, protocol_parser, encode_ps_reward),
    Result_Bin = nw_util:write_uint(Result, 8),
    Bin = zlib:compress(<<Battle_id_Bin/binary,Scene_id_Bin/binary,Sid_Bin/binary,Name_Bin/binary,Level_Bin/binary,Pic_Bin/binary,Tar_sid_Bin/binary,Tar_name_Bin/binary,Tar_level_Bin/binary,Tar_pic_Bin/binary,Entities_Bin/binary,Rounds_Bin/binary,Total_hurts_Bin/binary,Rewards_Bin/binary,Result_Bin/binary>>),
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_BATTLE_REPORT:16, Bin/binary>>.

encode_send_team_info_back(Type, Team) ->
    Type_Bin = nw_util:write_uint(Type, 8),
    Team_Bin = protocol_parser:encode_ps_team_info(Team),
    Bin = <<Type_Bin/binary,Team_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_TEAM_INFO_BACK:16, Bin/binary>>.

encode_send_history_infos(World_chat_infos, Guild_chat_infos) ->
    World_chat_infos_Bin = nw_util:write_list(World_chat_infos, protocol_parser, encode_ps_chat_info),
    Guild_chat_infos_Bin = nw_util:write_list(Guild_chat_infos, protocol_parser, encode_ps_chat_info),
    Bin = zlib:compress(<<World_chat_infos_Bin/binary,Guild_chat_infos_Bin/binary>>),
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_HISTORY_INFOS:16, Bin/binary>>.

encode_send_chat_update(Type, Add_chat_info) ->
    Type_Bin = nw_util:write_uint(Type, 8),
    Add_chat_info_Bin = protocol_parser:encode_ps_chat_info(Add_chat_info),
    Bin = <<Type_Bin/binary,Add_chat_info_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_CHAT_UPDATE:16, Bin/binary>>.

encode_send_counter_infos(Counters) ->
    Counters_Bin = nw_util:write_list(Counters, protocol_parser, encode_ps_counter_info),
    Bin = <<Counters_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_COUNTER_INFOS:16, Bin/binary>>.

encode_send_counter_update(Type, Num) ->
    Type_Bin = nw_util:write_uint(Type, 8),
    Num_Bin = nw_util:write_uint(Num, 32),
    Bin = <<Type_Bin/binary,Num_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_COUNTER_UPDATE:16, Bin/binary>>.

encode_send_economy_info(Diamond, Gold, Soul, Water, Water_time, Stamen, Stamen_time, Narc, Narc_time) ->
    Diamond_Bin = nw_util:write_uint(Diamond, 32),
    Gold_Bin = nw_util:write_uint(Gold, 64),
    Soul_Bin = nw_util:write_uint(Soul, 64),
    Water_Bin = nw_util:write_uint(Water, 32),
    Water_time_Bin = nw_util:write_uint(Water_time, 32),
    Stamen_Bin = nw_util:write_uint(Stamen, 32),
    Stamen_time_Bin = nw_util:write_uint(Stamen_time, 32),
    Narc_Bin = nw_util:write_uint(Narc, 32),
    Narc_time_Bin = nw_util:write_uint(Narc_time, 32),
    Bin = <<Diamond_Bin/binary,Gold_Bin/binary,Soul_Bin/binary,Water_Bin/binary,Water_time_Bin/binary,Stamen_Bin/binary,Stamen_time_Bin/binary,Narc_Bin/binary,Narc_time_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_ECONOMY_INFO:16, Bin/binary>>.

encode_send_diamond_update(Diamond) ->
    Diamond_Bin = nw_util:write_uint(Diamond, 32),
    Bin = <<Diamond_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_DIAMOND_UPDATE:16, Bin/binary>>.

encode_send_gold_update(Gold) ->
    Gold_Bin = nw_util:write_uint(Gold, 64),
    Bin = <<Gold_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_GOLD_UPDATE:16, Bin/binary>>.

encode_send_soul_update(Soul) ->
    Soul_Bin = nw_util:write_uint(Soul, 64),
    Bin = <<Soul_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_SOUL_UPDATE:16, Bin/binary>>.

encode_send_water_update(Water, Water_time) ->
    Water_Bin = nw_util:write_uint(Water, 32),
    Water_time_Bin = nw_util:write_uint(Water_time, 32),
    Bin = <<Water_Bin/binary,Water_time_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_WATER_UPDATE:16, Bin/binary>>.

encode_send_stamen_update(Stamen, Stamen_time) ->
    Stamen_Bin = nw_util:write_uint(Stamen, 32),
    Stamen_time_Bin = nw_util:write_uint(Stamen_time, 32),
    Bin = <<Stamen_Bin/binary,Stamen_time_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_STAMEN_UPDATE:16, Bin/binary>>.

encode_send_narc_update(Narc, Narc_time) ->
    Narc_Bin = nw_util:write_uint(Narc, 32),
    Narc_time_Bin = nw_util:write_uint(Narc_time, 32),
    Bin = <<Narc_Bin/binary,Narc_time_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_NARC_UPDATE:16, Bin/binary>>.

encode_send_error(Proto, Code, Parms) ->
    Proto_Bin = nw_util:write_int(Proto, 32),
    Code_Bin = nw_util:write_int(Code, 32),
    Parms_Bin = nw_util:write_list(Parms, nw_util, write_string),
    Bin = <<Proto_Bin/binary,Code_Bin/binary,Parms_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_ERROR:16, Bin/binary>>.

encode_send_get_items(Items) ->
    Items_Bin = nw_util:write_list(Items, protocol_parser, encode_ps_item),
    Bin = <<Items_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_GET_ITEMS:16, Bin/binary>>.

encode_send_update_items(Items) ->
    Items_Bin = nw_util:write_list(Items, protocol_parser, encode_ps_item),
    Bin = <<Items_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_UPDATE_ITEMS:16, Bin/binary>>.

encode_send_sell_item(Gold) ->
    Gold_Bin = nw_util:write_int(Gold, 32),
    Bin = <<Gold_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_SELL_ITEM:16, Bin/binary>>.

encode_send_compose_equipment(Items) ->
    Items_Bin = nw_util:write_list(Items, protocol_parser, encode_ps_reward_items),
    Bin = <<Items_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_COMPOSE_EQUIPMENT:16, Bin/binary>>.

encode_send_chip_compose(Items) ->
    Items_Bin = nw_util:write_list(Items, protocol_parser, encode_ps_reward_items),
    Bin = <<Items_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_CHIP_COMPOSE:16, Bin/binary>>.

encode_send_login_result(ErrorCode, Sid, Suid) ->
    ErrorCode_Bin = nw_util:write_int(ErrorCode, 8),
    Sid_Bin = nw_util:write_uint(Sid, 32),
    Suid_Bin = nw_util:write_string(Suid),
    Bin = <<ErrorCode_Bin/binary,Sid_Bin/binary,Suid_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_LOGIN_RESULT:16, Bin/binary>>.

encode_send_player_info(Name, Sex, Level, Exp, Pic, Intro, Open_infos, Battle_power) ->
    Name_Bin = nw_util:write_string(Name),
    Sex_Bin = nw_util:write_int(Sex, 8),
    Level_Bin = nw_util:write_int(Level, 16),
    Exp_Bin = nw_util:write_int(Exp, 32),
    Pic_Bin = nw_util:write_int(Pic, 16),
    Intro_Bin = nw_util:write_string(Intro),
    Open_infos_Bin = nw_util:write_list(Open_infos, protocol_parser, encode_ps_open_info),
    Battle_power_Bin = nw_util:write_int(Battle_power, 32),
    Bin = <<Name_Bin/binary,Sex_Bin/binary,Level_Bin/binary,Exp_Bin/binary,Pic_Bin/binary,Intro_Bin/binary,Open_infos_Bin/binary,Battle_power_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PLAYER_INFO:16, Bin/binary>>.

encode_send_create_player_result(Error, Sid) ->
    Error_Bin = nw_util:write_int(Error, 8),
    Sid_Bin = nw_util:write_uint(Sid, 32),
    Bin = <<Error_Bin/binary,Sid_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_CREATE_PLAYER_RESULT:16, Bin/binary>>.

encode_send_new_battle_power(Battle_power) ->
    Battle_power_Bin = nw_util:write_uint(Battle_power, 32),
    Bin = <<Battle_power_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_NEW_BATTLE_POWER:16, Bin/binary>>.

encode_send_new_name(Name) ->
    Name_Bin = nw_util:write_string(Name),
    Bin = <<Name_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_NEW_NAME:16, Bin/binary>>.

encode_send_new_intro(Intro) ->
    Intro_Bin = nw_util:write_string(Intro),
    Bin = <<Intro_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_NEW_INTRO:16, Bin/binary>>.

encode_send_pong(Client_time, Time) ->
    Client_time_Bin = nw_util:write_uint(Client_time, 32),
    Time_Bin = nw_util:write_uint(Time, 32),
    Bin = <<Client_time_Bin/binary,Time_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PONG:16, Bin/binary>>.

encode_send_resp_get_assign_player_info(Sid, Nick_name, Level, Pic, Guild_name) ->
    Sid_Bin = nw_util:write_int(Sid, 32),
    Nick_name_Bin = nw_util:write_string(Nick_name),
    Level_Bin = nw_util:write_int(Level, 16),
    Pic_Bin = nw_util:write_uint(Pic, 16),
    Guild_name_Bin = nw_util:write_string(Guild_name),
    Bin = <<Sid_Bin/binary,Nick_name_Bin/binary,Level_Bin/binary,Pic_Bin/binary,Guild_name_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_RESP_GET_ASSIGN_PLAYER_INFO:16, Bin/binary>>.

encode_send_player_level_change(Level, Exp) ->
    Level_Bin = nw_util:write_int(Level, 16),
    Exp_Bin = nw_util:write_int(Exp, 32),
    Bin = <<Level_Bin/binary,Exp_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PLAYER_LEVEL_CHANGE:16, Bin/binary>>.

encode_send_rep_heart_beat(State) ->
    State_Bin = nw_util:write_int(State, 8),
    Bin = <<State_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_REP_HEART_BEAT:16, Bin/binary>>.

encode_send_resp_notify_td_diamond_change(Type, Type_desc, Daimond) ->
    Type_Bin = nw_util:write_int(Type, 8),
    Type_desc_Bin = nw_util:write_string(Type_desc),
    Daimond_Bin = nw_util:write_int(Daimond, 32),
    Bin = <<Type_Bin/binary,Type_desc_Bin/binary,Daimond_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_RESP_NOTIFY_TD_DIAMOND_CHANGE:16, Bin/binary>>.

encode_send_notify_cross_day() ->
    Bin = <<>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_NOTIFY_CROSS_DAY:16, Bin/binary>>.

encode_send_get_shop(Items) ->
    Items_Bin = nw_util:write_list(Items, protocol_parser, encode_ps_shop_item),
    Bin = <<Items_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_GET_SHOP:16, Bin/binary>>.

encode_send_buy_market_props(Item_id, Num) ->
    Item_id_Bin = nw_util:write_uint(Item_id, 16),
    Num_Bin = nw_util:write_uint(Num, 32),
    Bin = <<Item_id_Bin/binary,Num_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_BUY_MARKET_PROPS:16, Bin/binary>>.

encode_send_pub(Tasks) ->
    Tasks_Bin = nw_util:write_list(Tasks, protocol_parser, encode_ps_record),
    Bin = <<Tasks_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PUB:16, Bin/binary>>.

encode_send_pub_start(Id) ->
    Id_Bin = nw_util:write_uint(Id, 16),
    Bin = <<Id_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PUB_START:16, Bin/binary>>.

encode_send_pub_cancel(Id) ->
    Id_Bin = nw_util:write_uint(Id, 16),
    Bin = <<Id_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PUB_CANCEL:16, Bin/binary>>.

encode_send_pub_use(Id, Name, Starid, Time, Item, Num, Lock, Start, Cons) ->
    Id_Bin = nw_util:write_uint(Id, 16),
    Name_Bin = nw_util:write_uint(Name, 16),
    Starid_Bin = nw_util:write_uint(Starid, 8),
    Time_Bin = nw_util:write_int(Time, 32),
    Item_Bin = nw_util:write_uint(Item, 32),
    Num_Bin = nw_util:write_uint(Num, 32),
    Lock_Bin = nw_util:write_uint(Lock, 8),
    Start_Bin = nw_util:write_uint(Start, 8),
    Cons_Bin = nw_util:write_list(Cons, nw_util, write_uint, [16]),
    Bin = <<Id_Bin/binary,Name_Bin/binary,Starid_Bin/binary,Time_Bin/binary,Item_Bin/binary,Num_Bin/binary,Lock_Bin/binary,Start_Bin/binary,Cons_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PUB_USE:16, Bin/binary>>.

encode_send_pub_refresh(Tasks) ->
    Tasks_Bin = nw_util:write_list(Tasks, protocol_parser, encode_ps_record),
    Bin = <<Tasks_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PUB_REFRESH:16, Bin/binary>>.

encode_send_pub_acc(Id, Num) ->
    Id_Bin = nw_util:write_uint(Id, 32),
    Num_Bin = nw_util:write_uint(Num, 32),
    Bin = <<Id_Bin/binary,Num_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PUB_ACC:16, Bin/binary>>.

encode_send_pub_done(Id, Num) ->
    Id_Bin = nw_util:write_uint(Id, 32),
    Num_Bin = nw_util:write_uint(Num, 32),
    Bin = <<Id_Bin/binary,Num_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PUB_DONE:16, Bin/binary>>.

encode_send_pub_lock(Id, Type) ->
    Id_Bin = nw_util:write_uint(Id, 16),
    Type_Bin = nw_util:write_uint(Type, 8),
    Bin = <<Id_Bin/binary,Type_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PUB_LOCK:16, Bin/binary>>.

encode_send_roles(Roles) ->
    Roles_Bin = nw_util:write_list(Roles, protocol_parser, encode_ps_role),
    Bin = <<Roles_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_ROLES:16, Bin/binary>>.

encode_send_roles_update(Roles) ->
    Roles_Bin = nw_util:write_list(Roles, protocol_parser, encode_ps_role),
    Bin = <<Roles_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_ROLES_UPDATE:16, Bin/binary>>.

encode_send_roles_delete(Roles) ->
    Roles_Bin = nw_util:write_list(Roles, nw_util, write_uint, [32]),
    Bin = <<Roles_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_ROLES_DELETE:16, Bin/binary>>.

encode_send_role_grid_info(Grid, Buy_cost, Buy_add) ->
    Grid_Bin = nw_util:write_uint(Grid, 16),
    Buy_cost_Bin = nw_util:write_uint(Buy_cost, 16),
    Buy_add_Bin = nw_util:write_uint(Buy_add, 8),
    Bin = <<Grid_Bin/binary,Buy_cost_Bin/binary,Buy_add_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_ROLE_GRID_INFO:16, Bin/binary>>.

encode_send_role_call_info(Free_ts1, Free_ts2, Free_ts3) ->
    Free_ts1_Bin = nw_util:write_int(Free_ts1, 32),
    Free_ts2_Bin = nw_util:write_int(Free_ts2, 32),
    Free_ts3_Bin = nw_util:write_int(Free_ts3, 32),
    Bin = <<Free_ts1_Bin/binary,Free_ts2_Bin/binary,Free_ts3_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_ROLE_CALL_INFO:16, Bin/binary>>.

encode_send_call_result(Roles) ->
    Roles_Bin = nw_util:write_list(Roles, nw_util, write_uint, [16]),
    Bin = <<Roles_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_CALL_RESULT:16, Bin/binary>>.

encode_send_get_spotgold(Refresh_time, Ordinary, Intermediate, Senior) ->
    Refresh_time_Bin = nw_util:write_list(Refresh_time, nw_util, write_uint, [32]),
    Ordinary_Bin = nw_util:write_list(Ordinary, nw_util, write_uint, [8]),
    Intermediate_Bin = nw_util:write_list(Intermediate, nw_util, write_uint, [8]),
    Senior_Bin = nw_util:write_list(Senior, nw_util, write_uint, [8]),
    Bin = <<Refresh_time_Bin/binary,Ordinary_Bin/binary,Intermediate_Bin/binary,Senior_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_GET_SPOTGOLD:16, Bin/binary>>.

encode_send_resp_get_vip_base_info(Vip_base_info) ->
    Vip_base_info_Bin = protocol_parser:encode_ps_vip_base_info(Vip_base_info),
    Bin = <<Vip_base_info_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_RESP_GET_VIP_BASE_INFO:16, Bin/binary>>.

encode_send_resp_notify_vip_gift_change(Vip_gift_info) ->
    Vip_gift_info_Bin = protocol_parser:encode_ps_vip_gift_info(Vip_gift_info),
    Bin = <<Vip_gift_info_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_RESP_NOTIFY_VIP_GIFT_CHANGE:16, Bin/binary>>.

encode_send_resp_get_first_recharge_info(First_recharge_award_state, First_recharge_item_list) ->
    First_recharge_award_state_Bin = nw_util:write_int(First_recharge_award_state, 8),
    First_recharge_item_list_Bin = nw_util:write_list(First_recharge_item_list, protocol_parser, encode_ps_first_recharge_item_info),
    Bin = <<First_recharge_award_state_Bin/binary,First_recharge_item_list_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_RESP_GET_FIRST_RECHARGE_INFO:16, Bin/binary>>.

encode_send_wish(Type, Wish) ->
    Type_Bin = nw_util:write_int(Type, 8),
    Wish_Bin = protocol_parser:encode_ps_wish(Wish),
    Bin = <<Type_Bin/binary,Wish_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_WISH:16, Bin/binary>>.

encode_send_pay(Type, Luck_num) ->
    Type_Bin = nw_util:write_int(Type, 8),
    Luck_num_Bin = nw_util:write_int(Luck_num, 32),
    Bin = <<Type_Bin/binary,Luck_num_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_PAY:16, Bin/binary>>.

encode_send_logs(Type, Logs) ->
    Type_Bin = nw_util:write_int(Type, 8),
    Logs_Bin = protocol_parser:encode_ps_logs(Logs),
    Bin = <<Type_Bin/binary,Logs_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_LOGS:16, Bin/binary>>.

encode_send_guest(Type, Awards) ->
    Type_Bin = nw_util:write_int(Type, 8),
    Awards_Bin = protocol_parser:encode_ps_awards(Awards),
    Bin = <<Type_Bin/binary,Awards_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_GUEST:16, Bin/binary>>.

encode_send_refresh_wish(Type, Grids) ->
    Type_Bin = nw_util:write_int(Type, 8),
    Grids_Bin = protocol_parser:encode_ps_grids(Grids),
    Bin = <<Type_Bin/binary,Grids_Bin/binary>>,
    Len = byte_size(Bin) + ?PACK_HEADER_SIZE,
    <<Len:32,?SC_REFRESH_WISH:16, Bin/binary>>.



decode_ps_entity(D0) ->
    {Pos, D1} = nw_util:read_uint(D0, 8),
    {Type, D2} = nw_util:read_uint(D1, 8),
    {Cfg_id, D3} = nw_util:read_uint(D2, 16),
    {Level, D4} = nw_util:read_uint(D3, 16),
    {Star, D5} = nw_util:read_uint(D4, 8),
    {Hp, D6} = nw_util:read_uint(D5, 32),
    {Max_hp, D7} = nw_util:read_uint(D6, 32),
    {Angry, D8} = nw_util:read_uint(D7, 16),
    {Max_angry, D9} = nw_util:read_uint(D8, 16),
    {#ps_entity{
        pos = Pos,
        type = Type,
        cfg_id = Cfg_id,
        level = Level,
        star = Star,
        hp = Hp,
        max_hp = Max_hp,
        angry = Angry,
        max_angry = Max_angry
        }, D9}.

encode_ps_entity(Entity) when is_record(Entity, ps_entity) ->
    Pos_Bin = nw_util:write_uint(Entity#ps_entity.pos, 8),
    Type_Bin = nw_util:write_uint(Entity#ps_entity.type, 8),
    Cfg_id_Bin = nw_util:write_uint(Entity#ps_entity.cfg_id, 16),
    Level_Bin = nw_util:write_uint(Entity#ps_entity.level, 16),
    Star_Bin = nw_util:write_uint(Entity#ps_entity.star, 8),
    Hp_Bin = nw_util:write_uint(Entity#ps_entity.hp, 32),
    Max_hp_Bin = nw_util:write_uint(Entity#ps_entity.max_hp, 32),
    Angry_Bin = nw_util:write_uint(Entity#ps_entity.angry, 16),
    Max_angry_Bin = nw_util:write_uint(Entity#ps_entity.max_angry, 16),
    <<Pos_Bin/binary,Type_Bin/binary,Cfg_id_Bin/binary,Level_Bin/binary,Star_Bin/binary,Hp_Bin/binary,Max_hp_Bin/binary,Angry_Bin/binary,Max_angry_Bin/binary>>.

decode_ps_battle_round(D0) ->
    {Cur_round, D1} = nw_util:read_uint(D0, 8),
    {Steps, D2} = nw_util:read_list(D1,protocol_parser,decode_ps_step_event),
    {Buff_end, D3} = nw_util:read_list(D2,protocol_parser,decode_ps_buff_end_event),
    {Add_steps, D4} = nw_util:read_list(D3,protocol_parser,decode_ps_step_event),
    {#ps_battle_round{
        cur_round = Cur_round,
        steps = Steps,
        buff_end = Buff_end,
        add_steps = Add_steps
        }, D4}.

encode_ps_battle_round(Battle_round) when is_record(Battle_round, ps_battle_round) ->
    Cur_round_Bin = nw_util:write_uint(Battle_round#ps_battle_round.cur_round, 8),
    Steps_Bin = nw_util:write_list(Battle_round#ps_battle_round.steps, protocol_parser, encode_ps_step_event),
    Buff_end_Bin = nw_util:write_list(Battle_round#ps_battle_round.buff_end, protocol_parser, encode_ps_buff_end_event),
    Add_steps_Bin = nw_util:write_list(Battle_round#ps_battle_round.add_steps, protocol_parser, encode_ps_step_event),
    <<Cur_round_Bin/binary,Steps_Bin/binary,Buff_end_Bin/binary,Add_steps_Bin/binary>>.

decode_ps_step_event(D0) ->
    {Pos, D1} = nw_util:read_uint(D0, 8),
    {Skill_id, D2} = nw_util:read_uint(D1, 16),
    {Hurts, D3} = nw_util:read_list(D2,protocol_parser,decode_ps_hurt_event),
    {Buffs, D4} = nw_util:read_list(D3,protocol_parser,decode_ps_buff_event),
    {Rm_buffs, D5} = nw_util:read_list(D4,protocol_parser,decode_ps_rm_buff_event),
    {#ps_step_event{
        pos = Pos,
        skill_id = Skill_id,
        hurts = Hurts,
        buffs = Buffs,
        rm_buffs = Rm_buffs
        }, D5}.

encode_ps_step_event(Step_event) when is_record(Step_event, ps_step_event) ->
    Pos_Bin = nw_util:write_uint(Step_event#ps_step_event.pos, 8),
    Skill_id_Bin = nw_util:write_uint(Step_event#ps_step_event.skill_id, 16),
    Hurts_Bin = nw_util:write_list(Step_event#ps_step_event.hurts, protocol_parser, encode_ps_hurt_event),
    Buffs_Bin = nw_util:write_list(Step_event#ps_step_event.buffs, protocol_parser, encode_ps_buff_event),
    Rm_buffs_Bin = nw_util:write_list(Step_event#ps_step_event.rm_buffs, protocol_parser, encode_ps_rm_buff_event),
    <<Pos_Bin/binary,Skill_id_Bin/binary,Hurts_Bin/binary,Buffs_Bin/binary,Rm_buffs_Bin/binary>>.

decode_ps_hurt_event(D0) ->
    {Pos, D1} = nw_util:read_uint(D0, 8),
    {Hp, D2} = nw_util:read_uint(D1, 32),
    {Hp_shows, D3} = nw_util:read_list(D2,nw_util,read_int,[32]),
    {Angry, D4} = nw_util:read_uint(D3, 16),
    {Hurt_effect, D5} = nw_util:read_uint(D4, 8),
    {#ps_hurt_event{
        pos = Pos,
        hp = Hp,
        hp_shows = Hp_shows,
        angry = Angry,
        hurt_effect = Hurt_effect
        }, D5}.

encode_ps_hurt_event(Hurt_event) when is_record(Hurt_event, ps_hurt_event) ->
    Pos_Bin = nw_util:write_uint(Hurt_event#ps_hurt_event.pos, 8),
    Hp_Bin = nw_util:write_uint(Hurt_event#ps_hurt_event.hp, 32),
    Hp_shows_Bin = nw_util:write_list(Hurt_event#ps_hurt_event.hp_shows, nw_util, write_int, [32]),
    Angry_Bin = nw_util:write_uint(Hurt_event#ps_hurt_event.angry, 16),
    Hurt_effect_Bin = nw_util:write_uint(Hurt_event#ps_hurt_event.hurt_effect, 8),
    <<Pos_Bin/binary,Hp_Bin/binary,Hp_shows_Bin/binary,Angry_Bin/binary,Hurt_effect_Bin/binary>>.

decode_ps_buff_event(D0) ->
    {Pos, D1} = nw_util:read_uint(D0, 8),
    {Type, D2} = nw_util:read_uint(D1, 8),
    {Id, D3} = nw_util:read_uint(D2, 16),
    {Cfg_id, D4} = nw_util:read_uint(D3, 16),
    {Hp, D5} = nw_util:read_uint(D4, 32),
    {Hp_show, D6} = nw_util:read_int(D5, 32),
    {Last_round, D7} = nw_util:read_uint(D6, 8),
    {#ps_buff_event{
        pos = Pos,
        type = Type,
        id = Id,
        cfg_id = Cfg_id,
        hp = Hp,
        hp_show = Hp_show,
        last_round = Last_round
        }, D7}.

encode_ps_buff_event(Buff_event) when is_record(Buff_event, ps_buff_event) ->
    Pos_Bin = nw_util:write_uint(Buff_event#ps_buff_event.pos, 8),
    Type_Bin = nw_util:write_uint(Buff_event#ps_buff_event.type, 8),
    Id_Bin = nw_util:write_uint(Buff_event#ps_buff_event.id, 16),
    Cfg_id_Bin = nw_util:write_uint(Buff_event#ps_buff_event.cfg_id, 16),
    Hp_Bin = nw_util:write_uint(Buff_event#ps_buff_event.hp, 32),
    Hp_show_Bin = nw_util:write_int(Buff_event#ps_buff_event.hp_show, 32),
    Last_round_Bin = nw_util:write_uint(Buff_event#ps_buff_event.last_round, 8),
    <<Pos_Bin/binary,Type_Bin/binary,Id_Bin/binary,Cfg_id_Bin/binary,Hp_Bin/binary,Hp_show_Bin/binary,Last_round_Bin/binary>>.

decode_ps_rm_buff_event(D0) ->
    {Pos, D1} = nw_util:read_uint(D0, 8),
    {Type, D2} = nw_util:read_uint(D1, 8),
    {Id, D3} = nw_util:read_uint(D2, 16),
    {#ps_rm_buff_event{
        pos = Pos,
        type = Type,
        id = Id
        }, D3}.

encode_ps_rm_buff_event(Rm_buff_event) when is_record(Rm_buff_event, ps_rm_buff_event) ->
    Pos_Bin = nw_util:write_uint(Rm_buff_event#ps_rm_buff_event.pos, 8),
    Type_Bin = nw_util:write_uint(Rm_buff_event#ps_rm_buff_event.type, 8),
    Id_Bin = nw_util:write_uint(Rm_buff_event#ps_rm_buff_event.id, 16),
    <<Pos_Bin/binary,Type_Bin/binary,Id_Bin/binary>>.

decode_ps_buff_end_event(D0) ->
    {Pos, D1} = nw_util:read_uint(D0, 8),
    {Buff_hps, D2} = nw_util:read_list(D1,protocol_parser,decode_ps_buff_hp_event),
    {#ps_buff_end_event{
        pos = Pos,
        buff_hps = Buff_hps
        }, D2}.

encode_ps_buff_end_event(Buff_end_event) when is_record(Buff_end_event, ps_buff_end_event) ->
    Pos_Bin = nw_util:write_uint(Buff_end_event#ps_buff_end_event.pos, 8),
    Buff_hps_Bin = nw_util:write_list(Buff_end_event#ps_buff_end_event.buff_hps, protocol_parser, encode_ps_buff_hp_event),
    <<Pos_Bin/binary,Buff_hps_Bin/binary>>.

decode_ps_buff_hp_event(D0) ->
    {Hp, D1} = nw_util:read_uint(D0, 32),
    {Hp_show, D2} = nw_util:read_int(D1, 32),
    {#ps_buff_hp_event{
        hp = Hp,
        hp_show = Hp_show
        }, D2}.

encode_ps_buff_hp_event(Buff_hp_event) when is_record(Buff_hp_event, ps_buff_hp_event) ->
    Hp_Bin = nw_util:write_uint(Buff_hp_event#ps_buff_hp_event.hp, 32),
    Hp_show_Bin = nw_util:write_int(Buff_hp_event#ps_buff_hp_event.hp_show, 32),
    <<Hp_Bin/binary,Hp_show_Bin/binary>>.

decode_ps_total_hurt(D0) ->
    {Pos, D1} = nw_util:read_uint(D0, 8),
    {Hurt, D2} = nw_util:read_uint(D1, 32),
    {Heal, D3} = nw_util:read_uint(D2, 32),
    {Be_hurt, D4} = nw_util:read_uint(D3, 32),
    {Be_heal, D5} = nw_util:read_uint(D4, 32),
    {#ps_total_hurt{
        pos = Pos,
        hurt = Hurt,
        heal = Heal,
        be_hurt = Be_hurt,
        be_heal = Be_heal
        }, D5}.

encode_ps_total_hurt(Total_hurt) when is_record(Total_hurt, ps_total_hurt) ->
    Pos_Bin = nw_util:write_uint(Total_hurt#ps_total_hurt.pos, 8),
    Hurt_Bin = nw_util:write_uint(Total_hurt#ps_total_hurt.hurt, 32),
    Heal_Bin = nw_util:write_uint(Total_hurt#ps_total_hurt.heal, 32),
    Be_hurt_Bin = nw_util:write_uint(Total_hurt#ps_total_hurt.be_hurt, 32),
    Be_heal_Bin = nw_util:write_uint(Total_hurt#ps_total_hurt.be_heal, 32),
    <<Pos_Bin/binary,Hurt_Bin/binary,Heal_Bin/binary,Be_hurt_Bin/binary,Be_heal_Bin/binary>>.

decode_ps_reward(D0) ->
    {Item_id, D1} = nw_util:read_uint(D0, 32),
    {Num, D2} = nw_util:read_uint(D1, 32),
    {#ps_reward{
        item_id = Item_id,
        num = Num
        }, D2}.

encode_ps_reward(Reward) when is_record(Reward, ps_reward) ->
    Item_id_Bin = nw_util:write_uint(Reward#ps_reward.item_id, 32),
    Num_Bin = nw_util:write_uint(Reward#ps_reward.num, 32),
    <<Item_id_Bin/binary,Num_Bin/binary>>.

decode_ps_team_info(D0) ->
    {Pos, D1} = nw_util:read_uint(D0, 8),
    {Uid, D2} = nw_util:read_uint(D1, 32),
    {#ps_team_info{
        pos = Pos,
        uid = Uid
        }, D2}.

encode_ps_team_info(Team_info) when is_record(Team_info, ps_team_info) ->
    Pos_Bin = nw_util:write_uint(Team_info#ps_team_info.pos, 8),
    Uid_Bin = nw_util:write_uint(Team_info#ps_team_info.uid, 32),
    <<Pos_Bin/binary,Uid_Bin/binary>>.

decode_ps_team_infos(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Team, D2} = protocol_parser:decode_ps_team_info(D1),
    {#ps_team_infos{
        type = Type,
        team = Team
        }, D2}.

encode_ps_team_infos(Team_infos) when is_record(Team_infos, ps_team_infos) ->
    Type_Bin = nw_util:write_uint(Team_infos#ps_team_infos.type, 8),
    Team_Bin = protocol_parser:encode_ps_team_info(Team_infos#ps_team_infos.team),
    <<Type_Bin/binary,Team_Bin/binary>>.

decode_ps_chat_info(D0) ->
    {Sid, D1} = nw_util:read_uint(D0, 32),
    {Lv, D2} = nw_util:read_uint(D1, 32),
    {Vip, D3} = nw_util:read_uint(D2, 8),
    {Pic, D4} = nw_util:read_uint(D3, 16),
    {Frame, D5} = nw_util:read_uint(D4, 16),
    {Name, D6} = nw_util:read_string(D5),
    {Msg, D7} = nw_util:read_string(D6),
    {Time, D8} = nw_util:read_uint(D7, 32),
    {Share_type, D9} = nw_util:read_int(D8, 8),
    {Share_id, D10} = nw_util:read_uint(D9, 32),
    {#ps_chat_info{
        sid = Sid,
        lv = Lv,
        vip = Vip,
        pic = Pic,
        frame = Frame,
        name = Name,
        msg = Msg,
        time = Time,
        share_type = Share_type,
        share_id = Share_id
        }, D10}.

encode_ps_chat_info(Chat_info) when is_record(Chat_info, ps_chat_info) ->
    Sid_Bin = nw_util:write_uint(Chat_info#ps_chat_info.sid, 32),
    Lv_Bin = nw_util:write_uint(Chat_info#ps_chat_info.lv, 32),
    Vip_Bin = nw_util:write_uint(Chat_info#ps_chat_info.vip, 8),
    Pic_Bin = nw_util:write_uint(Chat_info#ps_chat_info.pic, 16),
    Frame_Bin = nw_util:write_uint(Chat_info#ps_chat_info.frame, 16),
    Name_Bin = nw_util:write_string(Chat_info#ps_chat_info.name),
    Msg_Bin = nw_util:write_string(Chat_info#ps_chat_info.msg),
    Time_Bin = nw_util:write_uint(Chat_info#ps_chat_info.time, 32),
    Share_type_Bin = nw_util:write_int(Chat_info#ps_chat_info.share_type, 8),
    Share_id_Bin = nw_util:write_uint(Chat_info#ps_chat_info.share_id, 32),
    <<Sid_Bin/binary,Lv_Bin/binary,Vip_Bin/binary,Pic_Bin/binary,Frame_Bin/binary,Name_Bin/binary,Msg_Bin/binary,Time_Bin/binary,Share_type_Bin/binary,Share_id_Bin/binary>>.

decode_ps_counter_info(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Num, D2} = nw_util:read_uint(D1, 32),
    {#ps_counter_info{
        type = Type,
        num = Num
        }, D2}.

encode_ps_counter_info(Counter_info) when is_record(Counter_info, ps_counter_info) ->
    Type_Bin = nw_util:write_uint(Counter_info#ps_counter_info.type, 8),
    Num_Bin = nw_util:write_uint(Counter_info#ps_counter_info.num, 32),
    <<Type_Bin/binary,Num_Bin/binary>>.

decode_ps_economy_long(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Value, D2} = nw_util:read_uint(D1, 64),
    {#ps_economy_long{
        type = Type,
        value = Value
        }, D2}.

encode_ps_economy_long(Economy_long) when is_record(Economy_long, ps_economy_long) ->
    Type_Bin = nw_util:write_uint(Economy_long#ps_economy_long.type, 8),
    Value_Bin = nw_util:write_uint(Economy_long#ps_economy_long.value, 64),
    <<Type_Bin/binary,Value_Bin/binary>>.

decode_ps_economy(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Value, D2} = nw_util:read_uint(D1, 32),
    {#ps_economy{
        type = Type,
        value = Value
        }, D2}.

encode_ps_economy(Economy) when is_record(Economy, ps_economy) ->
    Type_Bin = nw_util:write_uint(Economy#ps_economy.type, 8),
    Value_Bin = nw_util:write_uint(Economy#ps_economy.value, 32),
    <<Type_Bin/binary,Value_Bin/binary>>.

decode_ps_reward_items(D0) ->
    {Type, D1} = nw_util:read_int(D0, 8),
    {Cfg_id, D2} = nw_util:read_int(D1, 16),
    {Stack_num, D3} = nw_util:read_int(D2, 32),
    {#ps_reward_items{
        type = Type,
        cfg_id = Cfg_id,
        stack_num = Stack_num
        }, D3}.

encode_ps_reward_items(Reward_items) when is_record(Reward_items, ps_reward_items) ->
    Type_Bin = nw_util:write_int(Reward_items#ps_reward_items.type, 8),
    Cfg_id_Bin = nw_util:write_int(Reward_items#ps_reward_items.cfg_id, 16),
    Stack_num_Bin = nw_util:write_int(Reward_items#ps_reward_items.stack_num, 32),
    <<Type_Bin/binary,Cfg_id_Bin/binary,Stack_num_Bin/binary>>.

decode_ps_item(D0) ->
    {Cfg_id, D1} = nw_util:read_int(D0, 16),
    {Stack_num, D2} = nw_util:read_int(D1, 32),
    {#ps_item{
        cfg_id = Cfg_id,
        stack_num = Stack_num
        }, D2}.

encode_ps_item(Item) when is_record(Item, ps_item) ->
    Cfg_id_Bin = nw_util:write_int(Item#ps_item.cfg_id, 16),
    Stack_num_Bin = nw_util:write_int(Item#ps_item.stack_num, 32),
    <<Cfg_id_Bin/binary,Stack_num_Bin/binary>>.

decode_ps_open_info(D0) ->
    {Type, D1} = nw_util:read_int(D0, 16),
    {Value, D2} = nw_util:read_int(D1, 32),
    {#ps_open_info{
        type = Type,
        value = Value
        }, D2}.

encode_ps_open_info(Open_info) when is_record(Open_info, ps_open_info) ->
    Type_Bin = nw_util:write_int(Open_info#ps_open_info.type, 16),
    Value_Bin = nw_util:write_int(Open_info#ps_open_info.value, 32),
    <<Type_Bin/binary,Value_Bin/binary>>.

decode_ps_shop_item(D0) ->
    {Shop_item_id, D1} = nw_util:read_int(D0, 16),
    {Res_num, D2} = nw_util:read_int(D1, 32),
    {#ps_shop_item{
        shop_item_id = Shop_item_id,
        res_num = Res_num
        }, D2}.

encode_ps_shop_item(Shop_item) when is_record(Shop_item, ps_shop_item) ->
    Shop_item_id_Bin = nw_util:write_int(Shop_item#ps_shop_item.shop_item_id, 16),
    Res_num_Bin = nw_util:write_int(Shop_item#ps_shop_item.res_num, 32),
    <<Shop_item_id_Bin/binary,Res_num_Bin/binary>>.

decode_ps_pub_record(D0) ->
    {Id, D1} = nw_util:read_uint(D0, 16),
    {Name, D2} = nw_util:read_uint(D1, 16),
    {Starid, D3} = nw_util:read_uint(D2, 8),
    {Time, D4} = nw_util:read_uint(D3, 32),
    {Item, D5} = nw_util:read_uint(D4, 32),
    {Num, D6} = nw_util:read_uint(D5, 32),
    {Lock, D7} = nw_util:read_uint(D6, 8),
    {Start, D8} = nw_util:read_uint(D7, 8),
    {Cons, D9} = nw_util:read_list(D8,nw_util,read_uint,[32]),
    {#ps_pub_record{
        id = Id,
        name = Name,
        starid = Starid,
        time = Time,
        item = Item,
        num = Num,
        lock = Lock,
        start = Start,
        cons = Cons
        }, D9}.

encode_ps_pub_record(Pub_record) when is_record(Pub_record, ps_pub_record) ->
    Id_Bin = nw_util:write_uint(Pub_record#ps_pub_record.id, 16),
    Name_Bin = nw_util:write_uint(Pub_record#ps_pub_record.name, 16),
    Starid_Bin = nw_util:write_uint(Pub_record#ps_pub_record.starid, 8),
    Time_Bin = nw_util:write_uint(Pub_record#ps_pub_record.time, 32),
    Item_Bin = nw_util:write_uint(Pub_record#ps_pub_record.item, 32),
    Num_Bin = nw_util:write_uint(Pub_record#ps_pub_record.num, 32),
    Lock_Bin = nw_util:write_uint(Pub_record#ps_pub_record.lock, 8),
    Start_Bin = nw_util:write_uint(Pub_record#ps_pub_record.start, 8),
    Cons_Bin = nw_util:write_list(Pub_record#ps_pub_record.cons, nw_util, write_uint, [32]),
    <<Id_Bin/binary,Name_Bin/binary,Starid_Bin/binary,Time_Bin/binary,Item_Bin/binary,Num_Bin/binary,Lock_Bin/binary,Start_Bin/binary,Cons_Bin/binary>>.

decode_ps_equips(D0) ->
    {Equip_id, D1} = nw_util:read_uint(D0, 16),
    {#ps_equips{
        equip_id = Equip_id
        }, D1}.

encode_ps_equips(Equips) when is_record(Equips, ps_equips) ->
    Equip_id_Bin = nw_util:write_uint(Equips#ps_equips.equip_id, 16),
    <<Equip_id_Bin/binary>>.

decode_ps_attris(D0) ->
    {Type, D1} = nw_util:read_uint(D0, 8),
    {Value, D2} = nw_util:read_uint(D1, 32),
    {#ps_attris{
        type = Type,
        value = Value
        }, D2}.

encode_ps_attris(Attris) when is_record(Attris, ps_attris) ->
    Type_Bin = nw_util:write_uint(Attris#ps_attris.type, 8),
    Value_Bin = nw_util:write_uint(Attris#ps_attris.value, 32),
    <<Type_Bin/binary,Value_Bin/binary>>.

decode_ps_role(D0) ->
    {Uid, D1} = nw_util:read_uint(D0, 32),
    {Cfg_id, D2} = nw_util:read_uint(D1, 16),
    {Lv, D3} = nw_util:read_uint(D2, 16),
    {Star, D4} = nw_util:read_uint(D3, 8),
    {Quality, D5} = nw_util:read_uint(D4, 8),
    {Equips, D6} = nw_util:read_list(D5,protocol_parser,decode_ps_equips),
    {Attris, D7} = nw_util:read_list(D6,protocol_parser,decode_ps_attris),
    {Power, D8} = nw_util:read_uint(D7, 32),
    {Xtal_id, D9} = nw_util:read_uint(D8, 16),
    {Xtal_attris, D10} = nw_util:read_list(D9,protocol_parser,decode_ps_attris),
    {#ps_role{
        uid = Uid,
        cfg_id = Cfg_id,
        lv = Lv,
        star = Star,
        quality = Quality,
        equips = Equips,
        attris = Attris,
        power = Power,
        xtal_id = Xtal_id,
        xtal_attris = Xtal_attris
        }, D10}.

encode_ps_role(Role) when is_record(Role, ps_role) ->
    Uid_Bin = nw_util:write_uint(Role#ps_role.uid, 32),
    Cfg_id_Bin = nw_util:write_uint(Role#ps_role.cfg_id, 16),
    Lv_Bin = nw_util:write_uint(Role#ps_role.lv, 16),
    Star_Bin = nw_util:write_uint(Role#ps_role.star, 8),
    Quality_Bin = nw_util:write_uint(Role#ps_role.quality, 8),
    Equips_Bin = nw_util:write_list(Role#ps_role.equips, protocol_parser, encode_ps_equips),
    Attris_Bin = nw_util:write_list(Role#ps_role.attris, protocol_parser, encode_ps_attris),
    Power_Bin = nw_util:write_uint(Role#ps_role.power, 32),
    Xtal_id_Bin = nw_util:write_uint(Role#ps_role.xtal_id, 16),
    Xtal_attris_Bin = nw_util:write_list(Role#ps_role.xtal_attris, protocol_parser, encode_ps_attris),
    <<Uid_Bin/binary,Cfg_id_Bin/binary,Lv_Bin/binary,Star_Bin/binary,Quality_Bin/binary,Equips_Bin/binary,Attris_Bin/binary,Power_Bin/binary,Xtal_id_Bin/binary,Xtal_attris_Bin/binary>>.

decode_ps_vip_base_info(D0) ->
    {Vip_level, D1} = nw_util:read_int(D0, 8),
    {Charge_tot_diamond, D2} = nw_util:read_int(D1, 32),
    {Next_vip_tot_diamond, D3} = nw_util:read_int(D2, 32),
    {Is_can_buy_month_card, D4} = nw_util:read_int(D3, 8),
    {Vip_gift_list, D5} = nw_util:read_list(D4,protocol_parser,decode_ps_vip_gift_info),
    {Recharge_list, D6} = nw_util:read_list(D5,protocol_parser,decode_ps_recharge_info),
    {#ps_vip_base_info{
        vip_level = Vip_level,
        charge_tot_diamond = Charge_tot_diamond,
        next_vip_tot_diamond = Next_vip_tot_diamond,
        is_can_buy_month_card = Is_can_buy_month_card,
        vip_gift_list = Vip_gift_list,
        recharge_list = Recharge_list
        }, D6}.

encode_ps_vip_base_info(Vip_base_info) when is_record(Vip_base_info, ps_vip_base_info) ->
    Vip_level_Bin = nw_util:write_int(Vip_base_info#ps_vip_base_info.vip_level, 8),
    Charge_tot_diamond_Bin = nw_util:write_int(Vip_base_info#ps_vip_base_info.charge_tot_diamond, 32),
    Next_vip_tot_diamond_Bin = nw_util:write_int(Vip_base_info#ps_vip_base_info.next_vip_tot_diamond, 32),
    Is_can_buy_month_card_Bin = nw_util:write_int(Vip_base_info#ps_vip_base_info.is_can_buy_month_card, 8),
    Vip_gift_list_Bin = nw_util:write_list(Vip_base_info#ps_vip_base_info.vip_gift_list, protocol_parser, encode_ps_vip_gift_info),
    Recharge_list_Bin = nw_util:write_list(Vip_base_info#ps_vip_base_info.recharge_list, protocol_parser, encode_ps_recharge_info),
    <<Vip_level_Bin/binary,Charge_tot_diamond_Bin/binary,Next_vip_tot_diamond_Bin/binary,Is_can_buy_month_card_Bin/binary,Vip_gift_list_Bin/binary,Recharge_list_Bin/binary>>.

decode_ps_vip_gift_info(D0) ->
    {Vip_level, D1} = nw_util:read_int(D0, 8),
    {Item_id, D2} = nw_util:read_int(D1, 16),
    {Is_buy, D3} = nw_util:read_int(D2, 8),
    {#ps_vip_gift_info{
        vip_level = Vip_level,
        item_id = Item_id,
        is_buy = Is_buy
        }, D3}.

encode_ps_vip_gift_info(Vip_gift_info) when is_record(Vip_gift_info, ps_vip_gift_info) ->
    Vip_level_Bin = nw_util:write_int(Vip_gift_info#ps_vip_gift_info.vip_level, 8),
    Item_id_Bin = nw_util:write_int(Vip_gift_info#ps_vip_gift_info.item_id, 16),
    Is_buy_Bin = nw_util:write_int(Vip_gift_info#ps_vip_gift_info.is_buy, 8),
    <<Vip_level_Bin/binary,Item_id_Bin/binary,Is_buy_Bin/binary>>.

decode_ps_recharge_info(D0) ->
    {Recharge_money, D1} = nw_util:read_int(D0, 32),
    {Recharge_diamond, D2} = nw_util:read_int(D1, 32),
    {Is_double, D3} = nw_util:read_int(D2, 8),
    {Icon, D4} = nw_util:read_int(D3, 8),
    {#ps_recharge_info{
        recharge_money = Recharge_money,
        recharge_diamond = Recharge_diamond,
        is_double = Is_double,
        icon = Icon
        }, D4}.

encode_ps_recharge_info(Recharge_info) when is_record(Recharge_info, ps_recharge_info) ->
    Recharge_money_Bin = nw_util:write_int(Recharge_info#ps_recharge_info.recharge_money, 32),
    Recharge_diamond_Bin = nw_util:write_int(Recharge_info#ps_recharge_info.recharge_diamond, 32),
    Is_double_Bin = nw_util:write_int(Recharge_info#ps_recharge_info.is_double, 8),
    Icon_Bin = nw_util:write_int(Recharge_info#ps_recharge_info.icon, 8),
    <<Recharge_money_Bin/binary,Recharge_diamond_Bin/binary,Is_double_Bin/binary,Icon_Bin/binary>>.

decode_ps_first_recharge_item_info(D0) ->
    {Item_id, D1} = nw_util:read_int(D0, 16),
    {Item_num, D2} = nw_util:read_int(D1, 32),
    {#ps_first_recharge_item_info{
        item_id = Item_id,
        item_num = Item_num
        }, D2}.

encode_ps_first_recharge_item_info(First_recharge_item_info) when is_record(First_recharge_item_info, ps_first_recharge_item_info) ->
    Item_id_Bin = nw_util:write_int(First_recharge_item_info#ps_first_recharge_item_info.item_id, 16),
    Item_num_Bin = nw_util:write_int(First_recharge_item_info#ps_first_recharge_item_info.item_num, 32),
    <<Item_id_Bin/binary,Item_num_Bin/binary>>.

decode_ps_wish(D0) ->
    {Luck_num, D1} = nw_util:read_int(D0, 32),
    {Grids, D2} = nw_util:read_list(D1,protocol_parser,decode_ps_grid),
    {Force_refresh, D3} = nw_util:read_int(D2, 32),
    {Free_refresh, D4} = nw_util:read_int(D3, 32),
    {#ps_wish{
        luck_num = Luck_num,
        grids = Grids,
        force_refresh = Force_refresh,
        free_refresh = Free_refresh
        }, D4}.

encode_ps_wish(Wish) when is_record(Wish, ps_wish) ->
    Luck_num_Bin = nw_util:write_int(Wish#ps_wish.luck_num, 32),
    Grids_Bin = nw_util:write_list(Wish#ps_wish.grids, protocol_parser, encode_ps_grid),
    Force_refresh_Bin = nw_util:write_int(Wish#ps_wish.force_refresh, 32),
    Free_refresh_Bin = nw_util:write_int(Wish#ps_wish.free_refresh, 32),
    <<Luck_num_Bin/binary,Grids_Bin/binary,Force_refresh_Bin/binary,Free_refresh_Bin/binary>>.

decode_ps_grid(D0) ->
    {Seq, D1} = nw_util:read_int(D0, 8),
    {Award, D2} = protocol_parser:decode_ps_award(D1),
    {Times, D3} = nw_util:read_int(D2, 32),
    {#ps_grid{
        seq = Seq,
        award = Award,
        times = Times
        }, D3}.

encode_ps_grid(Grid) when is_record(Grid, ps_grid) ->
    Seq_Bin = nw_util:write_int(Grid#ps_grid.seq, 8),
    Award_Bin = protocol_parser:encode_ps_award(Grid#ps_grid.award),
    Times_Bin = nw_util:write_int(Grid#ps_grid.times, 32),
    <<Seq_Bin/binary,Award_Bin/binary,Times_Bin/binary>>.

decode_ps_grids(D0) ->
    {Grids, D1} = nw_util:read_list(D0,protocol_parser,decode_ps_grid),
    {#ps_grids{
        grids = Grids
        }, D1}.

encode_ps_grids(Grids) when is_record(Grids, ps_grids) ->
    Grids_Bin = nw_util:write_list(Grids#ps_grids.grids, protocol_parser, encode_ps_grid),
    <<Grids_Bin/binary>>.

decode_ps_award(D0) ->
    {Item_id, D1} = nw_util:read_int(D0, 32),
    {Item_num, D2} = nw_util:read_int(D1, 32),
    {#ps_award{
        item_id = Item_id,
        item_num = Item_num
        }, D2}.

encode_ps_award(Award) when is_record(Award, ps_award) ->
    Item_id_Bin = nw_util:write_int(Award#ps_award.item_id, 32),
    Item_num_Bin = nw_util:write_int(Award#ps_award.item_num, 32),
    <<Item_id_Bin/binary,Item_num_Bin/binary>>.

decode_ps_thing(D0) ->
    {Is_selled, D1} = nw_util:read_int(D0, 8),
    {Award, D2} = protocol_parser:decode_ps_award(D1),
    {#ps_thing{
        is_selled = Is_selled,
        award = Award
        }, D2}.

encode_ps_thing(Thing) when is_record(Thing, ps_thing) ->
    Is_selled_Bin = nw_util:write_int(Thing#ps_thing.is_selled, 8),
    Award_Bin = protocol_parser:encode_ps_award(Thing#ps_thing.award),
    <<Is_selled_Bin/binary,Award_Bin/binary>>.

decode_ps_awards(D0) ->
    {Awards, D1} = nw_util:read_list(D0,protocol_parser,decode_ps_award),
    {#ps_awards{
        awards = Awards
        }, D1}.

encode_ps_awards(Awards) when is_record(Awards, ps_awards) ->
    Awards_Bin = nw_util:write_list(Awards#ps_awards.awards, protocol_parser, encode_ps_award),
    <<Awards_Bin/binary>>.

decode_ps_log(D0) ->
    {Nickname, D1} = nw_util:read_string(D0),
    {Award_name, D2} = nw_util:read_string(D1),
    {#ps_log{
        nickname = Nickname,
        award_name = Award_name
        }, D2}.

encode_ps_log(Log) when is_record(Log, ps_log) ->
    Nickname_Bin = nw_util:write_string(Log#ps_log.nickname),
    Award_name_Bin = nw_util:write_string(Log#ps_log.award_name),
    <<Nickname_Bin/binary,Award_name_Bin/binary>>.

decode_ps_logs(D0) ->
    {Logs, D1} = nw_util:read_list(D0,protocol_parser,decode_ps_log),
    {#ps_logs{
        logs = Logs
        }, D1}.

encode_ps_logs(Logs) when is_record(Logs, ps_logs) ->
    Logs_Bin = nw_util:write_list(Logs#ps_logs.logs, protocol_parser, encode_ps_log),
    <<Logs_Bin/binary>>.



