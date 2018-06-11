%% 技能目标选择实现
%% 2018-5-23 laojiajie@gmail.com

-module(skill_target_filter).
-include("battle.hrl").
-compile(export_all).


handle(Battle,Entity=#entity{pos = Pos},Effect=#cfg_skill_effect{filters = Filters},PosList) ->
	% 目标存活或者死亡，是首要条件
	IsDead = lists:member(?BATTLE_FILTER_STATUS_DEAD,Filters),
	% 敌我是第二条件
	IsOwn = (Filters -- [?BATTLE_FILTER_STAND,?BATTLE_FILTER_ENEMY] == Filters),
	Fun = fun(Pos1) ->
		Entity1 = battle_util:get_entity(Battle,Pos1),
		IsOwn1 = battle_util:is_own(Pos,Pos1),
		IsDead1 = Entity1#entity.cur_hp =< 0,
		IsDead1 == IsDead andalso IsOwn1 == IsOwn
	end,
	PosList1 = lists:filter(Fun,PosList),
	handle_helper(Battle,Entity,PosList1,Filters).

handle_helper(Battle,Entity,[],Filters) ->
	[];
handle_helper(Battle,Entity,PosList,[]) ->
	PosList;
handle_helper(Battle,Entity=#entity{pos = Pos},PosList,[?BATTLE_FILTER_STAND|Res]) -> % 顺位攻击
	[lists:min(PosList)];
handle_helper(Battle,Entity=#entity{pos = Pos},PosList,[?BATTLE_FILTER_SELF|Res]) -> % 自己
	[Pos];
handle_helper(Battle,Entity=#entity{pos = Pos},PosList,[?BATTLE_FILTER_FRIEND|Res]) -> % 队友
	PosList1 = lists:filter(fun(Pos1)-> battle_util:is_friend(Pos,Pos1) end,PosList),
	handle_helper(Battle,Entity,PosList1,Res);


handle_helper(Battle,Entity=#entity{pos = Pos},PosList,[?BATTLE_FILTER_POS_SINGLE|Res]) -> % 单体
	handle_helper(Battle,Entity,util_lists:rand(PosList),Res);
handle_helper(Battle,Entity=#entity{pos = Pos},PosList,[?BATTLE_FILTER_POS_FONT|Res]) -> % 前排
	handle_helper(Battle,Entity,find_font(PosList),Res);
handle_helper(Battle,Entity=#entity{pos = Pos},PosList,[?BATTLE_FILTER_POS_BACK|Res]) -> % 后排
	handle_helper(Battle,Entity,find_back(PosList),Res);



handle_helper(Battle,Entity,PosList,[_Else|Res]) ->
	handle_helper(Battle,Entity,PosList,Res).



find_font(PosList) ->
	PosList1 = PosList -- ?BATTLE_POS_BACK,
	case PosList1 of
		[] ->
			PosList;
		_ ->
			PosList1
	end.

find_back(PosList) ->
	PosList1 = PosList -- ?BATTLE_POS_FONT,
	case PosList1 of
		[] ->
			PosList;
		_ ->
			PosList1
	end.


