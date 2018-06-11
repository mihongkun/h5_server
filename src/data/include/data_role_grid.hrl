%% this file is auto maked!
-ifndef(__DATA_ROLE_GRID_HRL__).
-define(__DATA_ROLE_GRID_HRL__, true).

%% Y-英雄列表开启表\英雄列表扩充表.xlsx

-record(cfg_role_grid,{
		id           =  0,   % id - 
		grid         =  0,   % 英雄列表初始携带数量 - 
		grid_max     =  0,   % 英雄列表携带数量上限 - 
		buy_add      =  0,   % 英雄列表单次购买携带扩充数量 - 
		buy_cost     = "",   % 前n次购买的 钻石花费 - 
		buy_cost_add =  0,   % n次之后 每次购买增加 的钻石 - 
		buy_cost_max =  0    % 所需钻石最大上限 - 
	}).

-endif.
