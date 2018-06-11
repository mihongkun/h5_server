-ifndef(__COMMON_HRL__).
-define(__COMMON_HRL__, true).

-include("tips.hrl").
-include("log.hrl").
-include("log_type.hrl").

-define(break, break).
-define(TRY(A), util:do_try(A)).

%======================== 经济物品 ============================
-define(gold,		101).	% 金币
-define(diamond,	102).	% 钻石
-define(soul,		105).	% 英魂
-define(water,		125).	% 水滴
-define(stamen,		129).	% 体力
-define(narc,		127).	% 水仙

%======================== 其他资源 ============================
-define(jj_stone,		106).	% 进阶石


%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

-define(CHILD(I, Type, Args), {I, {I, start_link, [Args]}, permanent, 5000, Type, [I]}).

-define(CHILD(C, I, Type, Args), {C, {I, start_link, [Args]}, permanent, 5000, Type, [I]}).

-endif.


