INCLUDE Coin_Procedure.inc

.data
C_DISPLAY   BYTE  " ",0ah,0dh
     BYTE  "                 ____   ____               ____   ____               ____   ____  _____   ____    ___       ",0ah,0dh
     BYTE  "                |      |    |  | |\  |    |      |    | |     |     |      |        |    |    |  |___|      ",0ah,0dh
     BYTE  "                |      |    |  | | \ |    |      |    | |     |     |----  |        |    |    |  | \         ",0ah,0dh
     BYTE  "                |____  |____|  | |  \|    |___   |____| |___  |____ |____  |____    |    |____|  |  \        ",0
	 GROUND  BYTE "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *",0
SCORE BYTE 0                                                                                   ;SCORE OF VARAIBLE A
SCORE2 BYTE 0                                                                                  ;SCORE OF VARAIBLE B
N BYTE "ENTER NAME: ",0
P1 DWORD 20 DUP(?)                                                                             ;NAME OF PLAYER 1
P2 DWORD 20 DUP(?)                                                                             ;NAME OF PLAYER 2
PLAY1 BYTE " PLAYER:1 ",0
PLAY2 BYTE " PLAYER:2 ",0
VARB BYTE "B",0
XPOS BYTE 10                                                                                   ;X POSITION OF VARIABLE B
YPOS BYTE 15                                                                                   ;Y POSITION OF VARIABLE B
VARA BYTE "A",0
XPOS2 BYTE 15                                                                                  ;X POSITION OF VARIABLE A
YPOS2 BYTE 27                                                                                  ;Y POSITION OF VARIABLE A
XCOINPOS BYTE 5                                                                                ;COIN POSITION OF X AXIS
YCOINPOS BYTE 15                                                                               ;COIN POSITION OF Y AXIS
INPUT_CHAR BYTE ?
TRY_AGAIN byte "TRY AGAIN (Y/N)",0
CHAR1 BYTE ?

.code
main PROC
    
   tryagain::
             mov score,0
			
			 mov eax,(BLACK*16)+(BLUE*6)
			 call settextcolor
			 call clrscr    
	         CLEAR_SCREEN 
             WRITE_STRING 10,25,C_DISPLAY                                                      ; DISPLAY NAME COIN COLLECTOR 
	         XY_COUT 20,40,"1 PLAYER OR 2 PLAYERS ? "                                        
             call readdec
			 cmp eax,2
			 JE PLAYER_2
			  mov XPOS2,10
			 mov YPOS2,15
			   mov eax,(BLACK*16)+(BLUE*6)
			 call settextcolor
			 call clrscr 
             WRITE_STRING 10,25,C_DISPLAY                                                      ; DISPLAY NAME COIN COLLECTOR 
             INVOKE Player_name,ADDR N,ADDR P1,ADDR PLAY1,20                                   ; PLAYER:1 NAME
			 MOV EAX,1000                                                                      ; DELAY
	         DELAY1
            
			  mov eax,(BLACK*16)+(BLUE*6)
			 call settextcolor
			 call clrscr
             NEW_LINE
	         XY_COUT 1,25,"**** COIN COLLECTOR **** "                                         ; DISPLAY NAME COIN COLLECTOR
		     INVOKE Draw_Border,ADDR GROUND                                                    ; PROCEDURE CALL TO DISPLAY BORDER
        	 
	       	 INVOKE Draw_Score,ADDR PLAY1,ADDR P1,ADDR VARA,88                                 ; DRAW SCORE OF VARIABLE A(PLAYER 1:)
	         XY_COUT 16 ,86,"  PLAYER KEYS " 
	         XY_COUT 17 ,87,"*************" 
	         XY_COUT 18,87, " UP :   W "                                        
	         XY_COUT 19 ,87," DOWN:  Z  "                                        
	         XY_COUT 20 ,87," LEFT:  A  "
			 XY_COUT 21 ,87," RIGHT: D  "                                        

		     mov eax,(BLACK*16)+(WHITE)
			 call settextcolor
	         INVOKE DrawPlayer,XPOS2,YPOS2,VARA
			 mov eax,(BLACK*16)+(BLUE*6)
			 call settextcolor
			 CALL CreateRandomCoin  
			 MOV ECX,07FFFFFFFh

    gameLoop1: 
             PUSH ECX
			 mov eax,0
			 mov eax,(BLACK*16)+(WHITE)
			 call settextcolor
		     XY_COUTINT 12,93,SCORE

		ON_GROUND1:
			CHAR_CIN INPUT_CHAR
		MOVE_UPWARD_A:
		    CMP INPUT_CHAR,"w"                                                                     ;KEY USE W VARIABLE A PLAYER MOVE UPWARD
		    JNE MOVE_DOWN_A
		    INVOKE UpdatePlayer,XPOS2,YPOS2
			DEC YPOS2
			INVOKE DrawPlayer,XPOS2,YPOS2,VARA
			JMP S_DISPLAY1
	MOVE_DOWN_A:
		    CMP INPUT_CHAR,"z"                                                                     ;KEY USE Z VARIABLE A PLAYER MOVE DOWNWARD
		    JNE MOVE_LEFT_A
		    INVOKE UpdatePlayer,XPOS2,YPOS2
	     	INC YPOS2
	    	INVOKE  DrawPlayer,XPOS2,YPOS2,VARA
			JMP S_DISPLAY1

	MOVE_LEFT_A:
		    CMP INPUT_CHAR,"a"                                                                     ;KEY USE A VARIABLE A PLAYER MOVE LEFT
		    JNE MOVE_RIGHT_A
		   	INVOKE UpdatePlayer,XPOS2,YPOS2
	     	DEC XPOS2
		    INVOKE  DrawPlayer,XPOS2,YPOS2,VARA
			JMP S_DISPLAY1

	MOVE_RIGHT_A:
		    CMP INPUT_CHAR,"d"                                                                     ;KEY USE D VARIABLE A PLAYER MOVE RIGHT
		    JNE ON_GROUND1
		    INVOKE UpdatePlayer,XPOS2,YPOS2
		    INC XPOS2
		    INVOKE DrawPlayer,XPOS2,YPOS2,VARA
			JMP S_DISPLAY1


    S_DISPLAY1:
	      INVOKE Game_Over,XPOS2 , YPOS2                                                             ; GAMEOVER PROCEDURE VARIABLE B
       	   CMP eax,"***"
   	       JE GAME_OVER1_1
           INVOKE coin_Collect,XPOS2,XCOINPOS,YPOS2,YCOINPOS                                        ; COIN COLLECT OR NOT FOR VARIABLE A
           CMP EAX,1                                                                                ; RETURN EAX DECIDE SCORE INCREMENT OR NOT
           JNE NOT_COLLECTING1
	       INC SCORE 
		   movzx esi,SCORE
           CALL CreateRandomCoin                                                                    ; COLLECT COIN ,SCORE INCREMENT, GENERATE NEW COIN
		   NOT_COLLECTING1:
		   movzx esi,SCORE
		   jmp gameLoop1
	GAME_OVER1_1::
	       CLEAR_SCREEN 
	         mov eax,(BLACK*16)+(BLUE*6)
			 call settextcolor
			 call clrscr                                                                           ; CLEAR-SCREEN
	       NEW_LINE
	       NEW_LINE
           WRITE_STRING 2,15,C_DISPLAY                                                               ; DISPLAY COIN COLLECTOR 
	       NEW_LINE

           WRITE_STRING 8,18,GROUND
		   WRITE_STRING 13,40,PLAY1
		   WRITE_STRING 13,50,VARA

	         XY_COUT 14 ,40,"*************" 

		   WRITE_STRING 15,51,p1
	       XY_COUT 16,51,"SCORE : "                                        ; DISPLAY NAME COIN COLLECTOR
		   movzx eax,SCORE
		   call writedec
		   e0:
            jmp ll1
		     POP ECX
		     DEC ECX
		     CMP ECX,0
		     JA gameloop1
		     JMP GAME_OVER1

   PLAYER_2:
             mov score2,0
			 mov XPOS,10
			 mov YPOS,15
			 mov XPOS2,20
			 mov YPOS2,18
	          mov eax,(BLACK*16)+(WHITE)
			 call settextcolor
			 call clrscr
             WRITE_STRING 10,25,C_DISPLAY                                                      ; DISPLAY NAME COIN COLLECTOR 
			 mov eax,(BLACK*16)+(lightcyan)
			 call settextcolor
             INVOKE Player_name,ADDR N,ADDR P1,ADDR PLAY1,20                                   ; PLAYER:1 NAME
			 mov eax,(BLACK*16)+(lightred)
			 call settextcolor
	         INVOKE Player_name,ADDR N,ADDR P2,ADDR PLAY2,22                                   ; PLAYER:2 NAME
	         MOV EAX,1000                                                                      ; DELAY
	         DELAY1
             SETCOLOR     
	         CLEAR_SCREEN 
             NEW_LINE
			 mov eax,(BLACK*16)+(WHITE)
			 call settextcolor
	         XY_COUT 1,25,"----- COIN COLLECTOR ----- "                                        ; DISPLAY NAME COIN COLLECTOR
		     INVOKE Draw_Border,ADDR GROUND                                                    ; PROCEDURE CALL TO DISPLAY BORDER
			 mov eax,(BLACK*16)+(lightcyan)
			 call settextcolor
             INVOKE Draw_Score,ADDR PLAY1,ADDR P1,ADDR VARA,80                                 ; DRAW SCORE OF VARIABLE A(PLAYER 1:)
	         INVOKE DrawPlayer,XPOS2,YPOS2,VARA                                                ; DRAW VARIABLE A PLAYER
			
			mov eax,(BLACK*16)+(lightred)
			 call settextcolor
             INVOKE Draw_Score,ADDR PLAY2,ADDR P2,ADDR VARB,99                                 ; DRAW SCORE OF VARIABLE B(PLAYER 2:)
	         INVOKE DrawPlayer,XPOS,YPOS,VARB                                                  ; DRAW VARIABLE B PLAYER
	         CALL CreateRandomCoin   ; PROCEDURE CALL CREATE RANDOMCOIN  
			 mov eax,(BLACK*16)+(lightcyan)
			 call settextcolor
			 XY_COUT 16 ,79," A PLAYER KEYS " 
	         XY_COUT 17 ,80,"**************" 
	         XY_COUT 18,80, " UP :   W "                                        
	         XY_COUT 19 ,80," DOWN:  Z  "                                        
	         XY_COUT 20 ,80," LEFT:  A  "
			 XY_COUT 21 ,80," RIGHT: D  "
			  mov eax,(BLACK*16)+(lightred)
			 call settextcolor
			 XY_COUT 16 ,99," B PLAYER KEYS " 
	         XY_COUT 17 ,99,"**************" 
	         XY_COUT 18 ,99, " UP :   I "                                        
	         XY_COUT 19 ,99," DOWN:  M  "                                        
	         XY_COUT 20 ,99," LEFT:  J  "
			 XY_COUT 21 ,99," RIGHT: L  "
	         MOV ECX,07FFFFFFFh

    gameLoop: 
             PUSH ECX
			 mov eax,(BLACK*16)+(lightcyan)
			 call settextcolor
		     XY_COUTINT 12,85,SCORE
			 mov eax,(BLACK*16)+(lightred)
			 call settextcolor
		     XY_COUTINT 12,104,SCORE2
             CALL CHECK 
             CALL CHECK2
		     POP ECX
		     DEC ECX
		     CMP ECX,0
		     JA gameloop
		     JMP GAME_OVER1
exit
main ENDP

CreateRandomCoin PROC                                                                           ;CREATE RANDOM COIN PROCEDURE
	          MOV EAX,70
	          INC EAX
	          CALL RANDOMRANGE
	          CMP AL,1
	          JBE COIN_POS_X
	          MOV XCOINPOS,AL
	          JMP l1

	COIN_POS_X:
	          MOV XCOINPOS,15

	l1:
	          MOV EAX,28
	          CALL RANDOMRANGE
	          CMP AL,3
	          JBE COIN_POS_Y
	          MOV YCOINPOS,AL
	          JMP lv

	COIN_POS_Y:
	          MOV YCOINPOS,15

	lv:
	          
			  mov eax,(BLACK*16)+(BLUE*6)
			 call settextcolor
	          GOTO_XY YCOINPOS,XCOINPOS                                                           ;RANDOM COIN GENERATE AT X AND Y POSITION
	          WRITE_CHAR 'O'
	ret
CreateRandomCoin ENDP
                     ;---------------MOVEMENT KEYS OF PLAYER A AND B----------------
CHECK PROC
      PUSHAD

	ON_GROUND:
	         mov eax,(BLACK*16)+(lightred)
			 call settextcolor
		       CHAR_CIN INPUT_CHAR
		       CMP INPUT_CHAR,"6"                                                                 ;CHECK CHARACTER TO EXIT
		       JE EXIT_GAME
               CMP INPUT_CHAR,"i"                                                                 ;KEY USE I VARIABLE B PLAYER MOVE UPWARD 
		       JNE MOVE_DOWN_B
		       INVOKE UpdatePlayer,XPOS,YPOS  
			   DEC YPOS
			   INVOKE DrawPlayer,XPOS,YPOS,VARB
			   JMP S_DISPLAY

	MOVE_DOWN_B:
		       CMP INPUT_CHAR,"m"                                                                 ;KEY USE M VARAIBLE B PLAYER MOVE DOWNWARD
		       JNE MOVE_LEFT_B
		       INVOKE UpdatePlayer,XPOS,YPOS  
		       INC YPOS
		       INVOKE DrawPlayer,XPOS,YPOS,VARB
		       JMP S_DISPLAY

    MOVE_LEFT_B:
		      CMP INPUT_CHAR,"j"                                                                  ;KEY USE J VARAIBLE B PLAYER MOVE LEFT
		      JNE MOVE_RIGHT_B
		      INVOKE UpdatePlayer,XPOS , YPOS  
		      DEC XPOS
		      INVOKE  DrawPlayer,XPOS,YPOS,VARB
			  JMP S_DISPLAY

	MOVE_RIGHT_B:
		     CMP INPUT_CHAR,"l"                                                                   ;KEY USE L VARIABLE B PLAYER MOVE RIGHT
		     JNE MOVE_UPWARD_A
		     INVOKE UpdatePlayer,XPOS,YPOS 
		     INC XPOS
		     INVOKE DrawPlayer,XPOS,YPOS,VARB
			 JMP S_DISPLAY

	MOVE_UPWARD_A:
	       mov eax,(BLACK*16)+(lightcyan)
			 call settextcolor
		    CMP INPUT_CHAR,"w"                                                                     ;KEY USE W VARIABLE A PLAYER MOVE UPWARD
		    JNE MOVE_DOWN_A
		    INVOKE UpdatePlayer,XPOS2,YPOS2
			DEC YPOS2
			INVOKE DrawPlayer,XPOS2,YPOS2,VARA
			JMP S_DISPLAY

	MOVE_DOWN_A:
		    CMP INPUT_CHAR,"z"                                                                     ;KEY USE Z VARIABLE A PLAYER MOVE DOWNWARD
		    JNE MOVE_LEFT_A
		    INVOKE UpdatePlayer,XPOS2,YPOS2
	     	INC YPOS2
	    	INVOKE  DrawPlayer,XPOS2,YPOS2,VARA
			JMP S_DISPLAY

	MOVE_LEFT_A:
		    CMP INPUT_CHAR,"a"                                                                     ;KEY USE A VARIABLE A PLAYER MOVE LEFT
		    JNE MOVE_RIGHT_A
		   	INVOKE UpdatePlayer,XPOS2,YPOS2
	     	DEC XPOS2
		    INVOKE  DrawPlayer,XPOS2,YPOS2,VARA
			JMP S_DISPLAY

	MOVE_RIGHT_A:
		    CMP INPUT_CHAR,"d"                                                                     ;KEY USE D VARIABLE A PLAYER MOVE RIGHT
		    JNE ON_GROUND
		    INVOKE UpdatePlayer,XPOS2,YPOS2
		    INC XPOS2
		    INVOKE DrawPlayer,XPOS2,YPOS2,VARA
			JMP S_DISPLAY

    S_DISPLAY:
            POPAD
 ret
 CHECK ENDP

CHECK2 PROC
          mov bl,XPOS
		  cmp bl,XPOS2
		  jne ww
		   mov bl,YPOS
		  cmp bl,YPOS2
		  jne ww
		   JMP GAME_OVER1 
		  ww:
           INVOKE Game_Over,XPOS , YPOS                                                             ; GAMEOVER PROCEDURE VARIABLE B
       	   CMP eax,"***"
   	       JE GAME_OVER1 
   	       INVOKE Game_Over,XPOS2 , YPOS2                                                           ; GAMEOVER PROCEDURE VARIABLE A   
	       CMP EAX,"***"
	       JE GAME_OVER1 
	       INVOKE coin_Collect,XPOS,XCOINPOS,YPOS,YCOINPOS                                          ; COIN COLLECT OR NOT FOR VARAIBLE B
	       CMP EAX,1                                                                                ; RETURN EAX DECIDE SCORE INCREMENT OR NOT
	       JNE COIN_COLLECT_A                                                                                       
	       INC SCORE2                                                                               ;INCREMENT SCORE OF VARIABLE B
	       JMP NEW_COIN_CREATE                             

     COIN_COLLECT_A:
           INVOKE coin_Collect,XPOS2,XCOINPOS,YPOS2,YCOINPOS                                        ; COIN COLLECT OR NOT FOR VARIABLE A
           CMP EAX,1                                                                                ; RETURN EAX DECIDE SCORE INCREMENT OR NOT
           JNE NOT_COLLECTING
	       INC SCORE                                                                                ;INCREMENT SCOREOF VARIABLE A

     NEW_COIN_CREATE:
           CALL CreateRandomCoin                                                                    ; COLLECT COIN ,SCORE INCREMENT, GENERATE NEW COIN

     NOT_COLLECTING:
		   SETCOLOR    
		   JMP GAME_LOOP_2                                                                          ;COIN IS NOT COLLECTING
		
     GAME_OVER1::
	       CLEAR_SCREEN 
	          mov eax,(BLACK*16)+(WHITE)
			 call settextcolor
	       CLEAR_SCREEN                                                                              ; CLEAR-SCREEN
	       NEW_LINE
	       NEW_LINE

           WRITE_STRING 2,15,C_DISPLAY                                                               ; DISPLAY COIN COLLECTOR 
	       NEW_LINE

           WRITE_STRING 8,18,GROUND
		     mov eax,(BLACK*16)+(lightcyan)
			 call settextcolor
           INVOKE score_dwin,ADDR PLAY1,ADDR P1,ADDR VARA,SCORE,38
		     mov eax,(BLACK*16)+(lightred)
			 call settextcolor
           INVOKE score_dwin,ADDR PLAY2,ADDR P2,ADDR VARB,SCORE2,58
           INVOKE Winner_Display,SCORE,SCORE2,ADDR P1,ADDR P2
		   ll1::
         GOTO_XY 26,25
	      MOV EAX, 100
	      DELAY1
	     mov eax, 1000
	     call delay
         XY_COUT 27,25,"DO YO WANT TO PLAY AGAIN? (YES -> 1)"
		 call crlf
		 mov eax,0
		 call readdec
         cmp  eax,1
		 je tryagain
		 jmp GAME_LOOP_2


	EXIT_GAME::
	      exit

	GAME_LOOP_2:
	ret
	CHECK2 ENDP
END main