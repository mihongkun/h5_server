-ifndef(__ROLE_HRL__).
-define(__ROLE_HRL__, true).


%% 属性定义
-define(hp,		  	hp).			  	%% 血
-define(mp,			mp).				%% 魔
-define(burst,    	agi).				%% 敏捷
-define(brawn,		str).				%% 腕力
-define(intelli,	int).				%% 智力

-define(p_att,      pa).					%% 物攻
-define(p_def,      pd).					%% 物防
-define(m_att,      ma).					%% 魔攻
-define(m_def,      md).					%% 魔防
-define(block,		block).					%% 格挡
-define(sunder,		sunder).				%% 击破
-define(move_speed,		move).				%% 移动速度
-define(break,			break).				%% 打断系数
-define(resist,			un_res).			%% 异常抵抗


-record(role,{
		key           = {0,0},	%% {AccountID,WorldID}
		cfg_id 	      = 0,
		star	      = 0,
		color         = 0,
		lv     	      = 0,
		exp    	      = 0,
		pos    	      = 0,
		arena_pos     = 0,		%% 竞技场出战位置
		undertown_id  = 0,		%% 树海探索的地下城ID
		skills 	      = [],  %% [{skill_id, level, use},...]   use=1 装上 use=0 卸下
		equips 	      = [],		%% 一些寄付在佣兵身上的简单物品装备
		attris 	      = [],
		base_attris		= [], 	%% 一些属性是固定的，非计算要保存，比如升星之后将吃掉的魂器属性保存下来
		battle_power  = 0,			%% 战力
		holtel_id     = 0,		%% 宿屋id
		up_color_num  = 0		%% 进化材料

	}).
                   
-record(role_call, {
	    key = {0,0},  %% {玩家id,类型}
	    free_time = 0,  %% 下次免费时间挫
	    use_free_times = 0,  %% 使用的免费次数
	    is_first = 0,  %% 是否首抽
	    critical_times = 0, %% 必出计数
	    refresh_time = 0
    }).

%% 配置分离出来,好处:用到再取，不再占内存
-record(role_cfg,{
		cfg_id        = 0,
		main_id       = 0,
		name          = "",
		star          = 0,	  	%% 星级
		color         = 0,		%% 颜色
		state         = 0,		%% 阶段
		rank          = 0,		%% 精英
		sex           = 0,
		career        = 0,		%% 职业
		sub_career    = 0,		%% 专职
		bulletin_id   = 0,
		item_id       = 0 		%% 对应物品id
	}).

-record(role_attri_cfg,{
		brawn		= 0,
		intelli     = 0,
		burst		= 0,
		hp			= 0,
		mp          = 0,

		brawn_grow  = 0,
		intelli_grow= 0,
		burst_grow  = 0,
		hp_grow 	= 0,
		mp_grow     = 0,

		p_att       = 0,
		p_def       = 0,
		m_att       = 0,
		m_def       = 0,
		jipo        = 0,
		gedang      = 0,
		move_speed  = 0,
		break       = 0,
		resistance  = 0
	}).



-record(role_call_main,{
		cost_type 	    = diamond,
		cost_amount		= 0,
		free_time_init  = 0,
		free_time_grap  = 0,
		free_times      = 0,
		point_got       = 0,
		call_num        = 0
	}).


-record(role_call_weight,{
		award_type 		  	= 0,
		award_id 		  	= 0,
		award_num			= 0,
		weight 				= 0,
		group_id            = 0,
		first_appear        = 0,
		critical_appear        = 0
	}).

-record(role_upstar_cfg,{
		role_id 	= 0,
		star 		= 0,
		stuffs		= [],
		
		brawn_grow  = 0,
		intelli_grow= 0,
		burst_grow  = 0,
		hp_grow 	= 0

	}).

-record(role_exp,{
		up_exp 		= 0,
		eat_exp 	= 0
	}).

%% 佣兵训练
-record(role_train, {
		key = {0, 0},			%% {账号ID，训练槽编号}
		world_id = 0,			%% 训练的佣兵
		state = 0,				%% 状态 0-未开通 1-未激活 2-已激活
		tot_exp = 0,			%% 累计经验
		begin_time = 0,			%% 开始训练时间
		last_begin_time = 0		%% 最后一次开始训练计时时间
	}).

%% 佣兵训练配置信息
-record(role_train_cfg, {
		slot_id = 0,
		unlock_vip_level = 0,
		diamond = 0
	}).

%% 佣兵训练药水数据
-record(role_train_potion, {
		key = {0, 0},			%% {账号ID, 药水ID}
		remain_num = 0,			%% 剩余数量
		tot_buy_num = 0,		%% 累计购买数量
		last_buy_time = 0		%% 最后一次购买时间
	}).


%% 佣兵训练药水配置表
-record(role_train_potion_cfg, {
		potion_id = 0,			%% 药水ID
		add_exp = 0,			%% 增加的经验
		unlock_level = 0,		%% 解锁等级
		diamond = 0,			%% 消耗钻石
		buy_max_times = 0		%% 1天购买最大数量
	}).

%% 佣兵潜力数据表
-record(role_potential, {
		key = {0,0,0}, 	%% {account_id, world_id, type} 帐号 佣兵 部位
		level = 0				%% 等级
}).

-endif.