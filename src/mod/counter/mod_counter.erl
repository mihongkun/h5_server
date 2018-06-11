-module(mod_counter).

-include("counter.hrl").
-include("pt_counter.hrl").
-compile(export_all).

-export([
		get/2,		% 获取对应类型的值
		set/3		% 设置对应类型的值
	]).


%% 登陆处理
login(Sid,Pid,Socket)->
	put(sid,Sid),
	put(socket,Socket),
	send_all_counters(Sid),
	gen_server:cast(Pid,{login_load_mod_finish,?MODULE}).

get(Sid,Type) ->
	case cache:lookup(counter,{Sid,Type}) of
		[] ->
			0;
		[Counter] ->
			Counter#counter.count
	end.


set(Sid,Type,Num) ->
	case cache:lookup(counter,{Sid,Type}) of
		[] ->
			case Num > 0 of
				true ->
					cache:insert(#counter{key = {Sid,Type},count = Num});
				false ->
					void
			end;
		[Counter] ->
			cache:update(Counter#counter{count = Num})
	end,
	pt_counter:send(Sid,#pt_counter_update{
	    type  = Type, 
	    num   = Num
	}).


send_all_counters(Sid) ->
	Counters = cache:lookup(counter,Sid),
	pt_counter:send(Sid,#pt_counter_infos{
	    counters  = [#ps_counter_info{
						    type  = Type,
						    num   = Num
						} || #counter{key = {_Sid,Type},count = Num} <- Counters]
	}).

