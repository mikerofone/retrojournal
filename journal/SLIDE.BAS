' $DYNAMIC
CONST FALSE = 0
CONST TRUE = NOT FALSE

DIM SHARED graphics(16000)
DIM SHARED key$
DIM SHARED msgindex$

SCREEN 2

SUB sleep STATIC
  sleepcounter = 0
  FOR sleepcounter = 1 to 5000
    call getkey
    IF key$ <> "" THEN
      EXIT FOR
    END IF
  NEXT
END SUB

SUB loadimage(filename$) STATIC
  BLOAD filename$, VARPTR(graphics(0))
  PUT (0,0), graphics, PSET
END SUB


SUB loadinvert(filename$) STATIC
  BLOAD filename$, VARPTR(graphics(0))
  PUT (0,0), graphics, PRESET
END SUB

SUB flash(filename$) STATIC
  call loadinvert(filename$)
  call loadimage(filename$)
  call loadinvert(filename$)
  call loadimage(filename$)
END SUB

SUB discardinputbuffer STATIC
  ' Clear all remaining keys.
  WHILE INKEY$ <> ""
  WEND
END SUB

SUB getkey STATIC
  IF key$ = "" THEN
    key$ = INKEY$
  END IF
  call discardinputbuffer
END SUB
  

SUB maybetakemessage STATIC
  call getkey
  IF key$ = " " OR key$ = chr$(10) OR key$ = chr$(13) THEN
    key$ = ""
    call takemessage
  END IF
END SUB

SUB takemessage STATIC
  CLS
  call loadimage("snesctrl.bin")
  LOCATE 1, 1
  PRINT "Schreib' uns ein paar Worte und drueck 2x auf RETURN."
  PRINT "Vielen Dank! -- Das Epic Moment Team"
  PRINT ""
  DIM line$, message$
  DIM enters
  enters = 1
  message$ = ""
  line$ = ""
  t$ = TIME$
  d$ = DATE$
  DO
    LINE INPUT "", line$
    IF line$ = "" THEN
      enters = enters + 1
    ELSE
      enters = 1
    END IF
    message$ = message$ + line$ + chr$(13) + chr$(10)
  LOOP UNTIL enters >= 2
  PRINT "Nachricht wird gespeichert, merci vielmal! :-)"
  ON ERROR GOTO writeerror
  hms$ = MID$(t$, 1, 2) + MID$(t$, 4, 2) + MID$(t$, 7, 2)
  OPEN "A:\messages\" + hms$ + ".txt" FOR OUTPUT AS 1
  PRINT #1, d$ + " " + t$ + chr$(13) + chr$(10) + message$
  CLOSE 1
  call discardinputbuffer
END SUB
  
  

DIM files$(10)
files$(0) = "retro.bin"
files$(1) = "pokegapi.bin"
files$(2) = "invaders.bin"
files$(3) = "pokeentr.bin"
CONST numfiles = 4

DIM iteration
iteration = 0
REM CONST tipiteration = 2 * numfiles
REM DIM tips
REM tips = FALSE

DIM prompt
prompt = TRUE

DO
  key$ = ""
  currentfile = iteration MOD numfiles
  call loadimage(files$(currentfile))
  IF prompt = TRUE THEN
    LOCATE 25, 1
    PRINT "Bitte druecke RETURN oder LEERTASTE und hinterlasse uns einen Gruss! :-)";
  END IF
  call sleep
  call getkey
REM  IF key$ = "f" THEN
REM    call flash(files$(currentfile))
REM    key$ = ""
REM  END IF
REM  IF key$ = "p" THEN
REM    prompt = NOT prompt
REM    LOCATE 1,1
REM    IF prompt = TRUE THEN
REM      PRINT "Prompt enabled"
REM    ELSE
REM      PRINT "Prompt disabled"
REM    END IF
REM    call discardinputbuffer
REM    key$ = ""
REM    call sleep
REM  END IF
REM  IF key$ = "t" THEN
REM    tips = NOT tips
REM    LOCATE 1,1
REM    IF tips = TRUE THEN
REM      PRINT "Tips screen enabled"
REM    ELSE
REM      PRINT "Tips screen disabled"
REM    END IF
REM    call discardinputbuffer
REM    key$ = ""
REM    call sleep
REM  END IF
  iteration = iteration + 1
REM  IF iteration = tipiteration THEN
REM    IF tips = TRUE THEN
REM      call loadimage("tips.bin")
REM      call sleep
REM    END IF
REM    iteration = 0
REM  END IF
REM  call getkey
  call maybetakemessage
LOOP
REM LOOP UNTIL key$ = "q"
END


writeerror:
  print "Fehler beim Speichern, das tut uns leid. :( Bitte sag Nikolai Bescheid!"
  INPUT "", unused
  RESUME
