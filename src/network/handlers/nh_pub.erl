-module (nh_pub).
% 酒馆处理器模块
% 2018-06-04 mihongkun@gmail.com
-compile (export_all).

-export ([
		on_pub/0,
		on_task/1,
		on_onekey/1,
		on_all/0,
		on_add/2,
		on_start/2,
		on_cancel/1,
		on_use/1,
		on_refresh/0,
		on_acc/1,
		on_done/1
	]).


on_pub() -> 
	Sid = get(sid),
	mod_pub:pub(Sid).
on_task(Id) -> 
	Sid = get(sid),
	mod_pub:task(Sid,Id).
on_onekey(Id) -> 
	Sid = get(sid),
	mod_pub:onekey(Sid,Id).
on_all() -> 
	Sid = get(sid),
	mod_pub:all(Sid).
on_add(Id, Heros) -> 
	Sid = get(sid),
	mod_pub:add(Sid,Id, Heros).
on_start(Id, Heros) -> 
	Sid = get(sid),
	mod_pub:start(Sid,Id, Heros).
on_cancel(Id) -> 
	Sid = get(sid),
	mod_pub:cancel(Sid,Id).
on_use(Type) -> 
	Sid = get(sid),
	mod_pub:use(Sid,Type).
on_refresh() -> 
	Sid = get(sid),
	mod_pub:refresh(Sid).
on_acc(Id) -> 
	Sid = get(sid),
	mod_pub:acc(Sid,Id).

on_done(Id) ->
	Sid = get(sid),
	mod_pub:done(Sid,Id).
