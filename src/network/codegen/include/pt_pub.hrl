%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_PUB_HRL__).
-define(__PT_PUB_HRL__, true).

%% ================== client to server proto =====================

-define(CS_PUB, 930).          %% 930 - 获取酒馆的基本信息点击酒馆时触发
-define(CS_PUB_START, 931).    %% 931 - 点击开始任务按钮
-define(CS_PUB_CANCEL, 932).   %% 932 - 取消任务
-define(CS_PUB_USE, 933).      %% 933 - 使用任务卷轴
-define(CS_PUB_REFRESH, 934).  %% 934 - 刷新任务列表
-define(CS_ACC, 935).          %% 935 - 加速任务
-define(CS_PUB_DONE, 936).     %% 936 - 完成
-define(CS_PUB_LOCK, 937).     %% 937 - 加解锁操作



%% ================== server to client proto =====================

-define(SC_PUB, 930).          %% 930 - 返回酒馆的基本信息
-define(SC_PUB_START, 931).    %% 931 - 点击开始任务按钮
-define(SC_PUB_CANCEL, 932).   %% 932 - 取消任务
-define(SC_PUB_USE, 933).      %% 933 - 使用任务卷轴
-define(SC_PUB_REFRESH, 934).  %% 934 - 刷新任务列表
-define(SC_PUB_ACC, 935).      %% 935 - 加速任务
-define(SC_PUB_DONE, 936).     %% 936 - 响应完成
-define(SC_PUB_LOCK, 937).     %% 937 - 加解锁操作



%% ================== proto const =====================

-define(TASK_LOCK_TYPE_N, 0).       %% 任务锁类型 0 - 未锁定 解锁
-define(TASK_LOCK_TYPE_Y, 1).       %% 任务锁类型 1 - 已锁定 加锁

-define(TASK_START_TYPE_DNS, 0).    %% 任务开始类型 0 - 未开始
-define(TASK_START_TYPE_DOING, 1).  %% 任务开始类型 1 - 已开始

-define(SCROLL_TYPE_ADV, 0).        %% 卷轴的类型 0 - 高级
-define(SCROLL_TYPE_BASE, 1).       %% 卷轴的类型 1 - 基础

-define(CON_TYPE_Y, 1).             %% 英雄是否符合条件 1 - 符合条件
-define(CON_TYPE_N, 0).             %% 英雄是否符合条件 0 - 不符合条件

-define(HERO_BATTLED_Y, 0).         %% 英雄是否已经上阵 0 - 未上阵
-define(HERO_BATTLED_N, 1).         %% 英雄是否已经上阵 1 - 已上阵



%% ================== records =====================

%% 返回酒馆的基本信息
-record(pt_pub,{
    tasks  = []  %% list(ps_record) 任务列表
}).

%% 点击开始任务按钮
-record(pt_pub_start,{
    id  = 0  %% integer() 任务id
}).

%% 取消任务
-record(pt_pub_cancel,{
    id  = 0  %% integer() 任务id
}).

%% 使用任务卷轴
-record(pt_pub_use,{
    id      = 0, %% integer() 任务的id
    name    = 0, %% integer() 任务名称
    starid  = 0, %% integer() 对应酒馆任务星级表中的id 
    time    = 0, %% integer() 未开始以前是任务所需要的时间不需要倒计时，任务开始以后就是剩余时间需要倒计时 
    item    = 0, %% integer() 奖励物品id
    num     = 0, %% integer() 奖励物品数量
    lock    = 0, %% integer() 是否加锁 @SEE:TASK_LOCK_TYPE_Y/TASK_LOCK_TYPE_N
    start   = 0, %% integer() 是否已经开始 @SEE:TASK_START_TYPE_DNS/TASK_START_TYPE_DOING
    cons    = []  %% list(integer()) 条件列表
}).

%% 刷新任务列表
-record(pt_pub_refresh,{
    tasks  = []  %% list(ps_record) 任务列表
}).

%% 加速任务
-record(pt_pub_acc,{
    id   = 0, %% integer() 物品id
    num  = 0  %% integer() 物品数量
}).

%% 响应完成
-record(pt_pub_done,{
    id   = 0, %% integer() 物品id
    num  = 0  %% integer() 物品数量
}).

%% 加解锁操作
-record(pt_pub_lock,{
    id    = 0, %% integer() 任务id
    type  = 0  %% integer() 加锁或解锁 @SEE TASK_LOCK_TYPE_Y/TASK_LOCK_TYPE_N
}).





%% ================== structs =====================

%% 任务表中的记录
-record(ps_pub_record,{
    id      = 0, %% integer() 任务的id
    name    = 0, %% integer() 任务名称
    starid  = 0, %% integer() 对应酒馆任务星级表中的id 
    time    = 0, %% integer() 未开始以前是任务所需要的时间不需要倒计时，任务开始以后就是剩余时间需要倒计时 
    item    = 0, %% integer() 奖励物品id
    num     = 0, %% integer() 奖励物品数量
    lock    = 0, %% integer() 是否加锁 @SEE:TASK_LOCK_TYPE_Y/TASK_LOCK_TYPE_N
    start   = 0, %% integer() 是否已经开始 @SEE:TASK_START_TYPE_DNS/TASK_START_TYPE_DOING/TASK_START_TYPE_DONE
    cons    = []  %% list(integer()) 条件列表
}).




-endif.