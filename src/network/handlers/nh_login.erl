-module(nh_login).
-include("pt_error.hrl").
-include("pt_login.hrl").
-include("log.hrl").
-include("login.hrl").
-include("account.hrl").
-include("common.hrl").

-export([on_login/9,
		on_create_player/12
	]).

%% 登陆
on_login(Account0,Server,Timestamp,Key,ConnectCount,Suid0,PlatformID,Idfamac,PlatformInfo) ->
	?ERR(?MODULE, "Account1=~p, Suid0=~p", [Account0, Suid0]),
	case catch mod_login:verify(Account0,Server,Timestamp,Key,ConnectCount,Suid0,PlatformID,Idfamac,PlatformInfo) of
		{false, ErrMsg} ->
			%% 验证失败
			pt_login:send(0,#pt_login_result{
						    errorcode  = ?LOGIN_RESULT_AUTH_FAILED, %% integer() 状态码
						    sid  = 0, %% integer() 账号ID
						    suid       = ErrMsg
						}),
			?LOGIN_STATUS_NONE;
		{true, Account, Suid} ->
			case ets:lookup(ets_login_token,{PlatformID, Server, Suid}) of
				[] when ConnectCount > 0 ->
					proto:send_error(0,?TIPS_ACCOUNT_RECONNECT_FAIL),
					erlang:send_after(2000, self(), {on_timer, gen_server, cast, [self(), {kickout, reconnect_fail}]}),
					?LOGIN_STATUS_NONE;
				_ ->
					ets:insert(ets_login_token, {{PlatformID, Server, Suid}, Key}),
					%% 检查账号是否有角色
					case mod_login:account_check(Account, Server, PlatformID) of
						0 ->

							put(accountinfo,{Account,Server,PlatformID}), %% 将基本信息保存一下 创建角色时候用到
							pt_login:send(0,#pt_login_result{
								    errorcode  = ?LOGIN_RESULT_NEED_CREATE_CHARACTER, %% integer() 状态码
								    sid  = 0, %% integer() 账号ID
								    suid       = Suid
								}),
							?LOGIN_STATUS_AUTH;
							% glog:log_link( Account, PlatformID, util_config:get_platform_name(PlatformID), Server, 1); %% 需要创建角色
						{error, ?TIPS_ACCOUNT_FORBID} -> %% 被封号
							proto:send_error(0,?TIPS_ACCOUNT_FORBID),
							erlang:send_after(1000, self(), {on_timer, gen_server, cast, [self(), {kickout, forbid_login}]}),
							?LOGIN_STATUS_NONE;
						Sid ->
							put(sid, Sid),

							pt_login:send(0,#pt_login_result{
								    errorcode  = ?LOGIN_RESULT_SUCCESS, %% integer() 状态码
								    sid  = Sid, %% integer() 账号ID
								    suid       = Suid
								}),
							?LOGIN_STATUS_NORMAL
					end
			end
	end.

%% 创角
on_create_player(Name1, Sex, Pic, InvideCode, Os, Osver, Device, DeviceType, Resolution, Service, Network, Phoneid) ->
	Name = Name1,
	case word_filter:check_valid_name(Name) of
		false ->
			pt_login:send(0,#pt_create_player_result{
			    error      = ?CREATE_RESULT_NAME_CHAR_ILLEGAL, 
			    sid  = 0 
			}),
			?LOGIN_STATUS_AUTH;
		true ->
			NameLen = erlang:byte_size(Name),
			case NameLen < 2 orelse NameLen > 21 of
				true ->
					pt_login:send(0,#pt_create_player_result{
					    error      = ?CREATE_RESULT_NAME_INVALID_LEN, 
					    sid  = 0 
					}),
					?LOGIN_STATUS_AUTH;
				false ->
					{AccountName,Server,PlatformID} = get(accountinfo),
					case g_player:create_account(AccountName, Server, PlatformID, Name, Sex, Pic) of
						{error, ErrCode} ->
							pt_login:send(0,#pt_create_player_result{
							    error      = ?CREATE_RESULT_NAME_INVALID_LEN, 
							    sid  = 0 
							}),
							?ERR(login, "on_create_player failed, ErrCode = ~p", [ErrCode]),
							?LOGIN_STATUS_AUTH;
						Account ->
							Sid = Account#account.sid,
							put(sid, Sid),

							pt_login:send(0,#pt_create_player_result{
							    error      = 0, 
							    sid  = Sid 
							}),
							% glog:log_create_account(Sid, Name1, nw_handler:get_cur_ip(), Os, Osver, Device, DeviceType, Resolution, Service, Network, Phoneid),
							% glog:log_task(Sid,0),
							% glog:log_link( Account#account.account, PlatformID, util_config:get_platform_name(PlatformID), Server, 2),
							erase(accountinfo),
							?LOGIN_STATUS_NORMAL
					end
			end
	end.