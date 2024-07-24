10 REM netstat into array and get array length
20 HOSTNAMES$ = TH_NETSTAT$
30 PATTERN$ = "[^\ ]+" 
31 FILES$ = ""
40 FOR I = 1 TO TH_RE(HOSTNAMES$,PATTERN$,1)
50 HOSTS$(I) = TH_RE$(HOSTNAMES$,PATTERN$,I)
60 LEN_HOSTNAMES% = I
70 NEXT I
80 REM netstat array porthacking
90 FOR K = 1 TO LEN_HOSTNAMES%
100 TH_EXEC("rlogin " + HOSTS$(K))
110 TH_EXEC("ls *.exe"), out$ : FILES$ = FILES$ + HOSTS$(K) + "    :    " + OUT$
150 TH_EXEC("quit")
160 NEXT K
170 TH_EXEC("clear")
180 PRINT FILES$
