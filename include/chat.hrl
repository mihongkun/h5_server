-ifndef ( __CHAT_HRL__ ).
-define ( __CHAT_HRL__, true ).



% -define ( CHAT_WORLD_TYPE, 			0). 			% 世界聊天类型
% -define ( CHAT_UNION_TYPE, 			1). 			% 工会聊天类型
% -define ( CHAT_ENROLL_TYPE, 		2). 			% 招募聊天类型
% -define ( CHAT_PRIVATE_TYPE, 		3). 			% 私聊类型
-define ( CHAT_MAX_TIPS_NUM, 		50). 			% 聊天最大的条数限定
-define ( CHAT_WORLD_ID, 			1). 			% 世界聊天的固定ID 便于查找世界聊天的所有记录



 % sid         = 0, %% integer() 玩家ID
 %    lv          = 0, %% integer() 玩家等级
 %    vip         = 0, %% integer() 玩家vip等级
 %    pic         = 0, %% integer() 玩家头像ID
 %    frame       = 0, %% integer() 玩家头像框ID
 %    name        = "", %% list() 玩家名字
 %    msg         = "", %% list() 内容
 %    time        = 0, %% integer() 时间戳
 %    share_type  = 0, %% integer() 分享内容类型 const@CHAT_SHARE_TYPE
 %    share_id    = 0  %% integer() 分享内容ID



-record (chat_world, {
		wid  		= 		?CHAT_WORLD_ID,		% 世界id
		sid			=		0,					% 玩家id
		cont		=		"",					% 内容
		ts			=		0					% 时间戳
	}).

-record (chat_union, {
		eid 		= 		0,					% 工会id
		sid			=		0,					% 玩家id
		cont		=		"",					% 内容
		ts			=		0					% 时间戳
	}).

-record (chat_enroll, {
		eid 		= 		0,					% 工会id
		sid			=		0,					% 玩家id
		cont		=		"",					% 内容
		ts			=		0					% 时间戳
	}).

-record (chat_private, {
		faid		= 		0,					% 从哪里来的账号id
		taid		= 		0,					% 到哪里去的账号id
		cont 		= 		0,					% 聊天内容记录
		ts			= 		0					% 时间戳
	}).














-endif.
