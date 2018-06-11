%% this file is auto maked!
-ifndef(__DATA_ITEM_HRL__).
-define(__DATA_ITEM_HRL__, true).

%% D-道具表\道具表.xlsx

-record(cfg_item,{
		id           =  0,   % 物品ID - 
		name         = "",   % 物品名称 - 最大九个汉字
		type         =  0,   % 物品类型 主要用于“背包”分类 - 0-货币 1-装备 2-材料 3-碎片 4-神器
		chip_type    =  0,   % 碎片分类 - 1-英雄碎片 2-皮肤碎片 3-神器碎片 不是碎片默认不填
		quality      =  0,   % 物品品阶 - 
		seq          =  0,   % 序列号 - 
		type_des     = "",   % 物品类型说明 - 
		des          = "",   % 物品描述信息 - 
		star         =  0,   % 星级 - 
		color        =  0,   % 物品名字天生显示的颜色 - 1-白色 2-绿色 3-蓝色 4-紫色 5-橙色 6-红色
		can_sell     =  0,   % 物品是否可出售 - 1-可以 0-不可以
		price        =  0,   % 物品出售价值量对应资源金币 - 不显示价值量则填写0
		sell_confirm =  0,   % 物品出售时是否弹出批量出售界面（1-需要、0-不需要） - 1-需要 0-不需要
		icon         =  0,   % 物品图标ID - 没有则填0
		pose         =  0,   % 物品特效 - 没有则填0
		call_tips    =  0,   % TIPS召唤按钮显示 - 0-不能 1-能
		call_num     =  0,   % 召唤要求数量 - 
		eff_type     =  0,   % 召唤时对应的效果ID - 
		tips_show    =  0,   % TIPS详细按钮显示 - 0-不需要 1-需要
		froms        = "",   % 获取途径支持多段配置格式（系统ID、系统ID………)(1、2、3、4） - [1.2.3.4.5]
		handbook     =  0    % 英雄查看详细（对应图鉴ID） - 
	}).

-endif.
