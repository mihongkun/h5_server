%% 物品模块
%% 2018-5-2 	laojiajie@gmail.com
%% (修改)2018-5-21	mihongkun@gmail.com

-module(mod_item).
-include("item.hrl").
-include("data_item.hrl").
-include("log_item.hrl").
-include("pt_item.hrl").
-include("common.hrl").
-compile(export_all).


%% 通用接口可以提供给其他模块使用
% 物品配置ID -> CfgID
% 物品数量 -> Num
-export([
		check/2,		% 批量检查物品是否充足 Sid,[{CfgID,Num}] -> true/false
		check/3,		% 检查单个物品是否充足 Sid,CfgID,Num -> true/false
		use/3,			% 检查物品是否充足，如果充足则使用掉，否则返回false。 Sid,[{CfgID,Num}],OpType -> true/false
		use/4,			% 检查单个物品是否充足，如果充足则使用掉，否则返回false Sid,CfgID,Num,OpType -> true/false
		add/3,			% 批量添加物品 Sid,[{CfgID,Num},OpType -> true 
		add/4			% 添加单个物品 Sid,CfgID,Num,OpType -> void
	]).



%% 登陆处理
login(Sid,Pid,Socket)->
	put(sid,Sid),
	put(socket,Socket),
	?DBG(mod_item,"login sid = ~p,pid = ~p",[Sid,Pid]),
	send_all_items(Sid),
	gen_server:cast(Pid,{login_load_mod_finish,?MODULE}).


%%===========================================基础的增删改查====================================

check(Sid,[]) ->
	true;
check(Sid,[{CfgID,Num}|Res]) ->
	case check(Sid,CfgID,Num) of
		true ->
			check(Sid,Res);
		false ->
			false
	end.

check(Sid,CfgID,Num) when Num == 0 -> true;
check(Sid,CfgID,Num) when Num > 0 ->
	case lists:member(CfgID,?ECONOMY_ITEMS) of
		true ->
			mod_economy:check_by_item_id(Sid,CfgID,Num); 	% 经济物品，调用经济模块
		false ->
			case get_item(Sid,CfgID) of
				undefined ->
					send_item_tips(Sid,CfgID),
					false;
				Item when Item#item.stack_num >= Num ->
					true;
				_ ->
					send_item_tips(Sid,CfgID),
					false
			end
	end.

use(Sid,ItemList,OpType) ->
	case check(Sid,ItemList) of
		true ->
			do_use_items(Sid,ItemList,OpType);
		false ->
			false
	end.

use(Sid,CfgID,Num,OpType) ->
	case check(Sid,CfgID,Num) of
		true ->
			do_use_items(Sid,[{CfgID,Num}],OpType),
			true;
		false ->
			false
	end.

do_use_items(Sid,[],OpType) ->
	true;
do_use_items(Sid,[{CfgID,0}|Res],OpType) ->
	do_use_items(Sid,Res,OpType);
do_use_items(Sid,[{CfgID,Num}|Res],OpType) when Num > 0 ->
	case lists:member(CfgID,?ECONOMY_ITEMS) of
		true ->
			mod_economy:use_by_item_id(Sid,CfgID,Num,OpType);
		false ->
			case get_item(Sid,CfgID) of
				undefined ->
					void;
				Item when Item#item.stack_num > Num ->
					NewItem = Item#item{stack_num = Item#item.stack_num - Num},
					cache:update(NewItem),
					send_update_items(Sid,[NewItem]),
					item_log(NewItem,-Num,OpType);
				Item ->
					cache:delete(Item),
					send_update_items(Sid,[Item#item{stack_num = 0}]),
					logger:add(#log_item{
						sid          	= Sid,	%% 玩家ID
						cfg_id          = CfgID,	%% 物品配置ID
						num             = -Num,	%% 变更数量
						total			= 0,	%% 总数量
						opType			= OpType,	%% 操作类型
						opTime 			= util:unixtime()		%% 操作时间
					})
			end
	end,
	do_use_items(Sid,Res,OpType).
	

add(Sid,CfgID,Num,OpType) ->
	Items = do_add_item(Sid,CfgID,Num,OpType),
	send_update_items(Sid,Items).

add(Sid,ItemTupList,OpType) ->
	Items = add_helper(Sid,ItemTupList,OpType,[]),
	send_update_items(Sid,Items).


add_helper(Sid,[],OpType,Items) ->
	Items;
add_helper(Sid,[{CfgID,Num}|Res],OpType,Items) ->
	AddItems = do_add_item(Sid,CfgID,Num,OpType),
	add_helper(Sid,Res,OpType,AddItems ++ Items).

do_add_item(Sid,CfgID,Num,OpType) when Num > 0 ->
	case lists:member(CfgID,?ECONOMY_ITEMS) of
		true ->
			mod_economy:add_by_item_id(Sid,CfgID,Num,OpType), % 经济物品，调用经济模块
			[];
		false ->
			case get_item(Sid,CfgID) of
				undefined -> 
					Item = #item{
						key = {Sid,CfgID},
						stack_num = Num
					},
					cache:insert(Item),
					item_log(Item,Num,OpType),
					[Item];
				Item ->
					NewItem = Item#item{stack_num = Item#item.stack_num + Num},
					cache:update(NewItem),
					item_log(NewItem,Num,OpType),
					[NewItem]
			end
	end.





%% 获取所有物品
get_items(Sid) ->	
	cache:lookup(item,Sid).


%% 获取单个物品
get_item(Sid,CfgID)->
	case cache:lookup(item,{Sid,CfgID}) of
		[] ->
			undefined;
		[Item] ->
			Item
	end.


%%===============================================send proto=================================

send_all_items(Sid) ->
	Items = get_items(Sid),
	pt_item:send(Sid,#pt_get_items{
	    items  = write_ps_items(Items)
	}).


write_ps_items(Items) ->
	[#ps_item{
	    cfg_id     = CfgID, %% integer() 配置ID
	    stack_num  = StackNum  %% integer() 物品堆叠数量
		} || #item{key={Sid,CfgID},stack_num=StackNum} <- Items].

%% 更新物品信息给客户端 
send_update_items(Sid,[]) -> void;
send_update_items(Sid,Items) ->
	pt_item:send(Sid,#pt_get_items{
	    items  = write_ps_items(Items)
	}).


send_item_tips(Sid,CfgID) ->
	ItemCfg = data_item:get(CfgID),
	proto:send_error(Sid,?TIPS_NOT_ENOUGH_ITEM,[ItemCfg#cfg_item.name]).



%% 记录物品日志
item_log(Item,Num,OpType) ->
	{Sid,CfgID}= Item#item.key,
	logger:add(#log_item{
				sid          	= Sid,	%% 玩家ID
				cfg_id          = CfgID,	%% 物品配置ID
				num             = Num,	%% 变更数量
				total			= Item#item.stack_num,	%% 总数量
				opType			= OpType,	%% 操作类型
				opTime 			= util:unixtime()		%% 操作时间
			}).




	



