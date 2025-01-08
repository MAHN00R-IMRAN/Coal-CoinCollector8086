INCLUDE Coin_Procedure.inc

.code
coin_Collect PROC,
             var1:BYTE,var2:BYTE,var3:BYTE,var4:BYTE 
            MOV BL,var1
            CMP BL,var2
            JNE b1
            MOV BL,var3
            CMP BL,var4
            JNE b1
            MOV EAX,1
            JMP b2
	b1:
	       MOV EAX,-1
	b2:
  ret
coin_Collect ENDP
END