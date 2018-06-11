-ifndef(__NW_HRL__).
-define(__NW_HRL__, true).

-define(PACK_HEADER_SIZE, 6). %% 4 bytes packet length + 2 bytes protocol index


%% 网络流量统计
-record(flow,{
	key={0,0}, %% date,protoID
	send_times = 0,		% 发送次数
	send_bytes = 0,		% 发送流量
	send_max   = 0,		% 发送最大流量
	recv_times = 0,		% 接收次数
	recv_bytes = 0,		% 接收流量
	recv_max   = 0,		% 接收最大流量
	op_time    = 0,		% 协议的处理时间（微秒）
	op_time_max = 0,	% 单次最高处理时间
	op_time_max_ts = 0	% 单次最高处理时间的发生时间戳
	}).


-endif.