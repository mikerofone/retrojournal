' $DYNAMIC

SUB drawpic (filename$, xstart, ystart) STATIC

  OPEN filename$ FOR INPUT AS 1
  IF errorflag <> 0 THEN
    errorflag = 0
    CLOSE
    PRINT "File not found"
    EXIT SUB
  END IF

  DIM xlen%, ylen%, xcur%, ycur%, count%, col%
  xcur = xstart
  ycur = ystart
  INPUT #1, xlen, ylen
  print "Drawing file", filename$, xstart; "-"; xlen + xstart, ystart; "-"; ylen + ystart
  INPUT "OK?", unused
  CLS
  SCREEN 2
  DO WHILE NOT EOF(1)
    INPUT #1, count, col
    LINE (xcur, ycur) - (xcur + count, ycur), col
    xcur = xcur + count
    IF xcur >= xstart + xlen THEN
      ycur = ycur + 1
      xcur = xstart
    END IF
  LOOP
  CLOSE 1
END SUB

spacepos = INSTR(COMMAND$, " ")
IF spacepos > 0 THEN
  filename$ = LEFT$(COMMAND$, spacepos - 1)
  commapos = INSTR(COMMAND$, ",")
  xstart = VAL(MID$(COMMAND$, spacepos, commapos - spacepos))
  ystart = VAL(RIGHT$(COMMAND$, commapos))
ELSE
  filename$ = COMMAND$
  xstart = 0
  ystart = 0
END IF
dotpos = INSTR(filename$, ".")
outname$ = LEFT$(filename$, dotpos) + "bin"

call drawpic(filename$, xstart, ystart)
DIM graphics(16000)
GET (0,0)-(639,199), graphics
BSAVE outname$, VARPTR(graphics(0)) , 16000

