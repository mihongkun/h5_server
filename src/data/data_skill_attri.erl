%% this file is auto maked!
-module(data_skill_attri).
-include("data_skill_attri.hrl").
-compile(export_all).

%% Z-战斗\技能属性表-SkillAbility.xlsx

get(A) ->
 format_util:log(error,[{tag, cfg_error},{module,?MODULE},{line,?LINE},{sid,erlang:get(sid)},{pid,self()}], "data_skill_attri:get(~p) not_match", [A]),
 not_match.

length() ->
 0.

id_list() ->
 [].

all() ->[data_skill_attri:get(ID) || ID<-id_list()].
