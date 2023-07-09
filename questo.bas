1 REM QUEST
2 TH_EXEC("quest"), out$
3 FIRST_EXTRACT$ = TH_RE$(out$, "Hack your way to the host:\s+([A-Z \d]+)", 1) : QHOSTNAME$ = TH_RE$(FIRST_EXTRACT$, "\s[A-Z \d]+", 1)
4 SECOND_EXTRACT$ = TH_RE$(out$ , "The host contains this file:\s+(\w+).SYS", 1) : FILENAME$ = TH_RE$(SECOND_EXTRACT$, "\s+(\w+).SYS", 1)
5 REM uupath array
6 TH_EXEC("uupath " + QHOSTNAME$), PATHS$
7 PATH$ = TH_RE$(PATHS$, "[^\n]+", 1)
8 PATTERN$ = "[^\!]+"
9 FOR I = 1 TO TH_RE(PATH$, PATTERN$, 1)
10 TARGETPATH$(I) = TH_RE$(PATH$, PATTERN$, I)
11 LEN_TARGETPATH% = I
12 NEXT I
13 REM porthack
14 FOR J = 2 TO LEN_TARGETPATH%
15 NROOTED$ = ""
16 IF TH_HASLOGIN(TARGETPATH$(J)) = 1 THEN GOTO 18
17 TH_EXEC("porthack " + TARGETPATH$(J))
18 TH_EXEC("ftp " + TARGETPATH$(J))
19 TH_EXEC("put porthack.exe")
20 TH_EXEC("put atmt.bas")
21 TH_EXEC("quit")
22 TH_EXEC("rlogin " + TARGETPATH$(J))
23 TH_EXEC("ps"), ps$
24 IF TH_RE(NAMEKIT$, "telehack (tel/os)", 1) = 0 THEN IF TH_RE(ps$, "\s3\s", 1) = 0 THEN TH_EXEC("hostname"), NAMEKIT$ : NROOTED$ = NROOTED$ + NAMEKIT$
25 IF TH_RE(NAMEKIT$, "telehack (tel/os)", 1) = 1 THEN GOTO 22
26 NEXT J
27 REM file operations and quitting
28 TH_EXEC("cat " + FILENAME$), CONTENTS$
29 FOR K = 2 TO LEN_TARGETPATH% : TH_EXEC("quit") : NEXT K
30 OPEN "root.txt", AS #1
31 IF EOF(1) THEN GOTO 34
32 INPUT# 1, DUMP$
33 GOTO 31
34 PRINT# 1, NROOTED$	
35 CLOSE #1
36 QCODE$ = TH_RE$(CONTENTS$, "dx\s+(\d+)\s+(\d+)")
37 REM PTYCON
38 TH_EXEC("call -151")
39 TH_EXEC("2425152g")
40 TH_EXEC(QCODE$)
41 TH_EXEC("quit")
42 TH_EXEC("r")
