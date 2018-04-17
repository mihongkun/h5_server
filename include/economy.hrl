-ifndef(__ECONOMY_HRL__).
-define(__ECONOMY_HRL__, true).

-record(economy, {
    account_id = 0,  %% 账号ID
    prosperity = 0,  %% 繁荣度
    gold = 0,  %% 金币
    diamond = 0,
    power = 0,
    power_time = 0,
    achieve_point = 0,
    honor_point = 0,
    donation = 0,  %% 公会当前贡献度
    max_donation = 0, %% 公会最大贡献度
	wood = 0,
    mine = 0,
    reward_gold = 0,   %% 悬赏币
    reward_token = 0,   %% 悬赏令牌
    trial_point = 0
    }).

-endif.