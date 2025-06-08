' $DYNAMIC

SUB sleep(seconds) STATIC
  FOR i = 1 to (3000 * seconds)
  NEXT
END SUB

spacepos = INSTR(COMMAND$, " ")
filename$ = LEFT$(COMMAND$, spacepos)
seconds = VAL(MID$(COMMAND$, spacepos + 1))

SCREEN 2
DIM graphics(16000)
BLOAD filename$, VARPTR(graphics(0))
PUT (0,0), graphics
call sleep(seconds)
