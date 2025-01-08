INCLUDE Coin_Procedure.inc

.code
Game_Over PROC,
                var1:BYTE,var2:BYTE 
             MOV BL,var1
             CMP BL,74
             JE OVER
             MOV BL,var1
             CMP BL,0
             JE OVER
             MOV BL,var2
             CMP BL,3
             JBE OVER
             MOV BL,var2
             CMP BL,28
             JA OVER
            JMP QUITE
	OVER:
	   MOV EAX,"***"
    QUITE:
   ret
Game_Over ENDP
END