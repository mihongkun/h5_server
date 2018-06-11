%% this file is auto maked!
-ifndef(__DATA_ATTRI_HRL__).
-define(__DATA_ATTRI_HRL__, true).

%% Z-战斗\属性表-Ability.xlsx

-record(cfg_attri,{
		key           = none,   % 资源名 - 
		name          = "",   % 名称 - 
		belong        =  0,   % 所属 - 1：英雄； 2：主角。
		type          =  0,   % 属性类型 - 1：主属性； 2：扩展属性； 3：额外属性； 4：临时属性。
		v_type        =  0,   % 数值类型 - 1：int； 2：万分比
		default       =  0,   % 缺省值 - 
		max           =  0,   % 最大值 - 进行伤害计算或战力计算时超过该数值则按该数值计算，为0时不做限制
		sword         =  0,   % 战力参数 - 配合战力公式进行战力计算用的，为0时该项属性不计算战力
		power_formula = "",   % 战力公式 - 
		hurt_formula  = "",   % 计算公式 - 
		des           = ""    % 描述 - 
	}).

-endif.
