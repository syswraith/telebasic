10 REM netstat into array and get array length
20 HOSTNAMES$ = TH_NETSTAT$
30 PATTERN$ = "[^\ ]+"
40 FOR I = 1 TO TH_RE(HOSTNAMES$,PATTERN$,1)
50 HOSTS$(I) = TH_RE$(HOSTNAMES$,PATTERN$,I)
60 LEN_HOSTNAMES% = I
70 NEXT I
80 REM netstat array porthacking
90 FOR K = 1 TO LEN_HOSTNAMES%
100 IF TH_HASLOGIN(HOSTS$(K)) = 1 THEN GOTO 160
110 TH_EXEC("porthack " + HOSTS$(K))
120 TH_EXEC("ftp " + HOSTS$(K))
130 TH_EXEC("PUT porthack.exe")
140 TH_EXEC("PUT atmt.bas")
150 TH_EXEC("quit")
160 NEXT K
