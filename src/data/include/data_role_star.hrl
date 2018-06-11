%% this file is auto maked!
-ifndef(__DATA_ROLE_STAR_HRL__).
-define(__DATA_ROLE_STAR_HRL__, true).

%% Y-英雄相关表格\英雄星级表.xlsx

-record(cfg_role_star,{
		star         =  0,   % 英雄星级 - 
		grow_rate    =  0,   % 成长值加成 - 用于升星时提升英雄的生命、攻击、速度成长
		attri_rate   =  0,   % 属性加成比 - 用于升星时对英雄生命、攻击进行加成
		need_quality =  0,   % 品阶要求 - 
		lv_max       =  0,   % 英雄星级等级上限 - 
		icon1        =  0,   % 1-5星icon资源 - 不同星级段调用不同步同ICON资源ID（没有的填“0”）
		icon2        =  0,   % 6-9星icon资源 - 
		icon3        =  0    % 10星icon资源 - 
	}).

-endif.
