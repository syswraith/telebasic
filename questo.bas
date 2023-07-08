10 REM QUEST
20 TH_EXEC("quest"), out$
30 FIRST_EXTRACT$ = TH_RE$(out$, "Hack your way to the host:\s+([A-Z \d]+)", 1) : QHOSTNAME$ = TH_RE$(FIRST_EXTRACT$, "\s[A-Z \d]+", 1)
40 SECOND_EXTRACT$ = TH_RE$(out$ , "The host contains this file:\s+(\w+).SYS", 1) : FILENAME$ = TH_RE$(SECOND_EXTRACT$, "\s+(\w+).SYS", 1)
50 REM uupath array
60 TH_EXEC("uupath " + QHOSTNAME$), PATHS$
70 PATH$ = TH_RE$(PATHS$, "[^\n]+", 1)
80 PATTERN$ = "[^\!]+"
90 FOR I = 1 TO TH_RE(PATH$, PATTERN$, 1)
100 TARGETPATH$(I) = TH_RE$(PATH$, PATTERN$, I)
110 LEN_TARGETPATH% = I
120 NEXT I
130 REM porthack
140 FOR J = 2 TO LEN_TARGETPATH%
150 IF TH_HASLOGIN(TARGETPATH$(J)) = 1 THEN GOTO 210
160 TH_EXEC("porthack " + TARGETPATH$(J))
170 TH_EXEC("ftp " + TARGETPATH$(J))
180 TH_EXEC("put porthack.exe")
190 TH_EXEC("put atmt.bas")
200 TH_EXEC("quit")
210 TH_EXEC("rlogin " + TARGETPATH$(J))
220 NEXT J
230 REM file operations and quitting
240 TH_EXEC("cat " + FILENAME$), CONTENTS$
250 FOR K = 2 TO LEN_TARGETPATH% : TH_EXEC("quit") : NEXT K
260 QCODE$ = TH_RE$(CONTENTS$, "dx\s+(\d+)\s+(\d+)")
270 REM PTYCON
280 TH_EXEC("call -151")
290 TH_EXEC("2425152g")
300 TH_EXEC(QCODE$)
310 TH_EXEC("quit")
320 TH_EXEC("r")
