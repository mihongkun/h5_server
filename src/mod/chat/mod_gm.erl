-module(mod_gm).
-include("common.hrl").
-include("log_type.hrl").
-compile(export_all).


check_gm(Sid,Msg) ->
	List = unicode:characters_to_list(Msg),
	case lists:nth(1,List) of
		35->
			StrList = string:tokens(Msg,"# "),
			FStrList = format_args(StrList),
			apply(mod_gm,handle,[Sid]++FStrList),
			true;
		_ ->
			false
	end.

format_args([Tag]) ->
	[erlang:list_to_atom(Tag),0,0];

format_args([Tag,Arg1]) ->
	[erlang:list_to_atom(Tag),erlang:list_to_integer(Arg1),0];

format_args([Tag,Arg1,Arg2]) ->
	[erlang:list_to_atom(Tag),erlang:list_to_integer(Arg1),erlang:list_to_integer(Arg2)].

% 加物品
handle(Sid,item,ItemID,Num) when Num > 0 ->
	mod_item:add(Sid,ItemID,Num,?OP_TYPE_GM);
handle(Sid,item,ItemID,Num) when Num =< 0 ->
	mod_item:add(Sid,ItemID,1,?OP_TYPE_GM);

% 加佣兵
handle(Sid,role,RoleID,Num) when Num > 0 ->
	mod_role:add_roles(Sid,RoleID,Num,?OP_TYPE_GM);
handle(Sid,role,RoleID,Num) when Num =< 0 ->
	mod_role:add_roles(Sid,RoleID,1,?OP_TYPE_GM);


handle(Sid,Tag,Arg1,Arg2) ->
	?DBG(gm,"cant find gm,Tag = ~w",[Tag]),
	void.

