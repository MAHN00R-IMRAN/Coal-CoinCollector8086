INCLUDE Coin_Procedure.inc

.code
score_dwin PROC,
               var1:PTR BYTE,var2:PTR BYTE,var3:PTR BYTE,var4:BYTE,var5:BYTE
	 WRITE_STRING_NO 11,var5,var1
	 ADD var5,1
	 WRITE_STRING_NO 13,var5,var2
	 WRITE_STRING_NO 15,var5,var3
	 WRITE_CHAR ":" 
   	 COUTINT var4
	 ret
score_dwin ENDP
END