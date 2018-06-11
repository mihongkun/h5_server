-module(util).

-include("common.hrl").
-include("sys_macro.hrl").

-compile(export_all).

% 随机数相关
-export([rand/2,		%% 产生一个介于Min到Max之间的随机整数
		 rand_n/3,		%% 产生n个介于Min到Max之间的随机整数
		 check_deno/1	%% 传入策划配置的万分数，检测是否命中
		]).

% 日期相关
-export([
			unixtime/0,			% 获取当前时间戳
			today/0,			% 获取今天的日期 20180602 
			check_other_day/1	% 传入时间戳，检查是否是今天
		]).




%% 产生一个介于Min到Max之间的随机整数,[Min, Max]
rand(Min, Max) when is_float(Min) orelse is_float(Max) ->
	rand(trunc(Min), trunc(Max));
rand(Same, Same) -> Same;
rand(Min, Max) ->
    %% 如果没有种子，将从核心服务器中去获取一个种子，以保证不同进程都可取得不同的种子
    case get("rand_seed") of
        undefined ->
            RandSeed = g_rand:get_seed(),
            rand:seed(exs1024s,RandSeed),
            put("rand_seed", RandSeed);
        _ -> skip
    end,
    M = Min - 1,
    rand:uniform(Max - M) + M.
    
% 从一个范围内随机取出N个数
rand_n(Min, Max, N) ->
	List = lists:seq(Min, Max),
	case Max - Min < N of
	true ->
		List;
	false ->
		Len = erlang:length(List),
		rand_n(List, N, [], Len, 0)
	end.
	
rand_n(_, 0, Res, _, Times) ->
	?DBG(util, "Times=~w", [Times]),
	Res;
rand_n(List, N, Res, Len, Times) ->
	Num = rand(1, Len),
	Val = lists:nth(Num, List),
	NewList = lists:delete(Val, List),
	rand_n(NewList, N - 1, [Val|Res], Len-1, Times+1).


check_deno(Deno)->
	Deno > 0 andalso util:rand(1,10000) =< Deno.

randomize(OrigList) ->
    Len = length(OrigList),
    [E || {_, E} <- lists:sort([{rand(1, Len), Elem} || Elem <- OrigList])].

%%向上取整
ceil(N) ->
    T = trunc(N),
    case N == T of
        true  -> T;
        false -> 1 + T
    end.

%% 对A除以B的商向上取整
ceil_div(A, B) ->
	C = A div B,
	case A rem B == 0 of
		true -> C;
		false -> C + 1
	end.

trunc_rec(Rec) ->
	Fun = fun(Arg) ->
		case is_float(Arg) of
			true ->
				trunc(Arg);
			false ->
				Arg
		end
	end,
	list_to_tuple(lists:map(Fun,tuple_to_list(Rec))).

round_rec(Rec) ->
	Fun = fun(Arg) ->
		case is_float(Arg) of
			true ->
				round(Arg);
			false ->
				Arg
		end
	end,
	list_to_tuple(lists:map(Fun,tuple_to_list(Rec))).


%%向下取整
floor(X) ->
    T = trunc(X),
    case (X < T) of
        true -> T - 1;
        _ -> T
    end.

%% 取两个整数中大的数
max(Num1, Num2) ->
	if
		Num1 > Num2 ->
			Num1;
		true ->
			Num2
	end.

%% 取两个整数中小的数
min(Num1, Num2) ->
	if
		Num1 > Num2 ->
			Num2;
		true ->
			Num1
	end.

%% 检查传入时间是否比今天开始时间早，即检查当前时间与传入时间是否不在同一天
%% return true非今天 false今天
check_other_day(ComTime) ->
	NowTime = unixtime(),
	case get_diff_day(ComTime, NowTime) of
		{later, _} ->
			true;
		the_same_day ->
			false;
		_Other ->
			true
	end.

check_other_day(ComTime, NType) ->
	NowTime = unixtime(),
	case get_diff_day(ComTime, NowTime, NType) of
		{later, _} ->
			true;
		the_same_day ->
			false;
		_Other ->
			true
	end.

check_other_month(ComTime) ->
	{NY, NM, _ND} = date(),
	BaseSeconds = ?DAYS_FROM_0_TO_1970*?SECONDS_PER_DAY,
	{{CY, CM, CD}, _} = calendar:gregorian_seconds_to_datetime(BaseSeconds+ComTime+get_diff_time()),
	NY /= CY orelse NM /= CM.

%% Time1 < Time2 返回:{later, 时间差}
%% Time1 > Time2 返回:{before, 时间差}
%% Time1 = Time2 返回:the_same_day
get_diff_day(Time1, Time2) ->
	{H, M, S} = {0, 0, 0},%% data_system:get(38),
	TmpTime1 = Time1 + get_diff_time()  - (H*3600 + M*60 + S),
	TmpTime2 = Time2 + get_diff_time()  - (H*3600 + M*60 + S),
	case (TmpTime2  div ?SECONDS_PER_DAY  - TmpTime1  div ?SECONDS_PER_DAY) of
		Time when Time > 0 ->
			{later, Time};
		Time when Time < 0 ->
			{before, -Time};
		_Time ->
			the_same_day  
	end.




%%根据Type宏定义在data文件取得对应的{H, M, S}，接着使用get_diff_day

get_diff_day(Time1, Time2, NType) ->
%% 	{H, M, S} = {22, 0, 0},
	%%竞技场的更新时间
	{H, M, S} = data_arena:get_system(NType),
	TmpTime1 = Time1 + get_diff_time()  - (H*3600 + M*60 + S),
	TmpTime2 = Time2 + get_diff_time()  - (H*3600 + M*60 + S),
	case (TmpTime2  div ?SECONDS_PER_DAY  - TmpTime1  div ?SECONDS_PER_DAY) of
		Time when Time > 0 ->
			{later, Time};
		Time when Time < 0 ->
			{before, -Time};
		_Time ->
			the_same_day  
	end.

%% 获取因为时区不一样引起的时间差
get_diff_time() ->
	%% unxitime()取的是从1970年到现在的秒数（时区为本机所设置时区）
	NowTime = unixtime(),
	{Days, {H, M, S}} = calendar:seconds_to_daystime(NowTime),
	%% date(), time()取的是从0年0月0日0时0分0秒距离现在的秒数（时区为0）
	Days1 = calendar:date_to_gregorian_days(date()),
	{H1, M1, S1} = time(),
	
	DiffTime = (Days1-Days-?DAYS_FROM_0_TO_1970)*?SECONDS_PER_DAY + (H1-H)*?SECONDS_PER_HOUR + (M1-M)*?SECONDS_PER_MINUTE + (S1-S),
	DiffTime.


is_in_list(List, Ele) ->
	Res = [E || E <- List, E =:= Ele],
	length(Res) > 0.

unixtime() ->
    {M, S, _} = os:timestamp(),
    M * 1000000 + S.

longunixtime() ->
    {M, S, Ms} = os:timestamp(),
    M * 1000000000 + S*1000 + Ms div 1000.

today() ->
	{Y,M,D} = erlang:date(),
	Y*10000 + M*100 + D.


get_timestamp() ->
	get_timestamp({date(),time()}).
get_timestamp({{Year, Month, Date}, {Hour, Minute, Second}}) ->
	lists:flatten(io_lib:format("~w-~2.10.0b-~2.10.0b ~2.10.0b:~2.10.0b:~2.10.0b", [Year, Month, Date, Hour, Minute, Second])).

unixtime_to_datetime(Seconds) ->
	calendar:gregorian_seconds_to_datetime(?SECONDS_FROM_0_TO_1970 + get_diff_time() + Seconds).

unixtime_to_timestamp(Seconds) ->
	DateTime = unixtime_to_datetime(Seconds),
	get_timestamp(DateTime).

datetime_to_unixtime({Y, M, D}) ->
	datetime_to_unixtime({{Y, M, D}, {0,0,0}});
datetime_to_unixtime(DateTime) ->
	calendar:datetime_to_gregorian_seconds(DateTime) - ?SECONDS_FROM_0_TO_1970 - get_diff_time().

timestamp_to_datetime(Timestamp) when is_binary(Timestamp) ->
	timestamp_to_datetime(binary_to_list(Timestamp));
timestamp_to_datetime(Timestamp) when is_list(Timestamp) ->
	[DateStr, TimeStr] = string:tokens(Timestamp, " "),
	[YS,MS,DS] = string:tokens(DateStr, "-"),
	[HS,MinS,SS] = string:tokens(TimeStr, ":"),
	{
	 {list_to_integer(YS),list_to_integer(MS),list_to_integer(DS)},
	 {list_to_integer(HS),list_to_integer(MinS),list_to_integer(SS)}
	}.

timestamp_to_unixtime(Timestamp) ->
	DateTime = timestamp_to_datetime(Timestamp),
	datetime_to_unixtime(DateTime).

read_id(Bin,Byte) ->
	<<Size:16,ResBin/binary>> = Bin,
	read_id_helper(Size,Byte,ResBin,[]).

read_id_helper(0,_Byte,_ResBin,List) ->
	List;
read_id_helper(Size,Byte,Bin,List) ->
	<<Arg:Byte,Res/binary>> = Bin,
	read_id_helper(Size-1,Byte,Res,List++[Arg]).

%% term序列化，term转换为string格式，e.g., [{a},1] => "[{a},1]"
term_to_string(Term) ->
	lists:flatten(io_lib:format("~w", [Term])).

%% term序列化，term转换为bitstring格式，e.g., [{a},1] => <<"[{a},1]">>
term_to_bitstring(Term) ->
    erlang:list_to_bitstring(io_lib:format("~w", [Term])).

%% term反序列化，string转换为term，e.g., "[{a},1]"  => [{a},1]
string_to_term(String) ->
    case erl_scan:string(String++".") of
        {ok, Tokens, _} ->
            case erl_parse:parse_term(Tokens) of
                {ok, Term} -> Term;
                _Err -> undefined
            end;
        _Error ->
            undefined
    end.


% erlang格式IP转换成二进制IP {192.168.24.203} => "192.168.24.203".
change_ip_to_bitstring({A,B,C,D}) ->
	list_to_binary(lists:flatten(io_lib:format("~w.~w.~w.~w", [A,B,C,D]))).

%% term反序列化，bitstring转换为term，e.g., <<"[{a},1]">>  => [{a},1]
bitstring_to_term(undefined) -> undefined;
bitstring_to_term(BitString) ->
    string_to_term(binary_to_list(BitString)).


get_page(Infos,PageNum,Page1) ->
	Page = erlang:max(1,Page1),
	Length = length(Infos),
	case Length > 0 of
		true ->
			MaxPage = util:ceil(Length/PageNum),
			case Page < MaxPage of
				true ->
					CurrentPage = Page,
					EIndex = Page*PageNum,
					SIndex = EIndex -(PageNum -1);
				false ->
					CurrentPage = MaxPage,
					EIndex = Length,
					SIndex = (MaxPage - 1)*PageNum +1
			end,
			Fun = fun(Index) ->
				{Index,lists:nth(Index,Infos)}
			end,
			Message = lists:map(Fun,lists:seq(SIndex,EIndex));
		false ->
			CurrentPage = 0,
			MaxPage = 0,
			Message = []
	end,
	{CurrentPage,MaxPage,Message}.

%% 转换成HEX格式的md5
md5(S) ->
    lists:flatten([io_lib:format("~2.16.0b",[N]) || N <- binary_to_list(erlang:md5(S))]).

check_and_set_tmp_cd(PlayerID, Type, CDTime) ->
    Now = util:unixtime(),
    case erlang:get({tmp_cd, PlayerID, Type}) of
        CDEndTime when is_integer(CDEndTime) andalso CDEndTime > Now ->
            false;
        _ ->
            erlang:put({tmp_cd, PlayerID, Type}, Now + CDTime),
            true
    end.

get_timeout_to_next_day(Now = {NowDate, _NowTime}) ->
    NowSec = calendar:datetime_to_gregorian_seconds(Now),
    NextDaySec = calendar:datetime_to_gregorian_seconds({NowDate, {23,59,59}}) + 1,
    erlang:max(0, NextDaySec - NowSec) * 1000.

trace(M,F) ->
	dbg:tracer(),
	dbg:p(all,call),
	dbg:tpl(M,F,'_',[{'_',[],[{return_trace}]}]).

%% @doc 将列表转为json
%% @spec list_to_json([{key,value},{key,value},...]) -> string
list_to_json(List) ->
%% 	L = {struct, List}, 
%% 	mochijson2:encode(L). %%好像有点问题
	Fun = fun({Key,Value}, Acc) ->
				  Str = 
					  case is_integer(Value) of
							  true ->
								  "\"" ++ Key ++ "\"" ++ ":" ++ integer_to_list(Value);
							  false ->
								  case is_float(Value) of 
									  true ->
										  "\"" ++ Key ++ "\"" ++ ":" ++ float_to_list(Value);
									  false ->
								  		"\"" ++ Key ++ "\"" ++ ":" ++ "\"" ++ Value ++ "\""
								  end
						end,
				  case Acc of
					  "" ->
						  Str;
					  _ ->
						  Acc ++ "," ++ Str
				  end
		end,	
	"{" ++ lists:foldl(Fun, "", List) ++ "}".

strip(Str, $ ) ->
	string:strip(Str);
strip(Str, $\r) ->
 	string:strip(Str, both, $\r);
strip(Str, $\n) ->
	string:strip(Str, both, $\n);
strip(Str, $\t) ->
	string:strip(Str, both, $\t).

%% @doc 将字符串两端的空白删除 包括 空格 换行符 制表符
%% @spec strip(string) -> string
strip(Str) ->
	L = erlang:length(Str),
	if 
		L > 0 ->
			try
				H = lists:nth(1, Str),	
				RH = strip(Str, H),
				strip(RH)
			catch _:_ ->
				Str
			end,
			try
				T = lists:nth(L, Str),
				RT = strip(Str, T),
				strip(RT)
			catch _:_ ->
				Str
			end;
		true ->
			Str
	end.	

%% @doc 根据xml的字段获取对应的值 注意本函数不适用与重复字段 也不能处理属性
%% @spec get_xml_value(binary|string, string) -> string
get_xml_value(Data, Key) ->
	Bin = 
		case is_list(Data) of
			true ->
				list_to_binary(Data);
			false ->
				Data
		end,
	B0 = binary:replace(Bin, <<"\r">>, <<>>, [global]),
	Xml = binary:replace(B0, <<"\n">>, <<>>, [global]),
	case re:run(Xml, Key ++ ".*>(.*)<",[ungreedy]) of
		{match,[_,{Start,Len}]} ->
			S = string:substr(binary_to_list(Xml), Start+1, Len),
			strip(S);			
		_Error ->
			data_not_found
	end.

%% @doc当天0点的时间戳
get_zero_hour_timestamp() ->
	datetime_to_unixtime({date(),{0,0,0}}).

%% @doc 安全创建ets,不抛任何异常～～
safe_create_ets(Name,Args) ->
	try
		case ets:info(Name) of
			undefined -> 
				ets:new(Name, Args);
			_ -> %%已经存在就不重复创建了
				Name
		end
	catch _:EM ->
		?ERR(util, "safe_create_ets(~p,~p) exception ~p",[Name, Args, EM]),
		false
	end.





day_of_the_week(UnixTime) when is_integer(UnixTime) ->
	day_of_the_week(unixtime_to_datetime(UnixTime));
day_of_the_week({{Year,Month,Day},{Hour,Minute,Second}}) ->
	day_of_the_week({Year,Month,Day});
day_of_the_week({Year,Month,Day}) ->
	calendar:day_of_the_week(Year,Month,Day).

to_integer(N) when is_integer(N) -> N;
to_integer(N) when is_list(N) -> list_to_integer(N);
to_integer(N) when is_binary(N) -> binary_to_integer(N);
to_integer(N) when is_float(N) -> trunc(N);
to_integer(true) -> 1;
to_integer(false) -> 0.

%% 产生随机字符串 Length为字符串长度
rand_str(Length) ->
	ALLOW_CHARS_LENGH = erlang:length(?ALLOW_CHARS),
	lists:foldl(fun(_,Acc) ->
			R = rand(1,ALLOW_CHARS_LENGH),
			CC = lists:nth(R,?ALLOW_CHARS),
			Acc ++ [CC]
		end,
		"",
		lists:seq(1,Length)).

%% 多个record合并相加,
%% 注意：
%%		1、record必须相同
%%		2、只对record中字段为 整型、浮点型、列表（不包括字符串）进行相加，其他字段只保留第一个record
merge_records([Record|Rest]) when is_tuple(Record) ->
	merge_records_help(Rest, Record).

merge_records_help([Record|Rest], TotRecord) when is_tuple(Record),is_tuple(TotRecord) ->
	[RecName|Rest1] = tuple_to_list(TotRecord),
	[RecName|Rest2] = tuple_to_list(Record),
	NewTotRecord = merge_records_help(Rest1, Rest2, [RecName]),
	merge_records_help(Rest, NewTotRecord);
merge_records_help([], TotRecord) when is_tuple(TotRecord) ->
	TotRecord.

% merge_records(Record1, Record2) when is_tuple(Record1),is_tuple(Record2) ->
% 	[RecName|Rest1] = tuple_to_list(Record1),
% 	[RecName|Rest2] = tuple_to_list(Record2),
% 	merge_records_help(Rest1, Rest2, [RecName]).

merge_records_help([Value1|Rest1], [Value2|Rest2], ResultList) when is_integer(Value1),is_integer(Value2) ->
	merge_records_help(Rest1, Rest2, [Value1+Value2|ResultList]);
merge_records_help([Value1|Rest1], [Value2|Rest2], ResultList) when is_float(Value1),is_float(Value2) ->
	merge_records_help(Rest1, Rest2, [Value1+Value2|ResultList]);
merge_records_help([Value1|Rest1], [Value2|Rest2], ResultList) when is_list(Value1),is_list(Value2) ->
	merge_records_help(Rest1, Rest2, [Value1++Value2|ResultList]);
merge_records_help([Value1|Rest1], [Value2|Rest2], ResultList) when is_tuple(Value1),is_tuple(Value2) ->
	merge_records_help(Rest1, Rest2, [Value1|ResultList]);
merge_records_help([Value1|Rest1], [Value2|Rest2], ResultList) when is_binary(Value1),is_binary(Value2) ->
	merge_records_help(Rest1, Rest2, [Value1|ResultList]);
merge_records_help([Value1|Rest1], [Value2|Rest2], ResultList) when is_atom(Value1),is_atom(Value2) ->
	merge_records_help(Rest1, Rest2, [Value1|ResultList]);
merge_records_help([], [], ResultList) ->
	list_to_tuple(lists:reverse(ResultList)).

gc_process(Pid) ->
	case erlang:process_info(Pid, total_heap_size) of
        {_, THS} when THS > 20 * 1024 * 1024 ->
            erlang:garbage_collect(Pid),
            ok;
        _ ->
            ok
    end.

%% 是否本月
is_this_month(Timestamp) ->
	{{Y,M,_},_} = unixtime_to_datetime(Timestamp),
	{Y1,M1,_} = date(),
	Y == Y1 andalso M == M1.

%% 今天日期
get_date_of_today() ->
	{_,_,D} = date(),
	D.

get_quality_color(1) -> "0xffffff";
get_quality_color(2) -> "0xbdffd6";
get_quality_color(3) -> "0x87d6ff";
get_quality_color(4) -> "0xe9b4ff";
get_quality_color(5) -> "0xffe9b4";
get_quality_color(6) -> "0xff0000".

test() ->
	{unicode:characters_to_binary(
			integer_to_list(6) ++ "月" ++ integer_to_list(1) ++ "日 " ++ 
			unicode:characters_to_list(unicode:characters_to_binary("你妹啊"))
			),
	unicode:characters_to_binary("6月1日 你妹啊")}.


to_atom(Msg) when is_atom(Msg) -> 
    Msg;
to_atom(Msg) when is_binary(Msg) -> 
	misc:list_to_atom(binary_to_list(Msg));
to_atom(Msg) when is_integer(Msg) ->
	misc:list_to_atom(integer_to_list(Msg));
to_atom(Msg) when is_tuple(Msg) -> 
	misc:list_to_atom(tuple_to_list(Msg));
to_atom(Msg) when is_list(Msg) ->
	Msg2 = list_to_binary(Msg),
	Msg3 = binary_to_list(Msg2),
    misc:list_to_atom(Msg3);
to_atom(_) ->
    misc:list_to_atom("").
%% list_to_existing_atom
list_to_atom(List)->
	try 
		erlang:list_to_existing_atom(List)
	catch _:_ ->
	 	erlang:list_to_atom(List)
	end.

%% 各种转换---list
to_list(Msg) when is_list(Msg) -> 
    Msg;
to_list(Msg) when is_atom(Msg) -> 
    atom_to_list(Msg);
to_list(Msg) when is_binary(Msg) -> 
    binary_to_list(Msg);
to_list(Msg) when is_integer(Msg) -> 
    integer_to_list(Msg);
to_list(Msg) when is_tuple(Msg) ->
	tuple_to_list(Msg);
to_list(Msg) when is_float(Msg) -> 
    float_to_list(Msg);
to_list(Msg) when is_pid(Msg) -> 
    pid_to_list(Msg);
to_list(_) ->
    [].
%% 各种转换---binary
to_binary(Msg) when is_binary(Msg) ->
    Msg;
to_binary(Msg) when is_atom(Msg) ->
	list_to_binary(atom_to_list(Msg));
to_binary(Msg) when is_list(Msg) -> 
	try list_to_binary(Msg)
	catch _:_ ->
		unicode:characters_to_binary(Msg,utf8)
	end;
to_binary(Msg) when is_integer(Msg) -> 
	list_to_binary(integer_to_list(Msg));
to_binary(Msg) when is_tuple(Msg) ->
	list_to_binary(tuple_to_list(Msg));
to_binary(Msg) when is_float(Msg) ->
	list_to_binary(float_to_list(Msg));
to_binary(_Msg) ->
    <<>>.
%% 各种转换---float
to_float(Msg) when is_float(Msg) ->
    Msg;
to_float(Msg) when is_integer(Msg) ->
    Msg * 1.0;
to_float(Msg)->
	Msg2 = to_list(Msg),
    try
	   list_to_float(Msg2)
    catch
        _:_ ->
            X = erlang:list_to_integer(Msg2),
            X * 1.0
    end.

%% 各种转换---tuple
to_tuple(T) when is_tuple(T) -> T;
to_tuple(T) when is_list(T) ->
	list_to_tuple(T);
to_tuple(T) -> {T}.



do_try(A) ->
	case A of 
		true -> true;
		false -> throw(?break);
		Else ->throw({do_try_unmatch,Else})
	end.
