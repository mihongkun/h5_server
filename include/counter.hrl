-ifndef(__COUNTER_HRL__).
-define(__COUNTER_HRL__, true).

-include("common.hrl").

 

-record(counter, {
    key = {0,0},        %% {Sid,Type}
    count = 0			%% 计数
    }).

-endif.

