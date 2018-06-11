-module(mod_role_call).
-include("role.hrl").
-include("economy.hrl").
-include("data_role_call.hrl").
-include("data_role_call_base.hrl").

-compile(export_all).


%% 召唤佣兵
call_role(Sid,Type,IsUseDiamond,Times) when Times == 1 orelse Times == 10 ->
	Pool = get_role_pool(Type),
	{CostItemID,CostItemNum,Diamond,AddPower} = get_cost(Type,Times),
	OpType = get_op_type(Type),
	try
		if 
			IsUseDiamond == ?CALL_USE_DIAMOND_NO ->
				?TRY(mod_item:check(Sid,CostItemID,CostItemNum)),
				?TRY(mod_role:check_grid_enough(Sid,Times)),
				mod_item:use(Sid,CostItemID,CostItemNum,OpType);
			IsUseDiamond == ?CALL_USE_DIAMOND_YES andalso Diamond > 0 ->
				?TRY(mod_item:check(Sid,?diamond,Diamond)),
				?TRY(mod_role:check_gilds(Sid,Times)),
				mod_item:use(Sid,?diamond,Diamond,OpType)
		end,
		RoleIDs = do_call_role(Sid,Pool,Times,[]),
		mod_role:add_roles(Sid,RoleIDs,OpType),
		do_add_power(Sid,AddPower),
		pt_role:send(Sid,#pt_call_result{roles = RoleIDs})
	catch throw:?break ->
		void
	end.



do_call_role(Sid,Pool,Times,RoleIDs) when Times =< 0 ->
	RoleIDs;
do_call_role(Sid,Pool,Times,RoleIDs) ->
	CallCfg = util_lists:rand_by_weight(Pool),
	do_call_role(Sid,Pool,Times-1,[CallCfg#cfg_role_call.role_id|RoleIDs]).


% 获取英雄池
get_role_pool(?CALL_TYPE_NORMAL)->
	data_role_call:all();
get_role_pool(?CALL_TYPE_SUPER)->
	data_role_call_super:all();
get_role_pool(?CALL_TYPE_FRIEND)->
	data_role_call_friend:all();
get_role_pool(?CALL_TYPE_POWER)->
	data_role_call_power:all().


% 获取消耗品
get_cost(Type,Times) when Times == 1 ->
	CfgBase = data_role_call_base:get(Type),
	{CfgBase#cfg_role_call_base.item_id,CfgBase#cfg_role_call_base.cost,CfgBase#cfg_role_call_base.diamond,CfgBase#cfg_role_call_base.power};
get_cost(Type,Times) when Times == 10 ->
	CfgBase = data_role_call_base:get(Type),
	{CfgBase#cfg_role_call_base.item_id,CfgBase#cfg_role_call_base.ten_cost,CfgBase#cfg_role_call_base.ten_diamon,CfgBase#cfg_role_call_base.ten_power}.


% 操作类型
get_op_type(?CALL_TYPE_NORMAL)->
	?OP_TYPE_CALL_NORMAL;
get_op_type(?CALL_TYPE_SUPER)->
	?OP_TYPE_CALL_SUPER;
get_op_type(?CALL_TYPE_FRIEND)->
	?OP_TYPE_CALL_FRIEND;
get_op_type(?CALL_TYPE_POWER)->
	?OP_TYPE_CALL_POWER.

% 加能量
do_add_power(Sid,AddPower) ->
	void.

