-module (pub_cfg).
% 酒馆配置数据获取模块
% 2018-6-6 mihongkun@gmail.com

-include ("pub.hrl").
-include ("data_pub_base.hrl").
-include ("data_pub_award.hrl").
-include ("data_pub_rand.hrl").
-include ("data_pub_star.hrl").


-compile (export_all).

rand_pub_name_by_weight() -> 
	util_lists:rand_by_weight(data_pub_name:all()).
rand_pub_award_by_weight() -> 
	util_lists:rand_by_weight(data_pub_award:all()).
rand_pub_rand_by_weight() -> 
	util_lists:rand_by_weight(data_pub_rand:all()).
rand_pub_star_by_weight() -> 
	util_lists:rand_by_weight(data_pub_star:all()).


rand_pub_name() -> 
	util_lists:rand(data_pub_name:all()).
rand_pub_award() -> 
	util_lists:rand(data_pub_award:all()).
rand_pub_rand() -> 
	util_lists:rand(data_pub_rand:all()).
rand_pub_star() -> 
	util_lists:rand(data_pub_star:all()).


get_base_task_number() ->
	E = get_base_cfg(),
	E#cfg_pub_base.task_number.       
get_base_task_refresh_time() ->
	E = get_base_cfg(),
	E#cfg_pub_base.task_refresh_time. 
get_base_ordinary_reel() ->
	E = get_base_cfg(),
	E#cfg_pub_base.ordinary_reel.     
get_base_refresh_task() ->
	E = get_base_cfg(),
	E#cfg_pub_base.refresh_task.      
get_base_senior_reel() ->
	E = get_base_cfg(),
	E#cfg_pub_base.senior_reel.       
get_base_refresh_task1() ->
	E = get_base_cfg(),
	E#cfg_pub_base.refresh_task1.     
get_base_consume() ->
	E = get_base_cfg(),
	E#cfg_pub_base.consume. 

get_base_cfg() ->
	data_pub_base:get(?CFG_BASE_ID).


get_pub_award_star_lv(Id) ->
	E = get_pub_award_cfg(Id),
	E#cfg_pub_award.star_lv.
get_pub_award_reward(Id) ->
	E = get_pub_award_cfg(Id),
	E#cfg_pub_award.reward.
get_pub_award_min(Id) ->
	E = get_pub_award_cfg(Id),
	E#cfg_pub_award.min.
get_pub_award_max(Id) ->
	E = get_pub_award_cfg(Id),
	E#cfg_pub_award.max.
get_pub_award_weight(Id) ->
	E = get_pub_award_cfg(Id),
	E#cfg_pub_award.weight.

rand_pub_award_by_weight_with_star(Star)	-> 
	All = [E || E<- data_pub_star:all(),E#cfg_pub_award.star_lv =:= Star],
	util_lists:rand_by_weight(All). 

rand_pub_award_meta(Star) ->
	E = rand_pub_award_by_weight_with_star(Star),
	{E#cfg_pub_award.reward,E#cfg_pub_award.min,E#cfg_pub_award.max}.



get_pub_award_cfg(Id) ->
	data_pub_award:get(Id).


get_pub_rand_camp(Id) ->
	E = get_pub_rand_cfg(Id),
	E#cfg_pub_rand.camp.
get_pub_rand_occupation(Id) ->
	E = get_pub_rand_cfg(Id),
	E#cfg_pub_rand.occupation.

get_pub_rand_cfg(Id) ->
	data_pub_rand:get(Id).


get_pub_star_star_lv(Id) ->
	E = get_pub_star_cfg(Id),
	E#cfg_pub_star.star_lv.
get_pub_star_star_condition(Id) ->
	E = get_pub_star_cfg(Id),
	E#cfg_pub_star.star_condition.
get_pub_star_hero_number(Id) ->
	E = get_pub_star_cfg(Id),
	E#cfg_pub_star.hero_number.
get_pub_star_con_number(Id) ->
	E = get_pub_star_cfg(Id),
	E#cfg_pub_star.con_number.
get_pub_star_task_time(Id) ->
	E = get_pub_star_cfg(Id),
	E#cfg_pub_star.task_time.
get_pub_star_acc_cost(Id) ->
	E = get_pub_star_cfg(Id),
	E#cfg_pub_star.acc_cost.
get_pub_star_weight(Id) ->
	E = get_pub_star_cfg(Id),
	E#cfg_pub_star.weight.

get_pub_star_cfg(Id) ->
	data_pub_star:get(Id).

