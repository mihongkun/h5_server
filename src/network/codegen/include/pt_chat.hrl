%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_CHAT_HRL__).
-define(__PT_CHAT_HRL__, true).

%% ================== client to server proto =====================

-define(CS_CHAT, 1201).         %% 1201 - 发送聊天
-define(CS_FRIEND_CHAT, 1202).  %% 1202 - 发送好友聊天



%% ================== server to client proto =====================

-define(SC_HISTORY_INFOS, 1200).  %% 1200 - 聊天历史记录登陆推送
-define(SC_CHAT_UPDATE, 1201).    %% 1201 - 聊天新增



%% ================== proto const =====================

-define(CHAT_TYPE_WORLD, 1).        %% 聊天类型 1 - 世界聊天
-define(CHAT_TYPE_GUILD, 2).        %% 聊天类型 2 - 公会聊天
-define(CHAT_TYPE_FRIEND, 3).       %% 聊天类型 3 - 好友聊天

-define(CHAT_SHARE_TYPE_ROLE, 1).   %% 聊天分享类型 1 - 佣兵
-define(CHAT_SHARE_TYPE_ITEM, 2).   %% 聊天分享类型 2 - 物品
-define(CHAT_SHARE_TYPE_BTTLE, 3).  %% 聊天分享类型 3 - 战斗



%% ================== records =====================

%% 聊天历史记录登陆推送
-record(pt_history_infos,{
    world_chat_infos  = [], %% list(ps_chat_info) 聊天数据
    guild_chat_infos  = []  %% list(ps_chat_info) 聊天数据
}).

%% 聊天新增
-record(pt_chat_update,{
    type           = 0, %% integer() 类型 CONST@COUNT_TYPE
    add_chat_info  = none  %% chat_info 聊天数据
}).





%% ================== structs =====================

%% 聊天信息
-record(ps_chat_info,{
    sid         = 0, %% integer() 玩家ID
    lv          = 0, %% integer() 玩家等级
    vip         = 0, %% integer() 玩家vip等级
    pic         = 0, %% integer() 玩家头像ID
    frame       = 0, %% integer() 玩家头像框ID
    name        = "", %% list() 玩家名字
    msg         = "", %% list() 内容
    time        = 0, %% integer() 时间戳
    share_type  = 0, %% integer() 分享内容类型 const@CHAT_SHARE_TYPE
    share_id    = 0  %% integer() 分享内容ID
}).




-endif.