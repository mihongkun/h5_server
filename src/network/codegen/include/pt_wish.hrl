%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_WISH_HRL__).
-define(__PT_WISH_HRL__, true).

%% ================== client to server proto =====================

-define(CS_WISH, 900).          %% 900 - 获取许愿池信息
-define(CS_PAY, 901).           %% 901 - 充值幸运币
-define(CS_LOGS, 902).          %% 902 - 获取中奖纪录列表
-define(CS_GUEST, 905).         %% 905 - 抽奖
-define(CS_REFRESH_WISH, 906).  %% 906 - 刷新许愿池



%% ================== server to client proto =====================

-define(SC_WISH, 900).          %% 900 - 返回许愿池的基本信息
-define(SC_PAY, 901).           %% 901 - 返回幸运币充值结果
-define(SC_LOGS, 902).          %% 902 - 返回中奖记录
-define(SC_GUEST, 905).         %% 905 - 返回奖品列表
-define(SC_REFRESH_WISH, 906).  %% 906 - 返回许愿池的许愿列表



%% ================== proto const =====================

-define(WISH_TYPE_WISH_NORMAL_TYPE, 0).  %% 许愿池类型 0 - 普通许愿池类型值
-define(WISH_TYPE_WISH_SUPER_TYPE, 1).   %% 许愿池类型 1 - 高级许愿池类型值

-define(WISH_GRID_STATE_Y, 0).           %% 许愿池格子状态 0 - 可以被抽取
-define(WISH_GRID_STATE_N, 1).           %% 许愿池格子状态 1 - 不可以被抽取



%% ================== records =====================

%% 返回许愿池的基本信息
-record(pt_wish,{
    type  = 0, %% integer() 许愿池类型 @SEE WISH_TYPE:WISH_NORMAL_TYPE、WISH_SUPER_TYPE
    wish  = none  %% wish 许愿池的基本信息
}).

%% 返回幸运币充值结果
-record(pt_pay,{
    type      = 0, %% integer() 许愿池类型 @SEE WISH_TYPE:WISH_NORMAL_TYPE、WISH_SUPER_TYPE
    luck_num  = 0  %% integer() 当前幸运币数量
}).

%% 返回中奖记录
-record(pt_logs,{
    type  = 0, %% integer() 许愿池类型 @SEE WISH_TYPE:WISH_NORMAL_TYPE、WISH_SUPER_TYPE
    logs  = none  %% logs 中奖纪录列表
}).

%% 返回奖品列表
-record(pt_guest,{
    type    = 0, %% integer() 许愿池类型 @SEE WISH_TYPE:WISH_NORMAL_TYPE、WISH_SUPER_TYPE
    awards  = none  %% awards 商品列表
}).

%% 返回许愿池的许愿列表
-record(pt_refresh_wish,{
    type   = 0, %% integer() 许愿池类型 @SEE WISH_TYPE:WISH_NORMAL_TYPE、WISH_SUPER_TYPE
    grids  = none  %% grids 许愿池的许愿列表
}).





%% ================== structs =====================

%% 许愿池基本信息
-record(ps_wish,{
    luck_num       = 0, %% integer() 幸运币数量
    grids          = [], %% list(ps_grid) 转盘列表
    force_refresh  = 0, %% integer() 强制刷新剩余时间 单位为秒,
    free_refresh   = 0  %% integer() 免费刷新剩余时间 单位为秒,小于等于0代表可以免费刷新
}).

%% 格子基本信息
-record(ps_grid,{
    seq    = 0, %% integer() 格子序号
    award  = none, %% award 单个奖品信息
    times  = 0  %% integer() 已经获取到的次数
}).

%% 许愿池的许愿列表
-record(ps_grids,{
    grids  = []  %% list(ps_grid) 许愿池的许愿列表
}).

%% 单个奖品信息
-record(ps_award,{
    item_id   = 0, %% integer() 物品ID
    item_num  = 0  %% integer() 物品数量
}).

%% 单个物品信息
-record(ps_thing,{
    is_selled  = 0, %% integer() 是否已经出售
    award      = none  %% award 单个奖品信息
}).

%% 奖品列表
-record(ps_awards,{
    awards  = []  %% list(ps_award) 奖品信息
}).

%% 单个获奖记录信息
-record(ps_log,{
    nickname    = "", %% list() 玩家昵称
    award_name  = ""  %% list() 奖品名称
}).

%% 获奖记录列表
-record(ps_logs,{
    logs  = []  %% list(ps_log) 获奖列表
}).




-endif.