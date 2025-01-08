INCLUDE Coin_Procedure.inc

.code
DrawPlayer PROC , 
           var1:BYTE,var2:BYTE,var3:BYTE
		    
	WRITE_CHAR_XY var2,var1,var3
	ret
DrawPlayer ENDP
END
