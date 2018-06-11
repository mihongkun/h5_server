-module(util_lists).

-include("log.hrl").
-include("sys_macro.hrl").

-export([
		rand/1,				% 从列表里随机一个值 [1,2,3,4] -> 3
		replace/3, 			% 替换列表里的第n个元素 2,5,[1,2,3,4] -> [1,5,3,4]
		seq_rand/1,			% 给定序列首尾组成的list,随机从这个序列中获取一个值 [1,2] -> 1 或 2, [1] -> 1
		rand_by_weight/1	% 从record列表中，根据权重随机出一个结果。(注意record最后一个字段必须为权重)
	]).


rand([]) ->
	undefined;
rand(List) ->
	lists:nth(util:rand(1,erlang:length(List)),List).


rand_by_weight([A|_Res]=RecordList)->
	Size = erlang:tuple_size(A),
	Fun = fun(Record,{Total,RandList})->
		Weight = erlang:element(Size,Record),
		{Total + Weight,[{Record,Weight}|RandList]}
	end,
	{Total,RandList1} = lists:foldl(Fun,{0,[]},RecordList),
	Odd = util:rand(1,Total),
	RandList = lists:reverse(RandList1),
	rand_by_weight_helper(RandList,Odd).
rand_by_weight_helper([{Record,Weight}|Res],Odd) when Weight >= Odd ->
	Record;
rand_by_weight_helper([{Record,Weight}|Res],Odd) ->
	rand_by_weight_helper(Res,Odd - Weight).



replace(0,NewValue,List) ->
	List;
replace(N,NewValue,List) when N > erlang:length(List) ->
	List;
replace(N,NewValue,List) ->
	{L,[_V|R]} = lists:split(N-1,List),
	L++[NewValue]++R.


seq_rand([A]) -> 
	A;
seq_rand([A,B]) -> 
	util:rand(A,B);
seq_rand(L) -> 
	undefined.