%% this file is auto maked!
-ifndef(__DATA_BUFF_HRL__).
-define(__DATA_BUFF_HRL__, true).

%% Z-战斗\Buff表-Buff.xlsx

-record(cfg_buff,{
		id              =  0,   % buffID - 技能ID*10+序列号
		type            =  0,   % buff类型 - 1：buff 2：debuff 3：状态 4：被动
		desc            = "",   % 描述 - 描述
		attri_type      = none,   % 属性更改 - 查看属性表
		attri_v_type    =  0,   % 属性值类型 - 1.万分数 2.具体值
		attri_value     =  0,   % 修正值 - 
		effect_type     =  0,   % 效果类型 - 效果类型 1. 加深收到伤害 2. 加深附加目标的伤害 3. 加深附加目标的技能伤害 4. 持续伤害 5. 持续治疗-基于攻击 6. 持续治疗-基于伤害
		icon            = "",   % buff图标 - 资源名
		effect_atk_rate =  0,   % 效果攻击系数 - 单位：1/10000
		effect_tar      = "",   % 效果属性目标 - 1.BUFF来源者 2.BUFF持有者
		effect_attri    = none,   % 效果属性转化 - 属性名
		effect_rate     =  0,   % 效果折算比例 - 折算属性比例 万分数
		effect_value    =  0,   % 附加数值 - 额外附加值
		status          = none,   % 状态 - 填写状态名
		status_effect   = "",   % 状态特效 - 资源名
		cover           =  0,   % 可否叠加 - 1.可叠加 2.不可叠加
		cover_times     =  0,   % 叠加次数 - 
		add_jump        =  0    % 附加时跳伤害 - 附加的时候是否触发一次伤害/治疗 0.不跳 1.跳一下
	}).

-endif.
