-ifndef(__RECHARGE_HRL__).
-define(__RECHARGE_HRL__, true).

-record(recharge,{
				inner_recharge_id       = <<>>,
				outer_recharge_id       = <<>>,
				anysdk_recharge_id      = <<>>,
				account_id              = 0,
				platform_id             = 0,
				server_id               = 0,
				suid                    = <<>>,
				ori_recharge_money_type = <<>>,
				ori_recharge_money      = 0,
				recharge_money          = 0,
				rec_recharge_gold       = 0,
				ori_recharge_gold       = 0,
				recharge_item           = <<>>,
				recharge_channel        = <<>>,
				is_inner_recharge       = 0,
				recharge_status         = 0,
				recharge_message        = <<>>,
				recharge_ext_info       = <<>>,
				recharge_time           = 0
				
	}).

-record(recharge_info,{
				inner_recharge_id       = 0,
				account_id              = 0,
				platform_id             = 0,
				server_id               = 0,
				suid                    = <<>>,
				apply_money				= 0,
				recharge_money          = 0,
				recharge_gold           = 0,
				recharge_item           = <<>>,
				deal_status             = 0,
				deal_time               = 0,
				happend_time            = 0
	}).

-endif.