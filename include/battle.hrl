% 战斗头文件
% 2018-5-21 laojiajie@gmail.com
-ifndef(__BATTLE_HRL__).
-define(__BATTLE_HRL__, true).



-include("role.hrl").
-include("battle_filter.hrl").
-include("pt_battle.hrl").
-include("data_mark.hrl").
-include("data_battle.hrl").
-include("data_buff.hrl").
-include("data_skill.hrl").
-include("data_skill_effect.hrl").
-include("data_triger_skill.hrl").
-include("data_monster.hrl").
-include("log.hrl").


-define(BATTLE_ATTRI_MAX_HP,    maxhp).     % 最大血量
-define(BATTLE_ATTRI_ATK,       attack).    % 攻击
-define(BATTLE_ATTRI_DEF,       defense).   % 防御


% 技能伤害类型
-define(SKILL_HUTR_TYPE_NONE,           0).     % 无伤害
-define(SKILL_HUTR_TYPE_ATK_HURT,       1).     % 基于攻击的伤害
-define(SKILL_HUTR_TYPE_HURT_HURT,      2).     % 基于伤害的伤害 例如对战士额外附加30%的伤害
-define(SKILL_HUTR_TYPE_ATK_HEAL,       3).     % 基于攻击的加血
-define(SKILL_HUTR_TYPE_HURT_HEAL,      4).     % 基于伤害的加血 根据之前执行的伤害效果来加血(例如克里姆的攻击加血)


-define(BATTLE_MAX_ANGRY,               200).   % 怒气上限


% 技能效果的互联类型
-define(SKILL_CIRCUIT_SERIES,		1).	% 串联
-define(SKILL_CIRCUIT_PARALLEL,		2).	% 并联


-define(BUFF_EFFECT_RELIVE,         1).                 % buff结束,原地复活
-define(BUFF_EFFECT_DIE,            2).                 % buff结束,立即死亡


% 被动技能-触发单位
-define(TRIGER_ENTITY_SELF,                 1).                 % 自身
-define(TRIGER_ENTITY_FRIEND,               2).                 % 友方
-define(TRIGER_ENTITY_ENEMY,                3).                 % 敌方


% 被动技能-或者buff-触发动作
% 1.大招； 2.被大招攻击； 3.普攻； 4.被普攻； 5.暴击； 6.被暴击； 7.闪避； 8.被闪避； 9.死亡；
-define(TRIGER_ACTION_ROUND_END,          0).                 % 回合结束
-define(TRIGER_ACTION_SKILL,              1).                 % 施放技能
-define(TRIGER_ACTION_NOMAL_ATK,          3).                 % 普攻
-define(TRIGER_ACTION_BE_ATK,             4).                 % 被攻击
-define(TRIGER_ACTION_DIE,                9).                 % 死亡
-define(TRIGER_ACTION_BE_SKILL_ATK,       2).                 % 受到技能伤害
-define(TRIGER_ACTION_HIT,                5).                 % 暴击
-define(TRIGER_ACTION_BE_HIT,             6).                 % 被暴击
-define(TRIGER_ACTION_DODGE,              7).                 % 闪避
-define(TRIGER_ACTION_BE_DODGE,           8).                 % 被闪避

% buff伤害类型
-define(SKILL_BUFF_E_TYPE_HURT,           1).                 % 伤害
-define(SKILL_BUFF_E_TYPE_HEAL,           2).                 % 治疗


% 技能使用类型 1：普攻 2：大招 3：即时触发 4：被动 5：开场技
-define(SKILL_USE_TYPE_NOAMAL,          1).
-define(SKILL_USE_TYPE_SKILL,           2).
-define(SKILL_USE_TYPE_TRIGER,          3).
-define(SKILL_USE_TYPE_ATTRI,           4).
-define(SKILL_USE_TYPE_OPEN,            5).

-record(battle_report,{
        id          = 0,        % 战报ID
        type        = 0,        % 战报类型
        out_time    = 0,        % 失效时间
        sid         = 0,        % 发起者ID
        name        = "",       % 发起者名字
        level       = 0,        % 发起者等级
        pic         = 0,        % 发起者头像
        tar_sid     = 0,        % 迎战者ID
        tar_name    = "",       % 迎战者名字
        tar_level   = 0,        % 迎战者等级
        tar_pic     = 0,        % 迎战者头像
        bin         = ""        % 战报内容
    }).


% 战斗头
-record(battle,{
        id          = 0,        % 战报ID
        sid         = 0,        % 发起者ID
        name        = "",        % 发起者名字
        level       = 0,        % 发起者等级
        pic         = 0,        % 发起者头像
        tar_sid     = 0,        % 迎战者ID
        tar_name    = "",        % 迎战者名字
        tar_level   = 0,        % 迎战者等级
        tar_pic     = 0,        % 发起者头像
        round       = 0,        % 当前轮数
        seq         = 1,        % 用于buff和印记的递增ID
        entities     = gb_trees:empty()        % 战斗单位

    }).



% 战斗单位
-record(entity,{
        type = 0,                       % 佣兵或者怪物
        cfg_id 	= 0,					% 配置ID
        pos    	= 0,        			% 位置
        level   = 0,
        star    = 0,

        active      = true,                 % false表示本轮出过手了
        is_skill    = false,                % 当前是否为大招技能
        angry_rate  = 1,                    % 怒气附加的伤害

        cur_skill   = 0,                    % 当前技能
        cur_hp	    = 0,					% 当前血量
        cur_angry   = 0,					% 当前怒气
        total_hurt  = 0,					% 总伤害
        total_heal  = 0,					% 总治疗
        skills      = [],					% 主动技能ID列表
        triger_skills = [],                 % 被动技能列表 #triger_skill
        buffs 	    = [],					% buff列表 #skill_buff
        marks       = [],                   % 印记列表 #skill_mark
        attri 	    = #attri{} 	            % 属性
    }).


-record(skill_buff,{
        pos    = 0, % 施加者位置
        id     = 0, % buffID(本场战斗唯一)
        cfg_id = 0, % buff的配置ID
        e_type = 0, % 作用类型 const@SKILL_BUFF_E_TYPE
        e_value = 0, % 作用数值(如果为0，每次伤害重新根据属性计算)
        rounds = 0  % 持续回合
    }).

-record(skill_mark,{
        pos    = 0, % 施加者位置
        id     = 0, % 印记ID(本场战斗唯一)
        cfg_id = 0, % 印记的配置ID
        rounds = 0, % 持续回合
        times  = 0  % 可触发次数
    }).

-record(triger_skill,{
        cfg_id = 0, % 被动技能配置ID
        times  = 0  % 可触发次数
    }).

% % 主动技能
% -record(skill,{
%         id     			= 0,        % id
%         pri	   			= 0,		% 优先级（0表示不释放）
%         angry_cost 		= 0,		% 需求怒气值(100)
%         dead_use        = 0,        % 死亡状态是否可释放
%         circuit			= 0,		% 技能效果的互联类型：串联和并联（并联-互不干扰;串联-前一个效果截取对象后,后面效果不再作用该对象）
%        	effects 		= [],		% 多个效果ID #skill_effect
%        	attris 			= []		% 属性
%     }).


% % 主动技能效果
% -record(skill_effect,{
%         id          = 0,    % 效果ID
% 		tar_type 	= 0,	% 作用目标类型
% 		range 		= 0,	% 作用目标位置
% 		tar_num 	= 0,	% 作用目标数量
%         re_tar      = 0,    % 是否重新选择目标
%         hurt_type   = 0,    % 伤害类型
% 		hurt_rate 	= 0,	% 伤害比率(千分比)
% 		buff_id 	= 0,	% buffID
% 		buff_rate	= 0,	% buff概率(千分比)

%         next_circuit = 0,   % 下一批技能效果的互联类型
% 		next_effects = [] 	% 基于这些目标的下一批效果ID #skill_effect
% 	}).


% % 被动技能(触发技)
% -record(triger_skill,{
%         id     		= 0,          % id
%         pos    		= none,       % 触发位置(1被攻击,)
%         group  		= 0,          % 触发分组
%         rate   		= 0,          % 概率
%         skill  		= 0,          % 主动技能ID
%         max_times 	= 0,       	  % 最高触发次数
%         require 	= none,       % 触发条件
%         req_arg 	= 0           % 条件参数
%     }).

% buff
-record(buff,{
		id 			= 0,		% id
        pos         = 0,        % 施法者位置
        hurt        = 0,        % 伤害
		last_round 	= 0,		% 持续回合数
        special     = 0,        % 特殊效果
		attris		= []		% buff改变的属性
	}).


% 额外触发的技能
-record(add_skill,{
        pos         = 0,        % 站位
        skill_id    = 0,        % 技能
        tar_pos     = 0         % 对象
    }).


-endif.

