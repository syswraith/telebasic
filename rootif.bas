REM netstat into array and get array length
NROOTED$ = ""
HOSTNAMES$ = TH_NETSTAT$
PATTERN$ = "[^\ ]+"
FOR I = 1 TO TH_RE(HOSTNAMES$,PATTERN$,1)
HOSTS$(I) = TH_RE$(HOSTNAMES$,PATTERN$,I)
LEN_HOSTNAMES% = I
NEXT I
REM check
FOR K = 1 TO LEN_HOSTNAMES%
TH_EXEC("rlogin " + HOSTS$(K))
TH_EXEC("ps"), ps$
IF TH_RE(ps$, "\s3\s", 1) = 0 THEN NROOTED$ = NROOTED$ + HOSTS$(K) + " is not rooted" + LIN(1)
TH_EXEC("quit")
NEXT K
PRINT NROOTED$
