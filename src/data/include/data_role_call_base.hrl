%% this file is auto maked!
-ifndef(__DATA_ROLE_CALL_BASE_HRL__).
-define(__DATA_ROLE_CALL_BASE_HRL__, true).

%% C-抽奖表\C-抽奖表.xlsx

-record(cfg_role_call_base,{
		id         =  0,   % 抽奖类型（1-普通抽奖、2-高级抽奖、3-友情抽奖） - 1-普通抽奖 2-高级抽奖 3-友情抽奖 4-能量抽奖
		item_id    =  0,   % 抽奖消耗材料id - 
		cost       =  0,   % 单抽消耗数量 - 
		ten_cost   =  0,   % 十连抽消耗数量 - 
		diamond    =  0,   % 单次钻石抽卡钻石所需 - 无法用钻石购买填“0”
		ten_diamon =  0,   % 十连抽钻石所需（无法用钻石购买填“0” - 无法用钻石购买填“0”
		wait_time  =  0,   % 单抽免费时间单位（小时） - 0表示没有免费抽取
		power      =  0,   % 单抽能量增加 - 没有则填“0”
		ten_power  =  0    % 十连能量增加 - 没有则填“0”
	}).

-endif.
