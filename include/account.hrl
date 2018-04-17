-ifndef(__ACCOUNT_HRL__).
-define(__ACCOUNT_HRL__, true).

-record(account, {
    id = 0,  %% 账号ID
    server_id = 0,  %% 服务器ID
    platform_id = 0,  %% 平台ID
    account = "",  %% 平台账号
    level = 1,  %% 角色等级
    exp = 0,    %% 领主经验
    type = 0,  %% 角色类型 0-普通玩家 1-新手指导员
    sex = 0,  %% 性别 1-男 2-女
    pic = 0,  %% 头像资源ID
    nick_name = "",  %% 角色昵称
    is_lock = 0,  %% 是否封号 0-否 1-是
    lock_limit_time = 0,  %% 封号截止时间点
    chat_lock = 0,  %% 是否禁言 0-否 1-是
    chat_lock_time = 0,  %% 禁言截止时间
    reg_ip = "",  %% 注册IP
    login_ip = "",  %% 登陆IP
    active_time = 0,  %% 活跃时间
    last_login_time = 0,  %% 最后登陆时间
    last_logout_time = 0,  %% 最后登出时间
    register_time = 0,  %% 注册时间
    sys_mail_id = 0,  %% 系统邮件领取ID
    suid = "",  %% 平台使用唯一ID
    platform_name = "",  %% 平台名称
    introduction = ""  %% 玩家自我说明
	 				    
}).

%% 平台信息
-record(platform, {
    platform_id=0,              %% 平台标识ID（游戏分配）
    platform_name= <<>>,        %% 平台中文名称（游戏分配）
    game_sys = <<>>,            %% 平台归属系统  AND | IOS | YYIOS | TWAND | TWIOS | TWYYIOS
    cpp_id= <<>>,               %% 产品ID（平台分配）
    app_id= <<>>,               %% APPID（平台分配）
    game_id= <<>>,              %% 游戏ID（平台分配）
    open_id = <<>>,             %% OpenID（有些平台有，不知道什么鬼）
    login_key= <<>>,            %% 登录校验KEY
    login_verify_url= <<>>,     %% 登录校验地址
    recharge_key= <<>>          %% 充值校验KEY
}).

%% ============================ 平台定义规则 ===============================
%% 0                    ANDTEST
%% 1                    IOSTEST
%% 1001~1999            YYIOS
%% 2000                 IOS
%% 2001~2999            AND
%% 3001~3999            TWYYIOS
%% 4000                 TWIOS
%% 4001~4999            TWAND


%% =================== 测试 ====================
-define(PF_AND_TEST,                  0).
-define(PF_IOS_TEST,                  1).
%% ================= 大陆YYIOS =================
-define(PF_IOS_91, 500001).             %% iOS-91手机助手  500001  
-define(PF_IOS_TBT, 500002).            %% iOS-同步推 500002  
-define(PF_IOS_PP, 500003).             %% iOS-PP助手    500003  
-define(PF_IOS_ITOOLS, 500004).            %% iOS-iTools  500004  
-define(PF_IOS_DANGLE, 500014).            %% iOS-当乐  500014  
-define(PF_IOS_KUAIYONG, 500015).            %% iOS-快用  500015  
-define(PF_IOS_HAIMA, 500017).            %% iOS-海马助手    500017  
-define(PF_IOS_YULE, 500018).            %% iOS-娱玩  500018  
-define(PF_IOS_UC, 500019).            %% iOS-UC  500019  
-define(PF_IOS_AISI, 500020).            %% iOS-爱思助手    500020  
-define(PF_IOS_APPSTORE, 500026).            %% iOS-AppStore    500026  
-define(PF_IOS_XY, 500030).            %% iOS越狱－XY助手  500030  
-define(PF_IOS_XINDONG, 500034).            %% iOS-心动  500034  
-define(PF_IOS_XINDONGYY, 500036).            %% iOS-心动(越狱)  500036

%% ================== 大陆IOS ==================
-define(PF_IOS,                   2000).
%% ================== 大陆AND ==================

%% ================= 台湾YYIOS =================
%% ================== 台湾IOS ==================
-define(PF_TWIOS,                 4000).
%% ================== 台湾AND ==================
-define(PF_TWAND_7725,            4001).

-endif.
