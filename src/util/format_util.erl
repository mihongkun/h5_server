%% 2018-5-2 laojiajie@gmail.com
%% 日志格式优化模块，对齐，上色（针对linux有效）

-module(format_util).

-include("log.hrl").
-include("sys_macro.hrl").

-compile(export_all).



log(Level,Args,Fmt)->
	log(Level,Args,Fmt,[]).

log(Level,Tags,Fmt,Args)->
	Module = find_key(Tags,module),
	Line  = find_key(Tags,line),
	LineMaxLen = 17,
	CurLen = length(util:to_list(Module))+length(util:to_list(Line)),

	AddLineLen =
	case CurLen < LineMaxLen of
		true ->	
			LineMaxLen - CurLen;
		false ->
			0
	end,

	NewTags = [format(Key,Value,AddLineLen)||{Key,Value}<-Tags],
	case os:type() of
		{unix,_} ->
			Color = 
			case Level of
				error -> "31";
				warning -> "33;2";
				info ->  "32";
				debug -> "34";
				_ -> none
			end,
			case Color of
				none ->
					lager:log(Level,NewTags, Fmt, Args);
				_ ->
					{NewFmt,NewArgs} = put_on_color(Fmt,Args,Color),
					lager:log(Level,NewTags, NewFmt, NewArgs)
			end;
		_ ->
			lager:log(Level,NewTags, Fmt, Args)
	end.


put_on_color(Fmt,Args,Color) ->
	case Args of 
		[] ->
			{color_format(Color,[Fmt]),Args};
		_ ->
			{color_fmt(Fmt),color_format(Color,Args)}
	end.

find_key([],Key) ->
	undefined;
find_key([{Key,Value}|_Res],Key) ->
	Value;
find_key([_First|Res],Key) ->
	find_key(Res,Key).

%% 	{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}
format(tag,Str,_AddLineLen) ->
	{tag,format_length(Str,14)};

format(module,Str,_AddLineLen) ->
	{module,Str};

format(line,Str,AddLineLen) ->
	{line,util:to_list(Str)++lists:duplicate(AddLineLen," ")};

format(sid,Str1,_AddLineLen) ->
	Str = 
	case Str1 of
		undefined ->
			"--------";
		_ ->
			Str1
	end,
	{sid,format_length(Str,12)};

format(pid,Str,_AddLineLen) ->
	{pid,format_length(Str,10)};

format(Key,Str,_AddLineLen) ->
	{Key,Str}.


format_length(Str1,Length) ->
	Str = util:to_list(Str1),
	Len = length(Str),
	case Len < Length of
		true ->
			Str++lists:duplicate(Length-Len," ");
		false ->
			Str
	end.


color_fmt(Fmt) ->
	color_fmt(Fmt,"").


%% 112,119   115
%% ~p,~w -> ~s
color_fmt([],Fmt) ->
	Fmt;
color_fmt([A = 126|[B = 112|Res]],Fmt) ->
	color_fmt(Res,Fmt++[A,115]);
	color_fmt([A = 126|[B = 119|Res]],Fmt) ->
	color_fmt(Res,Fmt++[A,115]);
color_fmt([A|Res],Fmt) ->
	color_fmt(Res,Fmt++[A]).



color_format(Color,Args) ->
	case os:type() of
		{unix,_} ->
			color_format_helper("\033["++Color++"m~p\033[0m",Args);
		{win32,_} ->
			Args;
		_ ->
			Args
	end.


color_format_helper(Fmt,Args) ->
	Fun = fun(Arg) ->
		case  is_list(Arg) andalso Arg /= [] andalso is_tuple(lists:nth(1,Arg)) == true of
			true ->
				Arg1 = util:term_to_string(Arg),
				case application:get_env(lager, max_arg_length) of
					{ok,MaxLength} ->
						void;
					_ ->
						MaxLength = 10000
				end,
				case length(Arg1) > MaxLength of
					true ->
						{ArgS,_} = lists:split(MaxLength,Arg1),
						Arg2 = ArgS++"......]";
					false ->
						Arg2 = Arg1
				end,
				lists:flatten(io_lib:format(Fmt,[Arg2]));
			false ->
				lists:flatten(io_lib:format(Fmt,[Arg]))
		end		
	end,
	lists:map(Fun,Args).

