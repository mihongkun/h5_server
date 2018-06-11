%% this file is auto maked!
-ifndef(__DATA_WISH_BASE_HRL__).
-define(__DATA_WISH_BASE_HRL__, true).

%% X-许愿池相关表格\许愿池基础表.xlsx

-record(cfg_wish_base,{
		type          =  0,   % 许愿池类型 - 1-普通 2-高级
		single        =  0,   % 单抽消耗道具 - 
		ten_times     =  0,   % 十连消耗道具 - 
		vip_limit     =  0,   % 功能限制 - 十抽功能VIP限制填写对应VIP等级
		reset         =  0,   % 消耗钻石 - 重置奖池消耗钻石数量
		produce       =  0,   % 产出幸运币 - 填0则不产出
		reset_time    =  0,   % 重置时间 - 免费重置时间（小时）
		purchase      =  0,   % 购买钻石 - 购买许愿币消耗钻石单个
		force_reset   =  0,   % 强制刷新 - 强制刷新重置时间（小时）
		level         =  0,   % 等级开启 - 战队等级
		vip           =  0,   % VIP等级开启 - 
		lucky_coin_id =  0,   % 幸运币 - 
		wish_coin_id  =  0    % 许愿币 - 
	}).

-endif.
