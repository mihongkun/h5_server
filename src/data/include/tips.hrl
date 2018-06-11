%% this file is auto maked!
-ifndef(__TIPS_HRL__).
-define(__TIPS_HRL__, true).

%% K-客户端提示表\客户端提示表.xlsx


-define(TIPS_ACCOUNT_RECONNECT_FAIL, 101). % 101 - 重连失败
-define(TIPS_ACCOUNT_FORBID, 102).         % 102 - 你已经被封号
-define(TIPS_NAME_HAS_ERROR_WORLD, 103).   % 103 - 名字含有敏感词

-define(TIPS_NOT_ENOUGH_GOLD, 301).        % 301 - 金币不足
-define(TIPS_NOT_ENOUGH_DIAMOND, 302).     % 302 - 钻石不足
-define(TIPS_NOT_ENOUGH_SOUL, 303).        % 303 - 英魂不足
-define(TIPS_NOT_ENOUGH_WATER, 304).       % 304 - 水滴不足
-define(TIPS_NOT_ENOUGH_STAMEN, 305).      % 305 - 体力不足
-define(TIPS_NOT_ENOUGH_NARC, 306).        % 306 - 水仙不足

-define(TIPS_NOT_ENOUGH_ITEM, 501).        % 501 - %s不足
-define(TIPS_CHIP_LACK, 502).              % 502 - 碎片数量不足
-define(TIPS_CAN_NOT_SELL, 503).           % 503 - 此物品不能出售
-define(TIPS_COMPOSE_LACK, 504).           % 504 - 合成材料不足

-define(TIPS_ROLE_GIRD_NOT_ENOUGH, 601).   % 601 - 英雄格子数不足

-define(TIPS_PUB_BATTLED, 701).            % 701 - 这个英雄已经上阵
-define(TIPS_PUB_HERO_FULL, 702).          % 702 - 任务所需英雄数量已满
-define(TIPS_PUB_BASE_LACK, 703).          % 703 - 基础酒馆任务卷不足
-define(TIPS_PUB_ADV_LACK, 704).           % 704 - 高级酒馆任务卷不足
-define(TIPS_PUB_HERO_LACK, 705).          % 705 - 符合任务条件的英雄数量不足
-define(TIPS_PUB_CON_LACK, 706).           % 706 - 开始条件不足
-define(TIPS_PUB_LOCK, 707).               % 707 - 任务锁定
-define(TIPS_PUB_UNLOCK, 708).             % 708 - 任务解锁
-define(TIPS_PUB_STARTED, 709).            % 709 - 任务已经开始不能解锁


-endif.
