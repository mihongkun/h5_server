-module (chat_data).

%% 聊天存储模块
%% 希望能做成一个队列，但是当队列满了的时候可以一次性调整过来
%% 2018-6-11 mihongkun@gmail.com


-include ("chat.hrl").
-include ("pt_chat.hrl").
-compile (export_all).

% Sid,Lv,Vip,Pic,Frame,Name,Msg,Time,ShareType,ShareId


-export([
		insert/2,
		update/0,
		delete/0,
		find/0,
		push/0,
		pop/0,
		queue/0,
		find_all/1
	]).





chat_to_rec() -> ok;
chat_to_rec() -> ok;	
chat_to_rec() -> ok;
chat_to_rec() ->
	faild.


rec_to_chat() ->
	ok.



insert(?CHAT_TYPE_WORLD,xcc) ->
	% ets:insert();
	ok;
insert(?CHAT_TYPE_GUILD,xx) ->
	ok;
insert(?CHAT_TYPE_FRIEND,x) ->


	ok.

% 当前只有世界和工会
find_all(_Sid) ->
	

	ok.



update()->
	ok.

delete() ->
	ok.

find() ->
	ok.

push() ->
	ok.

pop() ->
	ok.

queue() ->
	ok.

