-module(test).

-include("role.hrl").
-include("log.hrl").
-include("tips.hrl").
-include("pt_login.hrl").
-include("common.hrl").
-include("chat.hrl").

-compile(export_all).


on_login(Socket,Account)->
	Args = [unicode:characters_to_binary(Account),101,util:unixtime(),"123456",0,"",1,"",""],
	Socket ! {gm_apply,0,nh_login,on_login,Args}.


on_create_player(Socket,NickName)->
	Args = [unicode:characters_to_binary(NickName), 1, 1, 0, "", "", "", "", "", "", "", ""],
	Socket ! {gm_apply,0,nh_login,on_create_player,Args}.


insert_role()->
	Fun = fun(Sid) ->
		spawn(test,do_insert_role,[Sid])
	end,
	lists:foreach(Fun,lists:seq(1,1000)).



do_insert_role(Sid)->
	Fun2 = fun(RoleID) ->
		Role = #role{
			key = {Sid,RoleID}
		},
		%%cache:lookup(role,Sid),
		cache:insert(Role)
	end,
	lists:foreach(Fun2,lists:seq(1,100)).


lookup_role()->
	Fun = fun(Sid) ->
		cache:lookup(role,Sid)
	end,
	lists:foreach(Fun,lists:seq(1,10000)).

test()->
	cache:insert(#role{key = {1001,1}}),
	cache:insert(#role{key = {1001,1}}),
	?INF(test,"test cahche = ~p",[cache:lookup(role,1001)]).


test_break()->
	try
		?TRY([1,2]==[1,2]),
		?DBG(test,"run 1")
	catch throw:?break ->
		?DBG(test,"run 2")
	end,
	?DBG(test,"run 3").

test_chat() ->
	A = #chat_world{
		wid  		= 		?CHAT_WORLD_ID,		% 世界id
		sid			=		1,					% 玩家id
		cont		=		"",					% 内容
		ts			=		0					% 时间戳
	},
	B = #chat_world{
		wid  		= 		?CHAT_WORLD_ID,		% 世界id
		sid			=		2,					% 玩家id
		cont		=		"",					% 内容
		ts			=		0					% 时间戳
	},
	C = #chat_world{
		wid  		= 		?CHAT_WORLD_ID,		% 世界id
		sid			=		3,					% 玩家id
		cont		=		"",					% 内容
		ts			=		0					% 时间戳
	},
	D = #chat_world{
		wid  		= 		?CHAT_WORLD_ID,		% 世界id
		sid			=		4,					% 玩家id
		cont		=		"",					% 内容
		ts			=		0					% 时间戳
	},
	Fun = fun(X)  -> ets:insert(ets_chat_his,X) end,
	Fun(A),
	Fun(B),
	Fun(C),
	Fun(D),
	Fun2 = fun(X) ->
		io:format("~p ~n",[X#chat_world.ts])
	end,

	[Fun2(X) || X <- ets:lookup(ets_chat_his,1)],

	io:format("~p ",[lists:])

	ok.

