%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(game_server_app).
-behaviour(application).

%% API.
-export([start/2,start_all/0]).
-export([stop/1]).


%% API.
start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", cowboy_static, {priv_file, game_server, "index.html"}},
			{"/websocket", ws_handler, []},
			{"/static/[...]", cowboy_static, {priv_dir, game_server, "static"}}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 8088}],
		[{env, [{dispatch, Dispatch}]}]),
	game_server_sup:start_link().

stop(_State) ->
	ok.

start_all() ->
	ok = application:start(sasl),
    ok = application:start(crypto),
    ok = application:start(syntax_tools),
    ok = application:start(asn1),
    ok = application:start(public_key),
    ok = application:start(ssl),
    ok = application:start(compiler),
    ok = application:start(goldrush),
    ok = application:start(lager),
    ok = application:start(emysql),
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    ok = application:start(inets),

	%% ok = application:start(background),
   %% application:start(cache),
   %% application:start(game_logger),
	ok = application:start(game_server).
