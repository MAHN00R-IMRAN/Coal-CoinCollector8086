INCLUDE Coin_Procedure.inc

.code
Player_name PROC,
             var1:PTR BYTE,var2:PTR BYTE,var3:PTR BYTE,var4:BYTE
	WRITE_STRING_NO var4,40,var3
	NEW_LINE
	INC var4
	WRITE_STRING_NO var4,44,var1
	MOV ECX,20
	READ_STRING var2
	ret
Player_name ENDP
END