INCLUDE Coin_Procedure.inc

.code
Draw_Score PROC,
              var1:PTR BYTE, var2:PTR BYTE,var3:PTR BYTE,var4:BYTE
	         XY_COUT 10 ,var4,"*************" 
	inc var4
	 WRITE_STRING_NO 9,var4,var1
	 ADD var4,1
	 WRITE_STRING_NO 11,var4,var2
	 ADD var4,1
	 WRITE_STRING_NO 12,var4,var3
	 WRITE_CHAR ":" 
	 ret
Draw_Score ENDP
END