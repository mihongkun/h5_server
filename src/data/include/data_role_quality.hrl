%% this file is auto maked!
-ifndef(__DATA_ROLE_QUALITY_HRL__).
-define(__DATA_ROLE_QUALITY_HRL__, true).

%% Y-英雄相关表格\英雄进化等级表.xlsx

-record(cfg_role_quality,{
		lv         =  0,   % 品阶等级 - 
		hp_rate    =  0,   % 生命加成 - 
		atk_rate   =  0,   % 攻击加成 - 
		def_rate   =  0,   % 护甲加成 - 
		speed_rate =  0,   % 速度加成 - 
		cost_jjs   =  0,   % 进化消耗进阶石 - 
		cost_gold  =  0    % 进化消耗金币 - 
	}).

-endif.
