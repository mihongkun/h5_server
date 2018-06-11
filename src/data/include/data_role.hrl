%% this file is auto maked!
-ifndef(__DATA_ROLE_HRL__).
-define(__DATA_ROLE_HRL__, true).

%% Y-英雄相关表格\英雄基础表.xlsx

-record(cfg_role,{
		id         =  0,   % 英雄ID（唯一） - 
		name       = "",   % 英雄名称 - 
		type       =  0,   % 英雄类型 - 英雄稀有度1-5 5为最稀有
		camp       =  0,   % 英雄阵营区分（1-英灵、2-人魂、3-怒火、4-神木、5-仙圣、6-魔神） - 1-英灵 2-人魂 3-怒火 4-神木 5-仙圣 6-魔神
		star       =  0,   % 英雄星级 - 
		sequence   =  0,   % 序列号 - 
		career     =  0,   % 英雄职业区分（1-战士、2-刺客、3-法师、4-游侠、5-牧师） - 1-战士 2-刺客 3-法师 4-游侠 5-牧师
		angry_init =  0,   % 战斗初始怒气 - 
		angry_max  =  0,   % 怒气上限最大值 - 
		hp         =  0,   % 初始生命值 - 
		hp_grow    =  0,   % 初始生命成长 - 
		atk        =  0,   % 初始攻击力 - 
		atk_grow   =  0,   % 初始攻击成长 - 
		def        =  0,   % 初始防御力 - 
		def_grow   =  0,   % 初始防御成长 - 
		speed      =  0,   % 初始速度 - 
		speed_grow =  0,   % 初始速度成长 - 
		skill      =  0,   % 普攻 - 填具体技能ID =英雄ID*100+1
		skill_1    =  0,   % 技能1 - 填技能ID组=英雄ID*10+1
		unlock_1   =  0,   % 技能解锁品级 - 
		skill_lv_1 = "",   % 技能等级对应星级 - 
		skill_2    =  0,   % 技能2 - 填技能ID组=英雄ID*10+1
		unlock_2   =  0,   % 技能解锁品级 - 
		skill_lv_2 = "",   % 技能等级对应星级 - 
		skill_3    =  0,   % 技能3 - 填技能ID组=英雄ID*10+1
		unlock_3   =  0,   % 技能解锁品级 - 
		skill_lv_3 = "",   % 技能等级对应星级 - 
		skill_4    =  0,   % 技能4 - 填技能ID组=英雄ID*10+1
		unlock_4   =  0,   % 技能解锁品级 - 
		skill_lv_4 = ""    % 技能等级对应星级 - 
	}).

-endif.
