REM QHOSTNAME$ = ARGV$(1)

REM get 1st uupath
QHOSTNAME$ = "psueea"
TH_EXEC("uupath " + QHOSTNAME$), PATHS$
PATH$ = TH_RE$(PATHS$, "[^\n]+", 1)

REM split uupath into array
PATTERN$ = "[^\!]+"
FOR I = 1 TO TH_RE(PATH$, PATTERN$, 1)
TARGETPATH$(I) = TH_RE$(PATH$, PATTERN$, I)
NEXT I
