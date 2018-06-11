%% this file is auto maked!
-ifndef(__DATA_ROLE_COMPOSE_HRL__).
-define(__DATA_ROLE_COMPOSE_HRL__, true).

%% Y-英雄相关表格\英雄合成表（创造法阵）.xlsx

-record(cfg_role_compose,{
		id           =  0,   % 合成ID - 
		type         =  0,   % 合成归属ID - 1-创造法阵 2-英雄觉醒
		tar_id       =  0,   % 合成英雄ID - 
		tar_star     =  0,   % 合成英雄星级 - 
		role_id1     =  0,   % 英雄材料1 - 
		role_star1   =  0,   % 材料1数量 - 
		role_id2     =  0,   % 材料2 - 
		role_star2   =  0,   % 所需英雄本体2数量 - 
		role_id3     =  0,   % 材料3 - 
		role_star3   =  0,   % 所需英雄本体2数量 - 
		camp         =  0,   % 所需英雄阵营（1-幽冥、2-堡垒、3-深渊、4-森林、5-暗影、6-光明） - 0-不限阵营 1-幽冥 2-堡垒 3-深渊 4-森林 5-暗影 6-光明
		camp_star    =  0,   % 所需英雄星级 - 
		camp_num     =  0,   % 所需英雄数量 - 
		need_quality =  0    % 觉醒满足条件品阶6 - 0-不判断 1-判断
	}).

-endif.
