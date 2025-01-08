INCLUDE Coin_Procedure.inc

.code
 UpdatePlayer PROC , 
              var1:BYTE,var2:BYTE
	GOTO_XY var2,var1
	WRITE_CHAR " "
	ret
UpdatePlayer ENDP
END