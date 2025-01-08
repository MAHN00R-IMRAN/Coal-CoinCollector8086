INCLUDE Coin_Procedure.inc

.code
Winner_Display PROC,
            var1:BYTE,var2:BYTE,var4:PTR BYTE,var5:PTR BYTE
            MOV AL,var1
            CMP AL,var2
            JA PLAYER1_WINNER
            JB PLAYER2_WINNER
            mov eax,(BLACK*16)+(BLUE*6)
			 call settextcolor
            XY_COUT 21,40,"BOTH PLAYERS HAVE SAME SCORE ."
            JMP END_WIN
    PLAYER1_WINNER:
   
    mov eax,(BLACK*16)+(WHITE)
			 call settextcolor
            XY_COUT 19,37, "* * * * * * WINNER * * * * * *"
	        NEW_LINE
               mov eax,(BLACK*16)+(lightcyan)
			 call settextcolor
	        WRITE_STRING_NO 21,51,var4        ;name of 1st player
            JMP END_WIN
   PLAYER2_WINNER:
      mov eax,(BLACK*16)+(WHITE)
			 call settextcolor
            XY_COUT 19,37, "* * * * * * WINNER * * * * * *"
	        NEW_LINE
            mov eax,(BLACK*16)+(lightred)
			 call settextcolor
	        WRITE_STRING_NO 21,49,var5         ;name of 2nd player
   END_WIN:
   mov eax,(BLACK*16)+(WHITE)
			 call settextcolor
  ret
Winner_Display ENDP
END