%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_LOGIN_HRL__).
-define(__PT_LOGIN_HRL__, true).

%% ================== client to server proto =====================

-define(CS_LOGIN, 100).                   %% 100 - 登陆
-define(CS_ENTER_GAME, 101).              %% 101 - 进入游戏
-define(CS_CREATE_PLAYER, 102).           %% 102 - 创建角色
-define(CS_CHANGE_NAME, 104).             %% 104 - 玩家改名
-define(CS_CHANGE_INTRO, 105).            %% 105 - 修改个人说明
-define(CS_PING, 106).                    %% 106 - ping同步时间
-define(CS_GET_ASSIGN_PLAYER_INFO, 107).  %% 107 - 获取指定玩家信息
-define(CS_REQ_HEART_BEAT, 109).          %% 109 - 心跳包



%% ================== server to client proto =====================

-define(SC_LOGIN_RESULT, 100).                   %% 100 - 登陆返回
-define(SC_PLAYER_INFO, 101).                    %% 101 - 进入游戏返回
-define(SC_CREATE_PLAYER_RESULT, 102).           %% 102 - 创建角色返回
-define(SC_NEW_BATTLE_POWER, 103).               %% 103 - 通知战斗力变更
-define(SC_NEW_NAME, 104).                       %% 104 - 玩家改名返回
-define(SC_NEW_INTRO, 105).                      %% 105 - 修改个人说明返回
-define(SC_PONG, 106).                           %% 106 - pong同步时间
-define(SC_RESP_GET_ASSIGN_PLAYER_INFO, 107).    %% 107 - 返回指定玩家信息
-define(SC_PLAYER_LEVEL_CHANGE, 108).            %% 108 - 玩家等级变化，或者经验变化
-define(SC_REP_HEART_BEAT, 109).                 %% 109 - 心跳返回
-define(SC_RESP_NOTIFY_TD_DIAMOND_CHANGE, 110).  %% 110 - TD钻石消耗
-define(SC_NOTIFY_CROSS_DAY, 150).               %% 150 - 跨天



%% ================== proto const =====================

-define(LOGIN_RESULT_SUCCESS, 0).                %% 登陆返回 0 - 登陆成功
-define(LOGIN_RESULT_NEED_CREATE_CHARACTER, 1).  %% 登陆返回 1 - 验证成功，但是需要创建角色
-define(LOGIN_RESULT_AUTH_FAILED, 2).            %% 登陆返回 2 - 验证失败

-define(CREATE_RESULT_SUCCESS, 0).               %% 创角返回 0 - 创角成功
-define(CREATE_RESULT_NAME_CHAR_ILLEGAL, 1).     %% 创角返回 1 - 角色名含有非法字符
-define(CREATE_RESULT_NAME_EXIST, 2).            %% 创角返回 2 - 角色名已存在
-define(CREATE_RESULT_NAME_INVALID_LEN, 3).      %% 创角返回 3 - 角色名长度为1-7个中文字符
-define(CREATE_RESULT_ACCOUNT_EXIST, 4).         %% 创角返回 4 - 账号已存在，无需创角

-define(FUN_OPEN_TASK_ID, 1).                    %% 功能开启 1 - 最大任务
-define(FUN_OPEN_DUN_ID, 2).                     %% 功能开启 2 - 最大黑暗城副本
-define(FUN_OPEN_RAND_CHAPTER_ID, 3).            %% 功能开启 3 - 出现随机副本的章节，没有就是0
-define(FUN_OPEN_IS_FIRST_TIME_ENTER_GAME, 4).   %% 功能开启 4 - 第一次进入游戏1是 0否



%% ================== records =====================

%% 登陆返回
-record(pt_login_result,{
    errorcode  = 0, %% integer() 状态码
    sid        = 0, %% integer() 账号ID
    suid       = ""  %% list() 唯一ID
}).

%% 进入游戏返回
-record(pt_player_info,{
    name          = "", %% list() 名字
    sex           = 0, %% integer() 性别 1-男 2-女
    level         = 0, %% integer() 等级
    exp           = 0, %% integer() 经验
    pic           = 0, %% integer() 头像
    intro         = "", %% list() 个人说明
    open_infos    = [], %% list(ps_open_info) 各种功能进度
    battle_power  = 0  %% integer() 战斗力
}).

%% 创建角色返回
-record(pt_create_player_result,{
    error  = 0, %% integer() 状态码 0-成功 ....还有各种错误码，像名字非法等等....
    sid    = 0  %% integer() 账号ID
}).

%% 通知战斗力变更
-record(pt_new_battle_power,{
    battle_power  = 0  %% integer() 战斗力
}).

%% 玩家改名返回
-record(pt_new_name,{
    name  = ""  %% list() 玩家名字
}).

%% 修改个人说明返回
-record(pt_new_intro,{
    intro  = ""  %% list() 个人说明
}).

%% pong同步时间
-record(pt_pong,{
    client_time  = 0, %% integer() 客户端发送过来的时间戳，原样返回
    time         = 0  %% integer() 服务器收到请求时间戳
}).

%% 返回指定玩家信息
-record(pt_resp_get_assign_player_info,{
    sid         = 0, %% integer() 角色ID
    nick_name   = "", %% list() 角色名称
    level       = 0, %% integer() 玩家等级
    pic         = 0, %% integer() 头像
    guild_name  = ""  %% list() 公会名称
}).

%% 玩家等级变化，或者经验变化
-record(pt_player_level_change,{
    level  = 0, %% integer() 等级
    exp    = 0  %% integer() 当前经验
}).

%% 心跳返回
-record(pt_rep_heart_beat,{
    state  = 0  %% integer() 是否异常，0否，1是
}).

%% TD钻石消耗
-record(pt_resp_notify_td_diamond_change,{
    type       = 0, %% integer() 类型 1-增加 2-消耗
    type_desc  = "", %% list() 类型描述
    daimond    = 0  %% integer() 钻石消耗数量
}).

%% 跨天
-record(pt_notify_cross_day,{
}).





%% ================== structs =====================

%% 
-record(ps_open_info,{
    type   = 0, %% integer() 属性类型 @SEE FUN_OPEN
    value  = 0  %% integer() 属性值
}).




-endif.