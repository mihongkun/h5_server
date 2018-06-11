-module (pub_data).
% 酒馆数据模块
% 2018-6-5 mihongkun@gmail.com


-include ("pub.hrl").
-include ("pt_pub.hrl").
-compile(export_all).


find_tasks(Sid) ->
	[rec_to_task(Rec) || Rec <- cache:lookup(Sid)].

find_task(Sid,TaskId) ->
	case cache:lookup(Sid,TaskId) of
		[] -> 
			undefined;
		[E] -> 
			rec_to_task(E)
	end.

rec_to_task(Rec) ->
	Taskid	 	= 	 Rec#pub.taskid,
	Nameid	 	= 	 Rec#pub.nameid,
	Ntarid	 	= 	 Rec#pub.starid,
	Timestamp	= 	 Rec#pub.timestamp,
	Itemid	 	= 	 Rec#pub.itemid,
	Itemnum	 	= 	 Rec#pub.itemnum,
	Lock	 	= 	 Rec#pub.lock,
	State	 	= 	 Rec#pub.state,
	Cons	 	= 	 Rec#pub.cons,
	% Id,Name,Star,Time,ItemId,Num,Lock,State,Cons
	{Taskid,Nameid,Ntarid,Timestamp,Itemid,Itemnum,Lock,State,Cons}.


task_to_rec(Sid,Task) ->
	{Taskid,Nameid,Ntarid,Timestamp,Itemid,Itemnum,Lock,State,Cons} = Task,
	#pub{
		sid = Sid,
		taskid = Taskid,
		nameid = Nameid,
		starid = Ntarid,
		timestamp = Timestamp,
		itemid = Itemid,
		itemnum = Itemnum,
		lock = Lock,
		state = State,
		cons = Cons
	}.	


% 批量更新任务
update_tasks(_,[]) -> ok;
update_tasks(Sid,[H,T]) -> 
	cache:update(task_to_rec(Sid,H)),
	update_tasks(Sid,T).

% 批量删除任务
delete_tasks(Sid,[]) -> ok;
delete_tasks(Sid,[H|T]) ->
	cache:delete(Sid,task_to_rec(Sid,H)),
	delete_tasks(Sid,T).

% 批量添加任务
insert_tasks(Sid,[]) -> ok;
insert_tasks(Sid,[H,T]) ->
	cache:insert(Sid,task_to_rec(Sid,H)),
	insert_tasks(Sid,T).







% get_task_data_name(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	Name.

% get_task_data_star(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	Star.

% get_task_data_time(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	Time.

% get_task_data_itemid(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	ItemId.

% get_task_data_num(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	Num.

% get_task_data_lock(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	Lock.

% get_task_data_state(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	State.

% get_task_data_cons(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	Cons.

% get_task_data_start(Tasks,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find(Tasks,Id),
% 	{Cons,ItemId,Num}.

% find_task_data_name(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	Name.

% find_task_data_star(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	Star.

% find_task_data_time(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	Time.

% find_task_data_itemid(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	ItemId.

% find_task_data_num(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	Num.

% find_task_data_lock(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	Lock.

% find_task_data_state(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	State.

% find_task_data_cons(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	Cons.

% find_task_data_start(Sid,Id) ->
% 	{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = find_task(Sid,Id),
% 	{Cons,ItemId,Num}.

% find_task(Sid,TaskId) ->
% 	case cache:lookup(Sid,pub) of
% 		[] -> [];
% 		[E] -> 
% 			Tasks = E#pub.tasks,
% 			find(Tasks,TaskId)
% 	end.

% find([H = {Id,_,_,_,_,_,_,_,_}|T],TaskId) when Id =:= TaskId ->
% 	H;
% find([_|T],TaskId) ->
% 	find(T,TaskId).



% delete(Sid,TaskId) ->
% 	case cache:lookup(Sid,pub) of
% 		[] -> defined;
% 		[E] ->
% 			Ts = E#pub.tasks,
% 			NTs = [NT ||NT = {Id,_,_,_,_,_,_,_,_}<-Ts, Id =/= TaskId],
% 			cache:update(E#pub{
% 					tasks  = NTs
% 				})
% 		end.
	
% update(Sid,Task) ->
% 	{TaskId,_,_,_,_,_,_,_,_} = Task, 
% 	case cache:lookup(Sid,pub) of
% 		[] -> defined;
% 		[E] ->
% 			Ts = E#pub.tasks,
% 			NTs = lists:map(fun({Id,_,_,_,_,_,_,_,_}) when Id =:= TaskId ->
% 				Task
% 			 end,Ts),
% 			cache:update(E#pub{
% 					tasks  = NTs
% 				})
% 		end.

% insert(Sid,Task) ->
% 	Rests = get_tasks(Sid),
% 	Ids = [Id||{Id,_,_,_,_,_,_,_,_} <- Rests],
% 	case Ids of
% 		[] -> Seq = 1;
% 		_ -> 
% 		Min = lists:min(Ids),
% 		case Min > 1 of
% 			true ->
% 				Seq = Min -1;
% 			_	-> 
% 				Seq =  Seq =  lists:max(Ids) + 1
% 		end	
% 	end,
% 	{_,Name,Star,Time,ItemId,Num,Lock,State,Cons} = Task,
% 	NTs = {Seq,Name,Star,Time,ItemId,Num,Lock,State,Cons},
% 	case cache:lookup(Sid,pub) of
% 		[] -> E = #pub{
% 			sid = Sid,
% 			rt = util:unixtime()
% 		};
% 		[E] -> Rests = E#pub.tasks
% 	end,
% 	cache:update(E#pub{
% 					tasks  = NTs
% 				}),
% 	Seq.


% get_tasks(Sid) ->
% 	case cache:lookup(Sid,pub) of
% 		[] -> [];
% 		[E] -> E#pub.tasks
% 	end.

% dns_tasks(Sid) ->
% 	Tasks = get_tasks(Sid),
% 	dns_tasks(Tasks,[],[]).

% dns_tasks([],Rest,Away) ->
% 	{Rest,Away};
% dns_tasks([H = {Id,Name,Star,Time,ItemId,Num,?TASK_LOCK_TYPE_Y,State,Cons}|T],Rest,Away) ->
% 	[H] ++ Rest,
% 	dns_tasks(T,Rest,Away);
% dns_tasks([H = {Id,Name,Star,Time,ItemId,Num,?TASK_LOCK_TYPE_N,State,Cons}|T],Rest,Away) ->
% 	[H] ++ Away,
% 	dns_tasks(T,Rest,Away).




