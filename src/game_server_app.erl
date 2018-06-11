%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(game_server_app).
-include("log.hrl").
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1,check_debug/0]).


%% API.
start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			%{"/", cowboy_static, {priv_file, game_server, "index.html"}},
			%{"/websocket", ws_handler, []},
            {"/", ws_handler, []}
			%{"/static/[...]", cowboy_static, {priv_dir, game_server, "static"}}
		]}
	]),
	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
                env => #{dispatch => Dispatch,max_frame_size => 8000000}
        }),
    ok = init_ets(),
    game_server_app:check_debug(),
	game_server_sup:start_link().

-ifdef(GAME_DEBUG).
check_debug()->
    ?ERR(game_server_app,"game_server debug_mod: ~p",["debug"]).

-else.
check_debug()->
    ?ERR(game_server_app,"game_server debug_mod: ~p",["release"]).

-endif.


stop(_State) ->
	ok.

% start_all() ->
% 	ok = application:start(sasl),
%     ok = application:start(crypto),
%     ok = application:start(syntax_tools),
%     ok = application:start(asn1),
%     ok = application:start(public_key),
%     ok = application:start(ssl),
%     ok = application:start(compiler),
%     ok = application:start(goldrush),
%     ok = application:start(lager),
%     ok = application:start(emysql),
%     ok = application:start(ranch),
%     ok = application:start(cowlib),
%     ok = application:start(cowboy),
%     ok = application:start(inets),
% 	ok = application:start(game_server).


%% ets初始化(热更时候会重复调用)
init_ets() ->
    util:safe_create_ets(ets_uid,  [set, named_table, public, {keypos, 1}]),                %% 服务器唯一ID模块的ets表
    util:safe_create_ets(ets_login_token, [set, named_table, public, {keypos, 1}]),         %% 记录登陆token
    util:safe_create_ets(ets_accountname,  [set, named_table, public, {keypos, 1}]),        %% 账号对应sid（加快登陆检查流程）
    util:safe_create_ets(ets_nickname,  [set, named_table, public, {keypos, 1}]),           %% 昵称对应sid（加快登陆检查流程）
    
    util:safe_create_ets(ets_wish_log,[set,named_table,public,{keypos,1}]),                 %% 许愿池中奖记录数据 % 是否应该在这里添加呢
    util:safe_create_ets(ets_chat_his,[set,named_table,public,{keypos,1}]),                 %% 聊天历史数据 % 是否应该在这里添加呢
    ok.
    