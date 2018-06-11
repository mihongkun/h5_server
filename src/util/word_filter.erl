%% Author: zqq
%% Created: 2011-12-12
%% Description: 词汇过滤操作
-module(word_filter).
-include("log.hrl").
%%
%% Include files
%%

-define(REPLACEMENT_WORDS, {
							[126,47,41,166,137,226,189,150,226,167,137,226,40,92,126],	%% ~\(≧▽≦)/~
							[173,149,226,41,176,149,226,95,175,149,226,40,174,149,226],	%% ╮(╯_╰)╭
							[173,149,226,41,176,149,226,189,150,226,175,149,226,40,174, 149,226],	%% ╮(╯▽╰)╭
							[43,148,128,226,95,148,128,226]		%% —_—+
						   }).
-define(REPLACEMENT_WORDS_NUM, 4).


-define(BAND_CHAR,[47,92]).


%%
%% Exported Functions
%%
-export([filter_prohibited_words/1,
	find_prohibited_words/1,
	find_special_words/1,
	find_band_char/1,
	check_valid_name/1]).

-compile(export_all).

%%
%% API Functions
%%
filter_prohibited_words(Content) when is_list(Content) ->
	Filtered = replace_content(Content, [], 0),
	Filtered.

find_prohibited_words(Content) when is_list(Content) ->
	case match_content(Content, 1) of
		no_match ->
			not_found;
		PosWord ->
			{found, PosWord}
	end.


find_band_char([]) ->
	not_found;
find_band_char([H1|Res]) ->
	case lists:member(H1,?BAND_CHAR) of
		true ->
			?ERR(char,"prohibited char = ~w",[H1]),
			{true,H1};
		false ->
			find_band_char(Res)
	end.

%%
%% Local Functions
%%

replace_content([], Acc, 0) ->
	lists:reverse(Acc);
replace_content([C], Acc, 0) ->
	lists:reverse([C | Acc]);
replace_content([H1 | [H2 | _] = T] = Content, Acc, 0) ->
	case data_word_filter:get_hashed_word_list(H1, H2) of
		undefined ->
			replace_content(T, [H1 | Acc], 0);
		WordList ->
			case match_words(Content, WordList) of
				{matched, Word} ->
					%% replace_content(T, [$* | Acc], length(Word)-1);
					Replacement = element(util:rand(1, ?REPLACEMENT_WORDS_NUM), ?REPLACEMENT_WORDS),
					replace_content(T, Replacement ++ Acc, length(Word)-1);
				no_match ->
					replace_content(T, [H1 | Acc], 0)
			end
	end;
replace_content([_|T], Acc, SkipTimes) ->
	replace_content(T, Acc, SkipTimes-1).
			

match_content([], _) ->
	no_match;
match_content([_], _) ->
	no_match;
match_content([H1 | [H2 | _] = T] = Content, Idx) ->
	case data_word_filter:get_hashed_word_list(H1, H2) of
		undefined ->
			match_content(T, Idx+1);
		WordList ->
			case match_words(Content, WordList) of
				{matched, Word} ->
					{Idx, Word};
				no_match ->
					match_content(T, Idx+1)
			end
	end.
	
match_words(_, []) ->
	no_match;
match_words(PartialContent, [H|T]) ->
	case lists:prefix(H, PartialContent) of
		true ->
			{matched, H};
		false ->
			match_words(PartialContent, T)
	end.

find_special_words(String) ->
	re:run(String, "[~`!@#$%^&*()+:;<>/?\|{}\\[\\]=,.\\\\]+").

%% 检查名字是否合规
check_valid_name(Name)->
	S = erlang:binary_to_list(Name),
	case word_filter:find_prohibited_words(S) of
		not_found ->
			case word_filter:find_band_char(S) of
				not_found ->
					case word_filter:find_special_words(S) of
						nomatch ->
							true;
						_ ->
							false
					end;
			_ ->
				false
			end;
		_ ->
			false
	end.

