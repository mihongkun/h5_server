-ifndef(__PLAYER_HRL__).
-define(__PLAYER_HRL__, true).

-define(PLAYER_STATE_NONE,		0).		% player进程状态：未连接socket 
-define(PLAYER_STATE_NORMAL,	1).		% player进程状态：已连接socket 
-define(PLAYER_STATE_OFFLINE,	2).		% player进程状态：socket端口，离线 


-endif.