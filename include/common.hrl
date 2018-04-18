-ifndef(__COMMON_HRL__).
-define(__COMMON_HRL__, true).
%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

-define(CHILD(I, Type, Args), {I, {I, start_link, [Args]}, permanent, 5000, Type, [I]}).

-define(CHILD(C, I, Type, Args), {C, {I, start_link, [Args]}, permanent, 5000, Type, [I]}).

-endif.


