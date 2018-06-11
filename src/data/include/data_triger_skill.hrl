%% this file is auto maked!
-ifndef(__DATA_TRIGER_SKILL_HRL__).
-define(__DATA_TRIGER_SKILL_HRL__, true).

%% Z-战斗\即时技能-Req.xlsx

-record(cfg_triger_skill,{
		id            =  0,   % 触发ID - 技能ID*10+序列号
		desc          = "",   % 对应技能描述 - 描述
		tar           =  0,   % 触发条件 - 0、无条件 1、自身； 2、敌方； 3、友方。
		pos           = "",   % 触发行为 - 0.不以行为触发 1.大招； 2.被大招攻击； 3.普攻； 4.被普攻； 5.暴击； 6.被暴击； 7.闪避； 8.被闪避； 9.死亡； 
		rate          =  0,   % 触发概率 - 万分数
		skill         = "",   % 触发技能 - 技能ID
		max_times     =  0,   % 触发次数 - 触发次数上限 0表示无限
		need_type     =  0,   % 特殊前置条件 - 0. 无条件 1. 血量万分比高于 2. 血量万分比低于
		need_value    =  0,   % 条件值 - 
		attri_type    = "",   % 跟攻击者对比的属性条件 - 看属性表
		attri_cp_type =  0    % 属性对比类型 - 1. 高于 2. 低于
	}).

-endif.
