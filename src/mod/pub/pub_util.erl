-module (pub_util).
% 酒馆工具模块
% 2018-6-4 mihongkun@gmail.com


-include ("pt_pub.hrl").

-export ([
	send_pub/2,
	send_start/2,
	send_cancel/2,
	send_use/10,
	send_refresh/2,
	send_acc/3,
	send_lock/3
	]).


% -compile (export_all).

send_pub(Sid,Tasks) ->
	pt_pub:send(Sid,write_pt_pub(Tasks)).

write_pt_pub(Tasks) ->
	#pt_pub{
		tasks = [write_ps_record(Id,Name,Star,Time,ItemId,Num,Lock,State,Cons)|| {Id,Name,Star,Time,ItemId,Num,Lock,State,Cons} <-Tasks]
	}.

write_ps_record(Id,Name,StarID,Time,ItemId,Num,Lock,State,Cons) ->
	#ps_pub_record{
		id = Id,
		name = Name,
		starid = StarID,
		time = Time,
		item = ItemId,
		num = Num,
		lock = Lock,
		start = State,
		cons = Cons
	}.



send_start(Sid,TaskId) ->
	pt_pub:send(Sid,write_pt_start(TaskId)).	

write_pt_start(Id) ->
	#pt_pub_start{
		id = Id
	}.



send_cancel(Sid,TaskId) ->
	pt_pub:send(Sid,write_pt_cancel(TaskId)).

write_pt_cancel(Id) ->
	#pt_pub_cancel{
		id = Id
	}.



send_use(Sid,Id,Name,StarID,Time,ItemId,Num,Lock,State,Cons) ->
	pt_pub:send(Sid,write_pt_use(Id,Name,StarID,Time,ItemId,Num,Lock,State,Cons)).

write_pt_use(Id,Name,StarID,Time,ItemId,Num,Lock,State,Cons) ->
	#pt_pub_use{
		id = Id,
		name = Name,
		starid = StarID,
		time = Time,
		item = ItemId,
		num = Num,
		lock = Lock,
		start = State,
		cons = Cons
	}.



send_refresh(Sid,Tasks) ->
	pt_pub:send(Sid,write_pt_refresh(Tasks)).

write_pt_refresh(Tasks) ->
	#pt_pub_refresh{
		tasks = [write_ps_record(Id,Name,Star,Time,ItemId,Num,Lock,State,Cons)|| {Id,Name,Star,Time,ItemId,Num,Lock,State,Cons} <-Tasks]
	}.



send_acc(Sid,Id,Num) ->
	pt_pub:send(Sid,write_pt_acc(Id,Num)).

write_pt_acc(Id,Num) ->
	#pt_pub_acc{
		id = Id,
		num = Num
	}.



send_lock(Sid,Id,Lock) ->
	pt_pub:send(Sid,write_pt_lock(Id,Lock)).

write_pt_lock(Id,Lock) ->
	#pt_pub_lock{
		id = Id,
		type = Lock
	}.




