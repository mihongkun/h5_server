-ifndef(__ROLE_HRL__).
-define(__ROLE_HRL__, true).

-include("common.hrl").
-include("pt_role.hrl").
-include("log_role.hrl").


-define(ROLE_ATTRI_DENO, 10000). % 比率属性的分母

-define(ROLE_SUPER_CALL_ADD_POWER,	mod_global:get_value(2)).	% 高抽增加能量
-define(ROLE_POWER_CALL_NEED,	mod_global:get_value(3)).	% 能量抽卡所需能量


-define(ROLE_ATK,		atk). 			% 攻击
-define(ROLE_DEF,		def). 			% 防御
-define(ROLE_HP,		hp).  			% 血量
-define(ROLE_ANGRY,		angry).	 		% 初始怒气
-define(ROLE_SPEED,		speed).  		% 速度
-define(ROLE_SKILL_DMG,	skill_dmg). 	% 技能伤害率
-define(ROLE_HIT,		hit). 			% 命中
-define(ROLE_DODGE,		dodge). 		% 闪避
-define(ROLE_CRIT,		crit). 			% 暴击
-define(ROLE_CRIT_DMG,	crit_dmg). 		% 暴击伤害
-define(ROLE_HOLY_DMG,	holy_dmg). 		% 神圣伤害
-define(ROLE_ARP,		arp). 			% 破甲
-define(ROLE_BS,		bs). 			% 吸血效果
-define(ROLE_HURT_IMM,	hurt_imm). 		% 免伤率
-define(ROLE_STUN_IMM,	stun_imm). 		% 免控率
-define(ROLE_HP_PER,	hp_per). 		% 血量万分比
-define(ROLE_ATK_PER,	atk_per). 		% 攻击万分比
-define(ROLE_DEF_PER,	def_per). 		% 防御万分比
-define(ROLE_CUR_HP,	cur_hp). 		% 当前血量
-define(ROLE_CARRER_Z,	career_z). 		% 对战士额外伤害
-define(ROLE_CARRER_F,	career_f). 		% 对法师额外伤害
-define(ROLE_CARRER_M,	career_m). 		% 对牧师额外伤害
-define(ROLE_CARRER_Y,	career_y). 		% 对游侠额外伤害
-define(ROLE_CARRER_C,	career_c). 		% 对刺客额外伤害


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


-record(role,{
		key           	= {0,0},	%% {Sid,WorldID}
		cfg_id 	      	= 0,		%% 配置id
		star	      	= 0,		%% 星级
		lv     	      	= 0,		%% 等级
		quality 		= 0,		%% 品阶
		xtal 	  		= 0,		%% 水晶id
		xtal_attris 	= [],		%% 水晶属性
		power  		  	= 0,		%% 战力
		equips		  	= [],		%% 装备
		skills			= [],		%% 技能ID列表
		dirty			= false,	%% true为需要重新计算属性
		attri 		  	= #attri{}	%% 总属性
	}).
                   
-record(role_else, {
	    sid = 0,  			%% 玩家id
	    free_time_1 = 0,  	%% 下次免费时间挫
	    free_time_2 = 0,  	%% 下次免费时间挫
	    free_time_3 = 0,  	%% 下次免费时间挫
	    free_time_4 = 0,  	%% 下次免费时间挫
	    buy_grid_times = 0	%% 格子的购买次数
    }).



-endif.



