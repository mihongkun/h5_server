%% this file is auto maked!
-ifndef(__DATA_MARK_HRL__).
-define(__DATA_MARK_HRL__, true).

%% Z-战斗\印记表.xlsx

-record(cfg_mark,{
		id               =  0,   % 印记ID - 
		group            =  0,   % 印记组ID - 同一组共享上限
		name             = "",   % 印记名 - 
		act_type         =  0,   % 印记触发 - 1. 被攻击 2. 攻击 3. 回合结束 4. 印记移除时 5. 被暴击 6.被指定技能攻击
		act_skill        = "",   % 触发技能组 - 
		act_tar          =  0,   % 作用目标 - 1. 自身 2. 施加者 3. 攻击者
		effect_times     =  0,   % 作用次数 - 0. 无限
		effect_type      =  0,   % 效果 - 1. 扣血 2. 加血 3. 加能量 4.伤害增加（值为万分数）
		effect_value     =  0,   % 效果固定值 - 
		effect_value_max =  0,   % 效果叠加上限 - 
		effect_tar       =  0,   % 效果值属性基于的目标 - 1. 自身 2. 施加者 3. 攻击者
		effect_attri     = none,   % 效果值基于的属性类型 - 看属性表
		effect_per       =  0,   % 效果值基于的属性万分比 - 
		effect_per_max   =  0    % 效果叠加上限 - 
	}).

-endif.
