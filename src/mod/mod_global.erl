-module(mod_global).

-include("log.hrl").
-include("data_global.hrl").


-export([
		get_value/1 % 获取global表对应ID的数值
	]).



get_value(ID) ->
	Cfg = data_global:get(ID),
	Cfg#cfg_global.value.


