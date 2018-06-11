%% this file is auto maked!
-ifndef(__DATA_SKILL_EFFECT_HRL__).
-define(__DATA_SKILL_EFFECT_HRL__, true).

%% Z-战斗\技能效果表-Effects.xlsx

-record(cfg_skill_effect,{
		id              =  0,   % 效果ID - 技能ID*10+序列号
		desc            = "",   % 描述 - 描述
		filters         = "",   % 目标选择 - 去目标选择表中调用
		re_tar          =  0,   % 是否重新选目标 - 是否重选目标 0-否，会在上一个效果的目标集合里选取 1-是，会全局重新选取
		effect_type     =  0,   % 效果类型 - 1. 攻击伤害 2. 基于伤害的伤害（例如对战士额外附加30%的伤害） 3. 攻击治疗 4. 伤害治疗(根据之前执行的伤害效果)
		effect_atk_rate =  0,   % 攻击系数 - 单位：1/10000
		effect_tar      = "",   % 属性目标 - 1.自身 2.目标
		effect_attri    = none,   % 属性转化 - 属性名
		effect_per      =  0,   % 折算比例 - 折算属性比例，万分数
		effect_value    =  0,   % 附加数值 - 额外附加值
		buff_id         = "",   % buff - buffID，调取buff表
		buff_rate       =  0,   % buff概率 - 万分数
		buff_round      =  0,   % buff回合数 - 大回合 0为无限回合
		mark_id         = "",   % 印记ID - 印记ID，调取印记表
		mark_rate       =  0,   % 印记概率 - 万分数
		mark_round      =  0,   % 印记回合数 - 大回合
		next_circuit    =  0,   % 触发技能类型 - 技能效果的互联： 1.串联-前一个效果截取对象后,后面效果不再作用该对象 2.并联-互不影响
		next_effects    = ""    % 触发效果 - 基于当前目标的下一批效果ID
	}).

-endif.
