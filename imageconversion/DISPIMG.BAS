SUB drawpic (filename$) STATIC

  OPEN filename$ FOR INPUT AS 1
  IF errorflag <> 0 THEN
    errorflag = 0
    CLOSE
    PRINT "File not found"
    EXIT SUB
  END IF

  DIM xlen%, ylen%, xcur%, ycur%, count%, col%
  xcur = 0
  ycur = 0
  INPUT #1, xlen, ylen
  SCREEN 2
  DO WHILE NOT EOF(1)
    INPUT #1, count, col
    LINE (xcur, ycur) - (xcur + count, ycur), col
    xcur = xcur + count
    IF xcur = xlen THEN
      ycur = ycur + 1
      xcur = 0
    END IF
  LOOP
  CLOSE 1
END SUB

SUB sleep(seconds) STATIC
  FOR i = 1 TO 1500 * seconds
  NEXT
END SUB

call drawpic(COMMAND$)
call sleep(4)
