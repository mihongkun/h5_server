%% this file is auto maked!
-ifndef(__DATA_SKILL_HRL__).
-define(__DATA_SKILL_HRL__, true).

%% Z-战斗\技能表-Skill.xlsx

-record(cfg_skill,{
		id           =  0,   % 技能ID - 
		name         = "",   % 技能名 - 
		desc         = "",   %  - 描述
		skill_lv     =  0,   % 技能等级 - 
		pri          =  0,   % 优先级 - 大招3，取代普攻2，普攻1，其他的均为0
		angry_const  =  0,   % 能量消耗 - 需求怒气值
		type         =  0,   % 技能类型 - 1：普攻； 2：大招； 3：普通技能1； 4：普通技能2； 5：普通技能3； 6：特殊技能
		use_type     =  0,   % 使用类型 - 1：普攻 2：大招 3：即时触发 4：被动 5：开场技
		icon         = "",   % 技能图标 - 资源名
		action_id    = "",   % 技能动作资源 - 资源名
		dead_use     =  0,   % 死亡是否能够使用 - 1，可以 2.不可以
		atk_angry    =  0,   % 攻击回复能量 - 使用技能自身回复能量
		def_angry    =  0,   % 命中目标能量 - 技能命中目标后目标获得能量
		near_far     =  0,   % 近战远战 - 1：近战 2：远程 0：无效字段
		range        =  0,   % 是否为范围伤害 - 1：是 2：不是 0：无效字段
		can_dodge    =  0,   % 是否可闪避 - 1：是 2：否 0：无效字段
		attri        = "",   % 属性 - 调用属性表ID，被动增加属性专用
		triger_skill = "",   % 触发效果 - 使用类型为3时使用
		circuit      =  0,   % 技能效果 - 技能效果的互联： 1.串联-前一个效果截取对象后,后面效果不再作用该对象 2.并联-互不影响
		effects      = ""    % 效果ID - 调取技能效果表
	}).

-endif.
