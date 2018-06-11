-ifndef(__SPOTGOLD_HRL__).
-define(__SPOTGOLD_HRL__, true).

-define(MARKET_TYPE_ORDINARY, 1).          	%% 1普通点金
-define(MARKET_TYPE_INTERMEDIATE, 2).       %% 2中级点金
-define(MARKET_TYPE_SENIOR, 3).             %% 3高级点金

%%点金
-record(spotgold,{
	sid=0, %%sid 玩家ID
	refresh_time=0, %刷新时间
	ordinary=0,     %普通点金
	intermediate=0, %中级点金
	senior=0        %高级点金
	}

	).


-endif.
