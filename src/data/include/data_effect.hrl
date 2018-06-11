%% this file is auto maked!
-ifndef(__DATA_EFFECT_HRL__).
-define(__DATA_EFFECT_HRL__, true).

%% X-效果表\效果表.xlsx

-record(cfg_effect,{
		id          =  0,   % 效果ID - 
		effect_type =  0,   % 效果类型 - 1-英雄 2-神器
		hero_id     =  0,   % 英雄ID - 
		star        =  0,   % 英雄星级 - 
		sqid        =  0,   % 神器ID - 
		herosjid    =  0,   % 英雄池随机ID - 
		sqsjid      =  0    % 神器随机ID - 
	}).

-endif.
