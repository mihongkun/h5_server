-ifndef(__ATTRI_HRL__).
-define(__ATTRI_HRL__, true).

%% 属性
-record(attri,{
		%% 一级属性
		atk			= 0,	%% 攻击
		def 		= 0,	%% 防御
		hp  		= 0,	%% 血量
		
		atk_per		= 0,	%% 攻击万分比
		def_per		= 0,	%% 防御万分比
		hp_per  	= 0,	%% 血量万分比

		speed 		= 0,	%% 速度
		angry 		= 0,	%% 初始怒气
		%% 二级属性
		skill_hurt	= 0,	%% 技能伤害（万分比）
		hit			= 0,	%% 命中
		dodge		= 0,	%% 闪避
		crit 		= 0,	%% 暴击率
		crit_hurt 	= 0,	%% 暴击伤害（万分比）
		arp 		= 0,	%% 破甲
		bs 			= 0,	%% 吸血
		stun_imm	= 0,	%% 免控率
		hurt_imm 	= 0,	%% 免伤率
		holy_hurt 	= 0, 	%% 神圣伤害
		%% 职业对抗属性
		career_z	= 0,	%% 对战士额外伤害
		career_f	= 0,	%% 对法师额外伤害
		career_m	= 0,	%% 对牧师额外伤害
		career_y	= 0,	%% 对游侠额外伤害
		career_c	= 0 	%% 对刺客额外伤害
	}).


-endif.