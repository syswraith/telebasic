1 REM netstat into array and get array length
2 NROOTED$ = ""
3 HOSTNAMES$ = TH_NETSTAT$
4 PATTERN$ = "[^\ ]+"
5 FOR I = 1 TO TH_RE(HOSTNAMES$,PATTERN$,1)
6 HOSTS$(I) = TH_RE$(HOSTNAMES$,PATTERN$,I)
7 LEN_HOSTNAMES% = I
8 NEXT I
9 REM check
10 FOR K = 1 TO LEN_HOSTNAMES%
11 TH_EXEC("rlogin " + HOSTS$(K))
12 TH_EXEC("ps"), ps$
13 IF TH_RE(ps$, "\s3\s", 1) = 0 THEN TH_EXEC("hostname"), NAMEKIT$ : NROOTED$ = NROOTED$ + NAMEKIT$
14 IF TH_RE(NAMEKIT$, "telehack (tel/os)", 1) = 1 THEN GOTO 11
15 TH_EXEC("quit")
16 NEXT K
17 OPEN "root.txt", AS #1
18 IF EOF(1) THEN GOTO 21
19 INPUT# 1, DUMP$
20 GOTO 18
21 PRINT# 1, NROOTED$	
22 CLOSE #1
