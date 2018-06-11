%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocol_selector

-module(protocol_selector).

-include("log.hrl").

-export([get_decoder/1]).

get_decoder(200) -> {pt_battle,decode_start_battle};
get_decoder(201) -> {pt_battle,decode_battle_report};
get_decoder(202) -> {pt_battle,decode_get_team_info};
get_decoder(203) -> {pt_battle,decode_set_team};
get_decoder(1201) -> {pt_chat,decode_chat};
get_decoder(1202) -> {pt_chat,decode_friend_chat};
get_decoder(1002) -> {pt_item,decode_sell_item};
get_decoder(1003) -> {pt_item,decode_compose_equipment};
get_decoder(1004) -> {pt_item,decode_chip_compose};
get_decoder(100) -> {pt_login,decode_login};
get_decoder(101) -> {pt_login,decode_enter_game};
get_decoder(102) -> {pt_login,decode_create_player};
get_decoder(104) -> {pt_login,decode_change_name};
get_decoder(105) -> {pt_login,decode_change_intro};
get_decoder(106) -> {pt_login,decode_ping};
get_decoder(107) -> {pt_login,decode_get_assign_player_info};
get_decoder(109) -> {pt_login,decode_req_heart_beat};
get_decoder(800) -> {pt_market,decode_get_shop};
get_decoder(801) -> {pt_market,decode_refresh_market};
get_decoder(802) -> {pt_market,decode_buy_market_props};
get_decoder(930) -> {pt_pub,decode_pub};
get_decoder(931) -> {pt_pub,decode_pub_start};
get_decoder(932) -> {pt_pub,decode_pub_cancel};
get_decoder(933) -> {pt_pub,decode_pub_use};
get_decoder(934) -> {pt_pub,decode_pub_refresh};
get_decoder(935) -> {pt_pub,decode_acc};
get_decoder(936) -> {pt_pub,decode_pub_done};
get_decoder(937) -> {pt_pub,decode_pub_lock};
get_decoder(611) -> {pt_role,decode_call_role};
get_decoder(612) -> {pt_role,decode_upgrade_role};
get_decoder(613) -> {pt_role,decode_put_equip};
get_decoder(614) -> {pt_role,decode_up_quality};
get_decoder(615) -> {pt_role,decode_up_star};
get_decoder(616) -> {pt_role,decode_buy_grid};
get_decoder(1101) -> {pt_spotgold,decode_get_spotgold};
get_decoder(1102) -> {pt_spotgold,decode_buy_spotgold};
get_decoder(700) -> {pt_vip,decode_get_vip_base_info};
get_decoder(701) -> {pt_vip,decode_buy_vip_gift};
get_decoder(710) -> {pt_vip,decode_get_first_recharge_info};
get_decoder(711) -> {pt_vip,decode_get_first_recharge_award};
get_decoder(900) -> {pt_wish,decode_wish};
get_decoder(901) -> {pt_wish,decode_pay};
get_decoder(902) -> {pt_wish,decode_logs};
get_decoder(905) -> {pt_wish,decode_guest};
get_decoder(906) -> {pt_wish,decode_refresh_wish};


get_decoder(ProtoNo) ->
	?ERR(protocol_selector,"cant find decoder,protoNo = ~w",[ProtoNo]),
	undefined.

