-ifndef(__LOG_HRL__).
-define(__LOG_HRL__, true).

-ifdef(GAME_DEBUG).

-define(DBG(Tag, Fmt),       format_util:log(debug,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(DBG(Tag, Fmt, Args), format_util:log(debug,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(INF(Tag, Fmt),       format_util:log(info,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(INF(Tag, Fmt, Args), format_util:log(info,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(NTC(Tag, Fmt),       format_util:log(notice,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(NTC(Tag, Fmt, Args), format_util:log(notice,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(WRN(Tag, Fmt),       format_util:log(warning,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(WRN(Tag, Fmt, Args), format_util:log(warning,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(ERR(Tag, Fmt),       format_util:log(error,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(ERR(Tag, Fmt, Args), format_util:log(error,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(CRT(Tag, Fmt),       format_util:log(critical,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(CRT(Tag, Fmt, Args), format_util:log(critical,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(ALT(Tag, Fmt),       format_util:log(alert,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(ALT(Tag, Fmt, Args), format_util:log(alert,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(EMG(Tag, Fmt),       format_util:log(emergency,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(EMG(Tag, Fmt, Args), format_util:log(emergency,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-endif.


-ifndef(GAME_DEBUG).

-define(DBG(Tag, Fmt),       void).
-define(DBG(Tag, Fmt, Args), void).

-define(INF(Tag, Fmt),       lager:log(info,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(INF(Tag, Fmt, Args), lager:log(info,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(NTC(Tag, Fmt),       lager:log(notice,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(NTC(Tag, Fmt, Args), lager:log(notice,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(WRN(Tag, Fmt),       lager:log(warning,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(WRN(Tag, Fmt, Args), lager:log(warning,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(ERR(Tag, Fmt),       lager:log(error,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(ERR(Tag, Fmt, Args), lager:log(error,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(CRT(Tag, Fmt),       lager:log(critical,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(CRT(Tag, Fmt, Args), lager:log(critical,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(ALT(Tag, Fmt),       lager:log(alert,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(ALT(Tag, Fmt, Args), lager:log(alert,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).

-define(EMG(Tag, Fmt),       lager:log(emergency,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt)).
-define(EMG(Tag, Fmt, Args), lager:log(emergency,[{tag, Tag},{module,?MODULE},{line,?LINE},{sid,get(sid)},{pid,self()}], Fmt, Args)).


-endif.





-endif.
