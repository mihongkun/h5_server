% 战斗播报头文件
% 2018-5-21 laojiajie@gmail.com
-ifndef(__BATTLE_FILTER_HRL__).
-define(__BATTLE_FILTER_HRL__, true).

% 阵营
-define(BATTLE_FILTER_STAND, 		1001).	% 顺位攻击
-define(BATTLE_FILTER_SELF, 		1002).	% 自己
-define(BATTLE_FILTER_FRIEND, 		1003).	% 队友
-define(BATTLE_FILTER_OWN,		 	1004).	% 己方
-define(BATTLE_FILTER_ENEMY, 		1005).	% 敌方
-define(BATTLE_FILTER_ATKER, 		1006).	% 攻击者

% 职业
-define(BATTLE_FILTER_CAREER_1, 		3001).	% 战士
-define(BATTLE_FILTER_CAREER_2, 		3002).	% 法师
-define(BATTLE_FILTER_CAREER_3, 		3003).	% 牧师
-define(BATTLE_FILTER_CAREER_4, 		3004).	% 刺客
-define(BATTLE_FILTER_CAREER_5, 		3005).	% 游侠


-define(BATTLE_FILTER_POS_SINGLE, 	2001).	% 单体
-define(BATTLE_FILTER_POS_ALL, 		2002).	% 全体
-define(BATTLE_FILTER_POS_FONT, 	2003).	% 前排
-define(BATTLE_FILTER_POS_BACK, 	2004).	% 后排
-define(BATTLE_FILTER_POS_1, 		2005).	% 1号位
-define(BATTLE_FILTER_POS_2, 		2006).	% 2号位
-define(BATTLE_FILTER_POS_3, 		2007).	% 3号位
-define(BATTLE_FILTER_POS_4, 		2008).	% 4号位
-define(BATTLE_FILTER_POS_5, 		2009).	% 5号位
-define(BATTLE_FILTER_POS_6, 		2010).	% 6号位

% 属性
-define(BATTLE_FILTER_ATTRI_ATK_MAX, 		4001).	% 攻击最高
-define(BATTLE_FILTER_ATTRI_ATK_MIN, 		4002).	% 攻击最低
-define(BATTLE_FILTER_ATTRI_DEF_MAX, 		4003).	% 护甲最高
-define(BATTLE_FILTER_ATTRI_DEF_MIN, 		4004).	% 护甲最低
-define(BATTLE_FILTER_ATTRI_SPEED_MAX, 		4005).	% 速度最高
-define(BATTLE_FILTER_ATTRI_SPEED_MIN, 		4006).	% 速度最低
-define(BATTLE_FILTER_ATTRI_HP_MAX, 		4007).	% 生命最高
-define(BATTLE_FILTER_ATTRI_HP_MIN, 		4008).	% 生命最低
-define(BATTLE_FILTER_ATTRI_HP_CUR_MAX, 	4009).	% 当前生命最高
-define(BATTLE_FILTER_ATTRI_HP_CUR_MIN, 	4010).	% 当前生命最低
-define(BATTLE_FILTER_ATTRI_HP_PER_MAX, 	4011).	% 当前生命%最高
-define(BATTLE_FILTER_ATTRI_HP_PER_MIN, 	4012).	% 当前生命%最低


% 状态
-define(BATTLE_FILTER_STATUS_STUN, 			5001).	% 眩晕
-define(BATTLE_FILTER_STATUS_FREEZE, 		5002).	% 冰冻
-define(BATTLE_FILTER_STATUS_SLIENT, 		5003).	% 沉默
-define(BATTLE_FILTER_STATUS_PETRIFY, 		5004).	% 石化
-define(BATTLE_FILTER_STATUS_POISON, 		5005).	% 中毒
-define(BATTLE_FILTER_STATUS_BLEED, 		5006).	% 流血
-define(BATTLE_FILTER_STATUS_BURN,	 		5007).	% 燃烧
-define(BATTLE_FILTER_STATUS_WEAK,	 		5008).	% 虚弱
-define(BATTLE_FILTER_STATUS_INJURY,	 	5009).	% 重伤
-define(BATTLE_FILTER_STATUS_DEAD,	 		5010).	% 死亡

% 目标数量
-define(BATTLE_FILTER_NUM_1, 				6001).	% 随机1目标
-define(BATTLE_FILTER_NUM_2, 				6002).	% 随机2目标
-define(BATTLE_FILTER_NUM_3, 				6003).	% 随机3目标
-define(BATTLE_FILTER_NUM_4, 				6004).	% 随机4目标
-define(BATTLE_FILTER_NUM_5, 				6005).	% 随机5目标



-define(BATTLE_POS_FONT,				[1,2,7,8]).	% 前排位置

-define(BATTLE_POS_BACK,				[3,4,5,6,9,10,11,12]).	% 后排位置



-endif.


