%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_ROLE_HRL__).
-define(__PT_ROLE_HRL__, true).

%% ================== client to server proto =====================

-define(CS_CALL_ROLE, 611).     %% 611 - 召唤佣兵
-define(CS_UPGRADE_ROLE, 612).  %% 612 - 佣兵升级
-define(CS_PUT_EQUIP, 613).     %% 613 - 佣兵穿戴
-define(CS_UP_QUALITY, 614).    %% 614 - 佣兵进化
-define(CS_UP_STAR, 615).       %% 615 - 佣兵觉醒
-define(CS_BUY_GRID, 616).      %% 616 - 购买格子



%% ================== server to client proto =====================

-define(SC_ROLES, 600).           %% 600 - 佣兵数据返回
-define(SC_ROLES_UPDATE, 601).    %% 601 - 佣兵数据增量更新
-define(SC_ROLES_DELETE, 602).    %% 602 - 佣兵删除
-define(SC_ROLE_GRID_INFO, 603).  %% 603 - 格子数推送/更新
-define(SC_ROLE_CALL_INFO, 604).  %% 604 - 召唤信息推送/更新
-define(SC_CALL_RESULT, 611).     %% 611 - 召唤结果返回



%% ================== proto const =====================

-define(ROLE_ATTRI_ATK, 1).         %% 佣兵训练模块常量 1 - 攻击
-define(ROLE_ATTRI_DEF, 2).         %% 佣兵训练模块常量 2 - 防御
-define(ROLE_ATTRI_HP, 3).          %% 佣兵训练模块常量 3 - 血量
-define(ROLE_ATTRI_SPEED, 4).       %% 佣兵训练模块常量 4 - 速度
-define(ROLE_ATTRI_SKILL_HURT, 5).  %% 佣兵训练模块常量 5 - 技能伤害率
-define(ROLE_ATTRI_HIT, 6).         %% 佣兵训练模块常量 6 - 精准
-define(ROLE_ATTRI_DODGE, 7).       %% 佣兵训练模块常量 7 - 格挡
-define(ROLE_ATTRI_CRIT, 8).        %% 佣兵训练模块常量 8 - 暴击
-define(ROLE_ATTRI_CRIT_HURT, 9).   %% 佣兵训练模块常量 9 - 暴击伤害
-define(ROLE_ATTRI_ARP, 10).        %% 佣兵训练模块常量 10 - 破甲
-define(ROLE_ATTRI_STUN_IMM, 11).   %% 佣兵训练模块常量 11 - 免控率
-define(ROLE_ATTRI_HURT_IMM, 12).   %% 佣兵训练模块常量 12 - 免伤率
-define(ROLE_ATTRI_HOLY_HURT, 13).  %% 佣兵训练模块常量 13 - 神圣伤害
-define(ROLE_ATTRI_BS, 14).         %% 佣兵训练模块常量 14 - 吸血
-define(ROLE_ATTRI_ANGRY, 15).      %% 佣兵训练模块常量 15 - 初始怒气

-define(CALL_TYPE_NORMAL, 1).       %% 召唤类型 1 - 基础
-define(CALL_TYPE_SUPER, 2).        %% 召唤类型 2 - 高级
-define(CALL_TYPE_FRIEND, 3).       %% 召唤类型 3 - 友情
-define(CALL_TYPE_POWER, 4).        %% 召唤类型 4 - 能量

-define(PUT_TYPE_ON, 1).            %% 穿戴类型 1 - 穿上
-define(PUT_TYPE_OFF, 2).           %% 穿戴类型 2 - 脱下

-define(CALL_USE_DIAMOND_NO, 0).    %% 召唤是否使用钻石 0 - 否
-define(CALL_USE_DIAMOND_YES, 1).   %% 召唤是否使用钻石 1 - 是



%% ================== records =====================

%% 佣兵数据返回
-record(pt_roles,{
    roles  = []  %% list(ps_role) 佣兵数据
}).

%% 佣兵数据增量更新
-record(pt_roles_update,{
    roles  = []  %% list(ps_role) 佣兵数据
}).

%% 佣兵删除
-record(pt_roles_delete,{
    roles  = []  %% list(integer()) 佣兵世界ID
}).

%% 格子数推送/更新
-record(pt_role_grid_info,{
    grid      = 0, %% integer() 格子数
    buy_cost  = 0, %% integer() 下次购买的钻石价格
    buy_add   = 0  %% integer() 下次购买的增加的格子数
}).

%% 召唤信息推送/更新
-record(pt_role_call_info,{
    free_ts1  = 0, %% integer() 普通召唤下次免费时间戳,少于当前时间而且不等于0表示当前免费
    free_ts2  = 0, %% integer() 高级召唤下次免费时间戳,少于当前时间而且不等于0表示当前免费
    free_ts3  = 0  %% integer() 友情召唤下次免费时间戳,少于当前时间而且不等于0表示当前免费
}).

%% 召唤结果返回
-record(pt_call_result,{
    roles  = []  %% list(integer()) 佣兵配置ID
}).





%% ================== structs =====================

%% 穿戴装备列表
-record(ps_equips,{
    equip_id  = 0  %% integer() 装备原型ID
}).

%% 属性列表
-record(ps_attris,{
    type   = 0, %% integer() 属性类型
    value  = 0  %% integer() 属性值
}).

%% 佣兵结构
-record(ps_role,{
    uid          = 0, %% integer() 世界ID
    cfg_id       = 0, %% integer() 配置ID
    lv           = 0, %% integer() 等级
    star         = 0, %% integer() 星级
    quality      = 0, %% integer() 品阶
    equips       = [], %% list(ps_equips) 装备
    attris       = [], %% list(ps_attris) 属性
    power        = 0, %% integer() 战力
    xtal_id      = 0, %% integer() 水晶ID
    xtal_attris  = []  %% list(ps_attris) 水晶属性
}).




-endif.