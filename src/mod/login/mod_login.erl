-module(mod_login).

-include("common.hrl").
-include("account.hrl").
-include("login.hrl").
-include("pt_error.hrl").

-include("pt_login.hrl").

-compile(export_all).


%% @doc 登录验证
%% @spec verify() -> {true, NewAccount, NewSuid} | {error, ErrCode}
verify(Account,Server,Timestamp,Key,ConnectCount,Suid,PlatformID,Idfamac,PlatformInfo) ->
	{ok, ServerID} = application:get_env(game_server, server_id),
	case Server == ServerID of
		false ->
			?ERR(?MODULE, "login error, server not match, ClientServerID=~w, ServerServerID=~p", [Server, ServerID]),
			throw({false, "server not match"});
		true ->
			ok
	end,

	{ok, PlatformList} = application:get_env(game_server, platform_list),
	case lists:member(PlatformID, PlatformList) orelse PlatformList == [] of
		false ->
			?ERR(?MODULE, "login error, platform_id not match, ClientPlatformID=~w, ServerPlatformList=~p", [PlatformID, PlatformList]),
			throw({false, "platform not allow login"});
		true ->
			ok
	end,

	case PlatformID of
		?PF_AND_TEST ->
			{true, Account, Account};
		?PF_IOS_TEST ->
			{true, Account, Account};
		?PF_IOS ->
			verify_ios:verify(PlatformID, Suid, Key, Timestamp);
		_ ->
			?ERR(?MODULE, "no match login verify call, PlatformID = ~p", [PlatformID]),
			throw({false, "no match login verify call for platform"})
	end.


%% @doc 检查帐号是否存在
account_check(AccountName, Server, PlatformID) ->
	NowTime = util:unixtime(),
	case ets:lookup(ets_accountname,AccountName) of
		[] ->
			0;
		[{AccountName,Sid}] ->
			Account = mod_account:get_account(Sid),
			case Account#account.is_lock == 1 andalso Account#account.lock_limit_time > NowTime of
				false ->
					cache:update(Account#account{
							login_ip = nw_util:get_ip(),
							last_login_time = NowTime					
							}),
					Account#account.sid;
				true ->
					{error, ?TIPS_ACCOUNT_FORBID}
			end
	end.

