%% WARNING: THIS FILE WAS AUTO-GENERATED, PLEASE DO NOT EDIT.
%% @doc protocols definition

-ifndef(__PT_BATTLE_HRL__).
-define(__PT_BATTLE_HRL__, true).

%% ================== client to server proto =====================

-define(CS_START_BATTLE, 200).   %% 200 - 发起战斗
-define(CS_BATTLE_REPORT, 201).  %% 201 - 请求战报
-define(CS_GET_TEAM_INFO, 202).  %% 202 - 获取上阵信息
-define(CS_SET_TEAM, 203).       %% 203 - 设置上阵信息



%% ================== server to client proto =====================

-define(SC_BATTLE_REPORT, 200).   %% 200 - 战报返回
-define(SC_TEAM_INFO_BACK, 202).  %% 202 - 上阵信息推送/更新



%% ================== proto const =====================

-define(BATTLE_TYPE_PVP, 1).           %% 战斗类型 1 - 竞技场
-define(BATTLE_TYPE_FRIEND, 2).        %% 战斗类型 2 - 好友切磋
-define(BATTLE_TYPE_DUN, 3).           %% 战斗类型 3 - 副本

-define(ENTITY_TYPE_ROLE, 1).          %% 单位类型 1 - 佣兵
-define(ENTITY_TYPE_MONSTER, 2).       %% 单位类型 2 - 怪物

-define(BATTLE_RESULT_WIN, 1).         %% 战斗结果 1 - 胜利
-define(BATTLE_RESULT_LOSE, 2).        %% 战斗结果 2 - 失败

-define(BATTLE_HURT_EFFECT_CRIT, 1).   %% 伤害效果 1 - 暴击
-define(BATTLE_HURT_EFFECT_DODGE, 2).  %% 伤害效果 2 - 闪避

-define(BATTLE_BUFF_TYPE_BUFF, 1).     %% buff类型 1 - 普通buff
-define(BATTLE_BUFF_TYPE_MARK, 2).     %% buff类型 2 - 印记



%% ================== records =====================

%% 战报返回
-record(pt_battle_report,{
    battle_id    = 0, %% integer() 战报ID
    scene_id     = 0, %% integer() 场景ID
    sid          = 0, %% integer() 发起者ID
    name         = "", %% list() 发起者名字
    level        = 0, %% integer() 发起者等级
    pic          = 0, %% integer() 发起者头像ID
    tar_sid      = 0, %% integer() 迎战者ID
    tar_name     = "", %% list() 迎战者名字
    tar_level    = 0, %% integer() 迎战者等级
    tar_pic      = 0, %% integer() 迎战者头像ID
    entities     = [], %% list(ps_entity) 佣兵初始化信息
    rounds       = [], %% list(ps_battle_round) 战斗回合信息
    total_hurts  = [], %% list(ps_total_hurt) 战斗总伤害信息
    rewards      = [], %% list(ps_reward) 奖励
    result       = 0  %% integer() 战斗结果 const@BATTLE_RESULT
}).

%% 上阵信息推送/更新
-record(pt_team_info_back,{
    type  = 0, %% integer() 战斗类型 const@BATTLE_TYPE
    team  = none  %% team_info 上阵信息
}).





%% ================== structs =====================

%% 战斗单位初始信息
-record(ps_entity,{
    pos        = 0, %% integer() 站位
    type       = 0, %% integer() 单位类型 const@ENTITY_TYPE
    cfg_id     = 0, %% integer() 单位配置ID
    level      = 0, %% integer() 等级
    star       = 0, %% integer() 星级
    hp         = 0, %% integer() 初始血量
    max_hp     = 0, %% integer() 最大血量
    angry      = 0, %% integer() 初始怒气
    max_angry  = 0  %% integer() 最大怒气
}).

%% 回合信息
-record(ps_battle_round,{
    cur_round  = 0, %% integer() 当前回合
    steps      = [], %% list(ps_step_event) 步骤信息
    buff_end   = [], %% list(ps_buff_end_event) buff结算信息
    add_steps  = []  %% list(ps_step_event) 步骤信息(buff结算后可能会触发新步骤)
}).

%% 步骤信息
-record(ps_step_event,{
    pos       = 0, %% integer() 站位
    skill_id  = 0, %% integer() 技能ID
    hurts     = [], %% list(ps_hurt_event) 属性变化
    buffs     = [], %% list(ps_buff_event) buff/mark附加信息
    rm_buffs  = []  %% list(ps_rm_buff_event) buff/mark清除信息
}).

%% 属性变化信息
-record(ps_hurt_event,{
    pos          = 0, %% integer() 站位
    hp           = 0, %% integer() 变化后的最终血量
    hp_shows     = [], %% list(integer()) 展示的伤害(正数为加血,负数为扣血),一个单位可能会飘多次
    angry        = 0, %% integer() 变化后的最终怒气
    hurt_effect  = 0  %% integer() 效果 const@BATTLE_HURT_EFFECT
}).

%% buff变化信息
-record(ps_buff_event,{
    pos         = 0, %% integer() 站位
    type        = 0, %% integer() 状态类型 const@BATTLE_BUFF_TYPE
    id          = 0, %% integer() 附加的buff/mark唯一ID
    cfg_id      = 0, %% integer() 附加的buff/mark配置ID
    hp          = 0, %% integer() 变化后的最终血量
    hp_show     = 0, %% integer() 附加时产生的伤害
    last_round  = 0  %% integer() 持续的回合数
}).

%% buff/mark清除信息
-record(ps_rm_buff_event,{
    pos   = 0, %% integer() 站位
    type  = 0, %% integer() 状态类型 const@BATTLE_BUFF_TYPE
    id    = 0  %% integer() 移除的buff/mark唯一ID
}).

%% buff结算信息
-record(ps_buff_end_event,{
    pos       = 0, %% integer() 站位
    buff_hps  = []  %% list(ps_buff_hp_event) buff加血/扣血
}).

%% buff加血/扣血
-record(ps_buff_hp_event,{
    hp       = 0, %% integer() 变化后的血量
    hp_show  = 0  %% integer() 展示的伤害(正数为加血,负数为扣血)
}).

%% 战斗总伤害信息
-record(ps_total_hurt,{
    pos      = 0, %% integer() 站位
    hurt     = 0, %% integer() 总伤害值
    heal     = 0, %% integer() 总治疗值
    be_hurt  = 0, %% integer() 总承伤值
    be_heal  = 0  %% integer() 总承疗值
}).

%% 奖励
-record(ps_reward,{
    item_id  = 0, %% integer() 物品ID
    num      = 0  %% integer() 数量
}).

%% 上阵信息
-record(ps_team_info,{
    pos  = 0, %% integer() 站位
    uid  = 0  %% integer() 佣兵唯一ID
}).

%% 上阵信息组
-record(ps_team_infos,{
    type  = 0, %% integer() 战斗类型 const@BATTLE_TYPE
    team  = none  %% team_info 上阵信息
}).




-endif.