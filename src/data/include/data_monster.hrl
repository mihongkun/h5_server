%% this file is auto maked!
-ifndef(__DATA_MONSTER_HRL__).
-define(__DATA_MONSTER_HRL__, true).

%% G-怪物相关配置表\怪物表.xlsx

-record(cfg_monster,{
		id        =  0,   % 怪物ID - 
		name      = "",   % 怪物名称 - 
		model     = "",   % 怪物模型 - 模型资源
		icon      =  0,   % 怪物ICON - 
		lv        = "",   % 等级 - 
		star      =  0,   % 星级 - 
		hp        =  0,   % 血量 - 
		atk       =  0,   % 攻击 - 
		def       =  0,   % 防御 - 
		speed     =  0,   % 速度 - 
		angry     =  0,   % 能量 - 初始能量
		skill_dmg =  0,   % 技能伤害 - 万分数
		hit       =  0,   % 命中 - 万分数
		dodge     =  0,   % 闪避 - 万分数
		crit      =  0,   % 暴击 - 万分数
		crit_dmg  =  0,   % 暴击伤害 - 万分数
		holy_dmg  =  0,   % 真实伤害 - 万分数
		arp       =  0,   % 破甲 - 万分数
		bs        =  0,   % 生命吸取 - 万分数
		hurt_imm  =  0,   % 减伤率 - 万分数
		stun_imm  =  0,   % 免控率 - 万分数
		skill1    =  0,   % 怪物技能1 - 技能表ID(普攻）
		skill2    =  0,   % 怪物技能2 - 技能表ID
		skill3    =  0,   % 怪物技能3 - 技能表ID
		skill4    =  0,   % 怪物技能4 - 技能表ID
		skill5    =  0    % 怪物技能4 - 技能表ID
	}).

-endif.
