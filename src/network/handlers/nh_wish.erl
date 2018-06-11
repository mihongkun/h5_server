-module (nh_wish).

-export ([
	on_wish/1,				%% 获取许愿池基础信息 Type -> 高级 or 普通
	on_pay/2,				%% 充值许愿币	Num -> 购买幸运币的数量
	on_logs/1,				%% 获取中奖列表 
	% on_lucky/0,				%% 打开幸运积分市场 
	on_buy/2,				%% 通过幸运积分购买物品 
	on_guest/2,				%% 用许愿池币抽奖 Type -> 高级 or 普通
	on_refresh_wish/1		%% 玩家手动刷新或强制刷新 Type -> 高级 or 普通
	% on_refresh_lucky/0		%% 幸运积分市场刷新（手动或强制） 
	]).


on_wish(Type) ->
	Sid = get(sid),
	mod_wish:wish(Sid,Type).

on_pay(Type,Num) ->
	Sid = get(sid),
	mod_wish:pay(Sid,Type,Num).


on_logs(Type) ->
	Sid = get(sid),
	mod_wish:logs(Sid,Type).

% on_lucky() ->
% 	Sid = get(sid),
% 	mod_wish:lucky(Sid).

on_buy(Id, Num) ->
	Sid = get(sid),
	mod_wish:buy(Sid,Id,Num).

on_guest(Type, Num) ->
	Sid = get(sid),
	mod_wish:guest(Sid,Type,Num).

on_refresh_wish(Type) ->
	Sid = get(sid),
	mod_wish:refresh_wish(Sid,Type).

% on_refresh_lucky() ->
% 	Sid = get(sid),
% 	mod_wish:refresh_lucky(Sid).

