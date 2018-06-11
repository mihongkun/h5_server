
-module(nh_chat).
-behaviour(b_nh_chat).
-compile(export_all).

on_chat(Chat_type, Msg, Share_type, Share_id) ->
	Sid = get(sid),
	mod_chat:client_chat(Sid,Chat_type, Msg, Share_type, Share_id).


on_friend_chat(Friend_sid, Msg, Share_type, Share_id) ->
	Sid = get(sid),
	mod_chat:history(Sid).