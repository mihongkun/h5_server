-module(mod_account).

-include("log.hrl").
-include("account.hrl").


-compile(export_all).


get_account(Sid)->
	case cache:lookup(account,Sid) of
		[] ->
			undefined;
		[Account] ->
			Account
	end.

get_name(Sid) ->	
	Account = get_account(Sid),
	Account#account.nick_name.

get_level(Sid) -> 
	Account = get_account(Sid),
	Account#account.level.

get_vip(Sid) ->
	case get_account(Sid) of
		undefined -> undefined;
		E -> 
			E#account.vip
	end.