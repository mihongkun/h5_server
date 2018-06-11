-module (mod_pub).
% 酒馆模块
% 2018-06-04 mihongkun@gmail.com


-include ("pub.hrl").
-include ("common.hrl").
-include ("sys_macro.hrl").
-include ("pt_pub.hrl").
-include ("data_role.hrl").
-include ("pt_counter.hrl").


-compile (export_all).
-export ([
		pub/1,		% 获取酒馆基础信息
		start/3,	% 开始任务
		cancel/2,	% 取消任务
		use/2,		% 使用卷轴
		refresh/1,	% 刷新任务列表
		acc/2,		% 加速
		done/2,		% 完成
		lock/3		% 加解锁操作
	]).


%% 登陆处理
login(Sid,Pid,Socket)->
	put(sid,Sid),
	put(socket,Socket),
	?DBG(mod_pub,"login sid = ~p,pid = ~p",[Sid,Pid]),
	gen_server:cast(Pid,{login_load_mod_finish,?MODULE}).


pub(Sid) -> 
	{Con,Tasks} = gen_tasks(Sid),
	case cache:lookup(Sid,pub) of
		[] ->
			E = pub_data:task_to_rec(Sid,Tasks),
			cache:insert(E);
		[E] ->
			case Con of 
				true -> 
					cache:update(pub_data:task_to_rec(Sid,Tasks)),
					mod_counter:set(?COUNT_TYPE_PUB_REFRESH_TIME,util:unixtime())
			end	
	end,
	pub_util:send_pub(Sid,Tasks).

task_update([],NTs) ->
	NTs;
task_update([H = {Id,Name,Star,Time,ItemId,Num,Lock,?TASK_START_TYPE_DOING,Cons}|T],NTs) -> 
	case Time + pub_cfg:get_pub_star_task_time(Star) * ?SECONDS_PER_HOUR =< util:unixtime()  of
		true ->
			task_update(T,{Id,Name,Star,Time,ItemId,Num,Lock,?TASK_START_TYPE_DOING,Cons} ++ NTs);
		_ ->
			task_update(T,[H] ++ NTs)
		end;
task_update([H|T],NTs) ->
	task_update(T,[H] ++ NTs).

	

% 生成或返回原有
gen_tasks(Sid) -> 
	case cache:lookup(Sid,pub) of
		[] -> 
			Rest = [];
		[E] ->
			Rest = rest(pub_data:rec_to_task(E),[]);
		_ -> 
			Rest = []
	end,
	case can_gen(Sid) of
		true ->
			{true,gen_tasks(-1,Rest,pub_cfg:get_base_task_number())};
		_ -> 
			{false,Rest}
	end.

% 将数据库中的数据已经开始任务保存下来
rest([],Res) ->
	task_update(Res,[]);
rest([{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}|T],Res) when State =/= ?TASK_START_TYPE_DNS ->
	rest(T,Res ++ [{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}]);
rest([_|T],Res) ->
	rest(T,Res).

gen_tasks(_,Tasks,0) ->
	task_update(Tasks,[]);
gen_tasks(-1,Tasks,N) ->
	Seq = erlang:length(Tasks) + 1,
	NTs  = replace_tasks_ids(-1,Tasks,Tasks,-1),
	gen_tasks(Seq,NTs,N);
gen_tasks(Seq,Tasks,N) ->
	Name = pub_util:rand_pub_name(),	
	Star = pub_util:rand_pub_star_by_weight(),
	Time = pub_util:get_pub_star_task_time(Star),
	CN = pub_util:get_pub_star_con_number(Star),
	Cons =gen_cons([],CN),
	{ItemId,Min,Max} = pub_cfg:rand_pub_award_meta(Star),
	Num =util:rand(Min,Max),
	Lock = ?TASK_LOCK_TYPE_N,
	State = ?TASK_START_TYPE_DNS,
	gen_tasks(Seq + 1,[{Seq,Name,Star,Time,ItemId,Num,Lock,State,Cons}] ++ Tasks,N - 1). 

gen_task(Star) ->
	Name = pub_util:rand_pub_name(),
	Time = pub_util:get_pub_star_task_time(Star),
	CN = pub_util:get_pub_star_con_number(Star),
	Cons =gen_cons([],CN),
	{ItemId,Min,Max} = pub_cfg:rand_pub_award_meta(Star),
	Num =util:rand(Min,Max),
	Lock = ?TASK_LOCK_TYPE_N,
	State = ?TASK_START_TYPE_DNS,
	{0,Name,Star,Time,ItemId,Num,Lock,State,Cons}.

replace_tasks_ids(_,[],_,_) ->
	[];
replace_tasks_ids(_,Tasks,_,0) ->
	Tasks;
replace_tasks_ids(-1,Tasks,_,-1) ->
	Len = erlang:length(Tasks),
	replace_tasks_ids(1,Tasks,[],Len);
replace_tasks_ids(Seq,[H|T],Tasks,N) ->
	{_,Name,Star,Time,ItemId,Num,Lock,State,Cons}  = H,
	replace_tasks_ids(Seq + 1,{Seq,Name,Star,Time,ItemId,Num,Lock,State,Cons} ++ Tasks,T,N - 1).

% 看下能不能生成
can_gen(Sid) -> 
	case cache:lookup(Sid,pub) of
		[] -> 
			true;
		[E] ->	
			try
				 Now = util:unixtime(),
				 RT = util:datetime_to_unixtim({erlang:date(),{pub_cfg:get_base_task_refresh_time(),?TASK_REFRESH_MIN,?TASK_REFRESH_SEC}}),
				?TRY(Now >= RT andalso mod_counter:get(?COUNT_TYPE_PUB_REFRESH_TIME) < RT),
				true
			catch 
				throw:?break ->
					false
			end;
		_  -> false
	end.

gen_cons(Cons,0) ->
	Cons;
gen_cons(Cons,N) ->
	gen_cons(Cons ++ [pub_cfg:rand_pub_rand()],N - 1). 

start(Sid,Id, Heros) -> 
	Cons = pub_data:find_task_data_cons(Sid,Id),
	StarId = pub_data:find_task_data_star(Sid,Id),
	try
		?TRY(check_hero_num(Sid,erlang:length(Heros),StarId)),
		?TRY(check_start(Sid,Cons,Heros,erlang:length(Cons))),
		?TRY(check_star(StarId,Heros)),
		?TRY(check_battled(Sid,Heros)),
		Time = util:unixtime(),
		State = ?TASK_START_TYPE_DOING,
		Lock =  ?TASK_LOCK_TYPE_Y,
		{Id,Name,Star,_,ItemId,Num,_,_,Cons} = pub_data:find_task(Sid,Id), 
		pub_data:update(Sid,{Id,Name,Star,Time,ItemId,Num,Lock,State,Cons}),
		pub_util:send_start(Sid,Id)
	catch
		throw:?break ->
			void
	end.	
% todo 需要得到佣兵的数据库纪录	
check_battled(Sid,Heros) ->
	true.

check_hero_num(Sid,Num,StarId) ->
	Need = pub_cfg:get_(StarId),
	case Need == Num of
		true -> true;
		_ -> 
			proto:send_error(Sid,?TIPS_PUB_HERO_LACK),
			false
		end.

check_start(Sid,[],_,_) ->
	true;
check_start(Sid,_,_,0) ->
	proto:send_error(Sid,?TIPS_PUB_CON_LACK),
	false;
check_start(Sid,[H|T],Heros,N) ->
	lists:map(fun(HeroId) ->
			case check_con(H,HeroId) of
				true -> 
					check_start(Sid,T,Heros,N -1)
			end
		end,Heros).


check_con(ConId,HeroId) ->
    Hero = data_role:get(HeroId),
    Camp = pub_cfg:get_pub_rand_camp(ConId),
    Occ = pub_cfg:get_pub_rand_occupation(ConId),
    HCamp = Hero#cfg_role.camp,
    HOcc = Hero#cfg_role.career,
	case Camp =:= HCamp orelse Occ =:= HOcc of
		true ->
			true
	end.

check_star(StarId,Heros) ->
	Star = pub_cfg:get_pub_star_star_condition(StarId),
	case erlang:length(list:map(fun(H) -> 
			Hero = data_role:get(H),
			HStar = Hero#cfg_role.star,
			case HStar >= HStar of 
				true -> true
			end
		end,Heros)) of
		0 -> 
			false;
		_ -> 
			true
	end.


cancel(Sid,Id) -> 
	pub_data:delete(Sid,Id),
	pub_util:send_cansel(Sid,Id).

use(Sid,Type) ->
	Star = rand_star(Sid,Type),
	Task = gen_task(Star),
	{_,Name,Star,Time,ItemId,Num,Lock,State,Cons} = Task,
	Seq = pub_data:insert(Sid,Task),
	pub_util:send_use(Sid,Seq,Name,Star,Time,ItemId,Num,Lock,State,Cons).

rand_star(_,?SCROLL_TYPE_BASE) ->
	util_lists:rand(pub_cfg:get_base_refresh_task());
rand_star(_,?SCROLL_TYPE_ADV) ->
	util_lists:rand(pub_cfg:get_base_refresh_task1());
rand_star(Sid,Type) ->
	?DBG(mod_pub,"login type = ~p,pid = ~p",[Sid,Type]).

refresh(Sid) ->
	Cost = pub_cfg:get_base_consume(),
	{RestTasks,AwayTasks} = pub_data:dns_tasks(Sid),
	Num = erlang:length(AwayTasks),
	Total = Cost * Num,
	try 
		?TRY(chech_refresh(Num)),
		?TRY(mod_item:use(Sid,?diamond,Total)),
		Tasks = gen_tasks(-1,RestTasks,Num),
		pub_data:update(Sid,Tasks),
		pub_util:send_refresh(Sid,Tasks)
	catch 
		throw:?break ->
			void
	end.


chech_refresh(Num) when Num =< 0 ->
	% proto:send_error(Sid,?),
	false.

acc(Sid,Id) -> 
	try
		StarId = pub_data:find_task_data_star(Sid,Id),
		Cost = pub_cfg:get_pub_star_acc_cost(StarId),
		?TRY(mod_item:use(Sid,?diamond,Cost)),
		{_,RewardID,Num} = pub_data:find_task_data_start(Sid,Id),
		pub_data:delete(Sid,Id),
		mod_item:add(Sid,RewardID,Num,?OP_TYPE_ITEM_REWARD),
		pub_util:send_acc(Sid,RewardID,Num)
	catch 
		throw:?break->
			void
	end.

done(Sid,Id) -> 
	try 
		?TRY(check_done(Sid,Id)),
		{_,RewardID,Num} = pub_data:find_task_data_start(Sid,Id),
		pub_data:delete(Sid,Id),
		pub_util:send_done(Sid,RewardID,Num)
	catch 
		throw:?break ->
			void
	end.	

check_done(Sid,Id) ->
	State = pub_data:find_task_data_state(Sid,Id),
	Star = pub_data:find_task_data_star(Sid,Id),
	case State of
		?TASK_START_TYPE_DNS ->
			% proto:send_error(Sid,),
			false;
		_ -> 
			case (pub_data:get_task_data_time() + pub_cfg:get_pub_star_task_time(Star) * ?SECONDS_PER_HOUR) >= util:unixtime() of
				true ->
					true;
				_ 	 ->
					% proto:send_error(Sid,),
					false
			end
	end.

lock(Sid,TaskId,Type) ->
	try 
		?TRY(check_task_start(Sid,TaskId)),
		{Id,Name,Star,Time,ItemId,Num,Lock,_,Cons} = pub_data:find_task(Sid,TaskId), 
		pub_data:update(Sid,{Id,Name,Star,Time,ItemId,Num,Lock,Type,Cons}),
		pub_util:send_lock(Sid,Type)
	catch
		throw:?break ->
			void
	end.	
	



check_task_start(Sid,TaskId) ->
	case pub_data:find_task_data_start(TaskId) of
		?TASK_START_TYPE_DNS ->
			true;
		_ ->
			proto:send_error(Sid,?TIPS_PUB_STARTED),
			false
		end.

