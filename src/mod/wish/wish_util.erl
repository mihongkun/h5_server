-module (wish_util).

-include ("wish.hrl").
-include ("pt_wish.hrl").
-include ("data_wish_normal.hrl").
-include ("data_wish_super.hrl").
-include ("data_wish_base.hrl").

-compile(export_all).

write_ps_log(NickName,RewardName) ->
	#ps_log{
		nickname 	= NickName,
		award_name  = RewardName
	}.

write_ps_logs(Logs) ->
	#ps_logs{
		logs = [write_ps_log(NickName,RewardName)|| {NickName,RewardName}<- Logs]
	}.

% write_ps_lucky(Lucky) ->
%  	{LN,Items,Refresh} = Lucky,
%  	#ps_lucky{
%  		luck_num	= LN,
%  		items 		= [write_ps_thing(Thing) || Thing  <- Items]
%  	}.



% write_ps_thing(Thing) ->
% 	{IsSelled,ItemId,ItemNum} = Thing,
% 	#ps_thing{
% 		is_selled = IsSelled,
% 		award     = write_ps_award(ItemId,ItemNum)
% 	}.


write_ps_award(Id,Num) -> 
	#ps_award{
		item_id 	= Id,
		item_num 	= Num
	}.

write_ps_awards(Awards) ->
	#ps_awards{
		awards = [
			write_ps_award(Id,Num) || {Id,Num} <- Awards
		]}.

write_ps_wish(Wish) ->
	{LuckyNum,Grids,Fr,Pr} = Wish,
	#ps_wish{
		luck_num = LuckyNum,
		grids = write_ps_grids(Grids),
		force_refresh = Fr,
		free_refresh = Pr
	}.


write_ps_grid(Grid) ->
	{Seq,Id,Num} = Grid,
	#ps_grid{
		seq = Seq,
		award = write_ps_award(Id,Num)
	}.


write_ps_grids(Grids) ->
	#ps_grids{
		grids = [write_ps_grid(Grid) || Grid <- Grids]
	}.

send_wish(Sid,Wish,Type) ->
	pt_wish:send(Sid,#pt_wish{
			type = Type,
			wish = write_ps_wish(Wish)
		}).

send_pay(Sid,LuckyNum,Type) ->
	pt_wish:send(Sid,#pt_pay{
		type = Type,
		luck_num = LuckyNum
		}). 

send_logs(Sid,Logs,Type) ->
	pt_wish:send(#pt_logs{
			type = Type,
			logs = write_ps_logs(Logs)	
		}).

% send_lucky(Sid,Lucky) ->
% 	pt_wish:send(#pt_lucky{
% 			lucky = write_ps_lucky(Lucky)
% 		}).

send_guest(Sid,Awards,Type) ->
	pt_wish:send(#pt_guest{
			type = Type,
			awards = write_ps_awards(Awards)
		}).

send_refresh_wish(Sid,Grids,Type) ->
	pt_wish:send(#pt_refresh_wish{
			type = Type,
			grids = write_ps_grids(Grids)
		}).

% send_refresh_lucky(Sid,Things) ->
% 	pt_wish:send(Sid,#pt_refresh_lucky{
% 			items = [write_ps_thing(Thing) || Thing <- Things]
% 		}).

% send_buy(Sid,Things) ->
% 	pt_wish:send(Sid,#pt_buy{
% 			items = [write_ps_thing(Thing) || Thing <- Things]
% 		}).

