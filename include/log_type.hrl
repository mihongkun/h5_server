-ifndef(__LOG_TYPE_HRL__).
-define(__LOG_TYPE_HRL__, true).

% 基本操作
-define(OP_TYPE_ACCOUNT_INIT,			1).			%% 账号初始化

% 佣兵操作
-define(OP_TYPE_CALL_NORMAL,			101).		%% 普通召唤
-define(OP_TYPE_CALL_SUPER,				102).		%% 高级召唤
-define(OP_TYPE_CALL_FRIEND,			103).		%% 友情召唤
-define(OP_TYPE_CALL_POWER,				104).		%% 能量召唤
-define(OP_TYPE_ROLE_UPLV,				105).		%% 英雄升级
-define(OP_TYPE_ROLE_UPQUALITY,			106).		%% 英雄进化
-define(OP_TYPE_ROLE_UPSTAR,			107).		%% 英雄升星
-define(OP_TYPE_ROLE_COMPILE,			108).		%% 英雄合成
-define(OP_TYPE_ROLE_BUY_GRID,			109).		%% 格子购买

% 物品操作
-define(OP_TYPE_ITEM_SELL,				201).		%% 出售物品
-define(OP_TYPE_ITEM_CHIP_COMPOSE,		202).		%% 碎片合成
-define(OP_TYPE_ITEM_EQUIPMENT_COMPOSE, 203).		%% 装备合成
-define(OP_TYPE_ITEM_REWARD, 			204).		%% 奖励获得

-define(OP_TYPE_MARKET_REFRESH,			800).		%% 市场刷新
-define(OP_TYPE_MARKET_PROPS,			801).		%% 市场购买

-define(OP_TYPE_SPORTGOLD_GOLD,			1101).		%% 点金获得金币



-define(OP_TYPE_GM,						99999).		%% gm操作


-endif.
