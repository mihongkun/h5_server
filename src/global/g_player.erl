%% laojiajie@gmail.com
%% 玩家公共进程，用来防止一些竞争操作
%% 2018-4-18

-module(g_player).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

-include("log.hrl").
-include("account.hrl").
-include("sys_macro.hrl").
-include("pt_login.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).


start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [],[]).


init([]) ->
	Accounts = cache:tab2list(account),
	init_exit_accout(Accounts),
    {ok, undefine_state}.


init_exit_accout([])->
	ok;
init_exit_accout([Account|Res]) ->
	ets:insert(ets_accountname,{Account#account.account,Account#account.sid}),
	ets:insert(ets_nickname,{Account#account.nick_name,Account#account.sid}),
	init_exit_accout(Res).


create_account(AccountName, ServerID, PlatformID, NickName, Sex, Pic) ->
	RegIP = nw_util:get_ip(),
	
	gen_server:call(?MODULE, {create_account, AccountName, ServerID, PlatformID, NickName, Sex, Pic, RegIP}, ?SECONDS_PER_MINUTE*1000).


handle_cast(_,State) ->
	{noreply,State}.


handle_call({create_account, AccountName, ServerID, PlatformID, NickName, Sex, Pic, RegIP}, _From, State) ->
    Reply =
    case ets:lookup(ets_accountname, AccountName) of
    	[] ->
		    case ets:lookup(ets_nickname, NickName) of
		    	[] -> 
					% {ok, CenterNode} = application:get_env(game_server, center_node),

					PlatformName = <<>>,
					PlatformUser = <<>>,

					% ?ERR(?MODULE, "rpc:call(~w,g_account,register,[~w,~w,~w,~w,~w,~w,~w])", [CenterNode,AccountName,PlatformID,PlatformName,ServerID,NickName,PlatformUser,util:unixtime()]),

					% RegServerID = 
					% try
					% 	case rpc:call(CenterNode, g_account, register, [AccountName,PlatformID,PlatformName,ServerID,NickName,PlatformUser,util:unixtime()]) of
					% 		SID when is_integer(SID) ->
					% 			SID;
					% 		_ ->
					% 			ServerID
					% 	end
					% catch _:_ ->
					% 	ServerID
					% end,
					RegServerID = ServerID,

					AccountID = g_uid:get_uid(account),

					Account = #account{
								sid = AccountID,
								server_id = ServerID,
								platform_id = PlatformID,
								account = AccountName,
								suid = AccountName,
								sex = Sex,
								pic = Pic,
								nick_name = NickName,
								reg_ip = RegIP,
								login_ip = RegIP,
								last_login_time = util:unixtime(),
								register_time = util:unixtime(),
								%%sys_mail_id = g_uid:lookup(sys_mail)
								sys_mail_id = 0
						},
					cache:insert(Account),

					ets:insert(ets_nickname, {NickName, AccountID}),
					ets:insert(ets_accountname, {AccountName, AccountID}),

					Account;
				[_] ->
					{error, ?CREATE_RESULT_NAME_EXIST}
			end;
		[_] ->
			{error, ?CREATE_RESULT_ACCOUNT_EXIST}
	end,
    {reply, Reply, State};



handle_call(_,_From,State) ->
	{reply,none,State}.


handle_info({'EXIT', _, Reason}, State) ->
    io:format("g_player exit:~w", [Reason]),
    {stop, Reason, State}.

terminate(Reason, _State) ->
	io:format("g_player terminate:~w", [Reason]),
    ok.

