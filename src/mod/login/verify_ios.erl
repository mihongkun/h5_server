-module(verify_ios).

-include("log.hrl").
-include("account.hrl").
-include("pt_login.hrl").

-compile(export_all).

verify(PlatformID, Suid, Tokens, Timestamp) when Suid == <<>> orelse Suid == [] ->
	throw({error, "平台唯一标识不能为空"});
verify(PlatformID, Suid, Tokens, Timestamp) ->
	NowTime = util:unixtime(),
	#platform{ game_sys=GameSys, login_key=PrivateKey, login_verify_url=VerifyUrl } = util_config:get_platform_info(PlatformID),
	Content = binary_to_list(GameSys) ++ binary_to_list(Suid) ++ binary_to_list(Tokens) ++ integer_to_list(NowTime),

	Sign = util_rsa:sign(Content, PrivateKey, sha),

	RequestUrl = binary_to_list(VerifyUrl) ++ "?game_sys=" ++ binary_to_list(GameSys) 
						++ "&account=" ++ binary_to_list(Suid) ++ "&tokens=" ++ binary_to_list(Tokens) 
						++ "&timestamp=" ++ integer_to_list(NowTime) ++ "&sign=" ++ http_uri:encode(binary_to_list(Sign)),
	?ERR(account, "~p", [RequestUrl]),
	case httpc:request(get, {RequestUrl, []}, [], [{full_result, false}]) of
		{ok,{200, Content}} ->
			{struct, Result} = mochijson2:decode(Content),
			case lists:keyfind(<<"err_code">>, 1, Result) of
				{_, 0} ->
					{true, Suid, Suid};						
				_ ->
					{_, ErrMsg} = lists:keyfind(<<"err_msg">>, 1, Result),
					?ERR(?MODULE, "mg_server verify failed, ErrMsg = ~p", [ErrMsg]),
					throw({error, ErrMsg})
			end;				
		Other ->
			?ERR(account, "mg_server verify failed, ErrMsg = ~p", [Other]),
			throw({error, "平台校验不通过"})
	end.
	
	