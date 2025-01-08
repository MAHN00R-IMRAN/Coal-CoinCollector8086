INCLUDE Coin_Procedure.inc

.data
C_DISPLAY   BYTE  " ",0ah,0dh
     BYTE  "                 ____   ____               ____   ____               ____  _____   ____    ___       ",0ah,0dh
     BYTE  "                |      |    |  | |\  |    |      |    | |     |     |        |    |    |  |___|      ",0ah,0dh
     BYTE  "                |      |    |  | | \ |    |      |    | |     |     |----    |    |    |  | \         ",0ah,0dh
     BYTE  "                |____  |___|  | |  \|    |__   |___| |__  |____ |____    |    |____|  |  \        ",0
	 GROUND  BYTE "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *",0
SCORE BYTE 0                   ;for vara
SCORE2 BYTE 0                  ;for varb
N BYTE "ENTER NAME : ",0
P1 DWORD 20 DUP(?)             ;for vara
P2 DWORD 20 DUP(?)             ;for varb name
PLAY1 BYTE " PLAYER:1 ",0
PLAY2 BYTE " PLAYER:2 ",0
VARB BYTE "B",0
XPOS BYTE 10    ;for varb
YPOS BYTE 15
VARA BYTE "A",0
XPOS2 BYTE 15    ;for vara
YPOS2 BYTE 27
XCOINPOS BYTE 5
YCOINPOS BYTE 15
INPUT_CHAR BYTE ?
CHAR1 BYTE ?

.code
main PROC
	tryagain::
	SETCOLOR
	CALL CLRSCR

	WRITE_STRING 10,25,C_DISPLAY                               ; DISPLAY COIN COLLECTOR 

	INVOKE Player_name,ADDR N,ADDR P1,ADDR PLAY1,20               ; PLAYER:1 NAME
	INVOKE Player_name,ADDR N,ADDR P2,ADDR PLAY2,22               ; PLAYER:2 NAME
	
	mov eax,1000                                             ; DELAY
	CALL DELAY

	 SETCOLOR     
	 CALL CLRSCR
     
	 NEW_LINE
	 XY_COUT 1,25,"----- COIN COLLECTOR ----- "
		
	
        INVOKE Draw_Border, ADDR GROUND                       ; PROCEDURE CALL TO DISPLAY BORDER
        INVOKE Draw_Score,ADDR PLAY1,ADDR P1,ADDR VARA,10          ; DRAW SCORE OF VARA
		INVOKE Draw_Score,ADDR PLAY2,ADDR P2,ADDR VARB,15        ; DRAW SCORE OF VARB
		
	INVOKE DrawPlayer , XPOS , YPOS  , VARB                 ; DRAW PLAYER VARB
	INVOKE DrawPlayer, XPOS2 , YPOS2 , VARA                ; DRAW PLAYER VARA
	call CreateRandomCoin                                    ; CREATE RANDOMCOIN                                        
	mov ecx,07FFFFFFFh
gameLoop: 
        push ecx
		XY_COUTINT 11,97,SCORE
		XY_COUTINT 16,97,SCORE2
        call CHECK 
        call CHECK2
		pop ecx
		dec ecx
		cmp ecx,0
		ja gameloop
		jmp gameoverj


		exit
main ENDP

CreateRandomCoin PROC
	mov eax,70
	inc eax
	call RandomRange
	cmp al,1
	jbe ljj
	mov XCOINPOS,al
	jmp l1
	ljj:
	mov XCOINPOS,15
	l1:
	mov eax,28
	call RandomRange
	cmp al,3
	jbe lu
	mov YCOINPOS,al
	jmp lv
	lu:
	mov YCOINPOS,15
	lv:
	mov eax,yellow (black * 16) ;coin color set
	call SetTextColor
	 GOTO_XY YCOINPOS,XCOINPOS
	WRITE_CHAR 'O'
	ret
CreateRandomCoin ENDP

CHECK PROC
pushad
	  onGround:
		CHAR_CIN INPUT_CHAR
		cmp INPUT_CHAR,"6"
		je exitGame

		cmp INPUT_CHAR,"i"
		jne d1
		    INVOKE UpdatePlayer,XPOS , YPOS  
			dec YPOS
			INVOKE  DrawPlayer,XPOS , YPOS  , VARB
			jmp S_DISPLAY
		d1:
		cmp INPUT_CHAR,"m"
		jne d2
		   INVOKE UpdatePlayer,XPOS , YPOS  
		   inc YPOS
		   INVOKE  DrawPlayer,XPOS, YPOS  , VARB
		   jmp S_DISPLAY
        d2:
		cmp INPUT_CHAR,"j"
		jne d3
		    INVOKE UpdatePlayer,XPOS , YPOS  
		    dec XPOS
		    INVOKE  DrawPlayer,XPOS, YPOS  , VARB
			jmp S_DISPLAY
		d3:
		cmp INPUT_CHAR,"l"
		jne d4
		    INVOKE UpdatePlayer,XPOS ,YPOS 
		    inc XPOS
		    INVOKE  DrawPlayer,XPOS , YPOS , VARB
			jmp S_DISPLAY
		d4:
		cmp INPUT_CHAR,"w"
		jne d5
		    INVOKE UpdatePlayer,XPOS2 , YPOS2
			dec YPOS2
			INVOKE  DrawPlayer,XPOS2 , YPOS2 , VARA
			jmp S_DISPLAY
		d5:
		cmp INPUT_CHAR,"z"
		jne d6
		    INVOKE UpdatePlayer,XPOS2 , YPOS2
	     	inc YPOS2
	    	INVOKE  DrawPlayer,XPOS2, YPOS2 ,  VARA
			jmp S_DISPLAY
		d6:
		cmp INPUT_CHAR,"a"
		jne d7
		   	INVOKE UpdatePlayer,XPOS2 , YPOS2
	     	dec XPOS2
		    INVOKE  DrawPlayer,XPOS2 , YPOS2 ,  VARA
			jmp S_DISPLAY
		d7:
		cmp INPUT_CHAR,"d"
		jne onGround
		    INVOKE UpdatePlayer,XPOS2 , YPOS2
		    inc XPOS2
		    INVOKE  DrawPlayer,XPOS2 , YPOS2 ,  VARA
			jmp S_DISPLAY
S_DISPLAY:
popad
ret
CHECK ENDP
CHECK2 PROC

    INVOKE Game_Over,XPOS , YPOS                             ; GAMEOVER PROCEDURE VARB
   	cmp eax,"***"
   	je gameoverj 
   	INVOKE Game_Over,XPOS2 , YPOS2                          ; GAMEOVER PROCEDURE VARA    
	cmp eax,"***"
	je gameoverj
		                                
    INVOKE coin_Collect,XPOS,XCOINPOS,YPOS,YCOINPOS          ; COIN COLLECT OR NOT FOR VARB
	cmp eax,1
	jne b4                                                        ; RETURN EAX DECIDE SCORE INCREMENT OR NOT
	inc SCORE2
	jmp b3

	 b4:
		INVOKE coin_Collect,XPOS2,XCOINPOS,YPOS2,YCOINPOS  ; COIN COLLECT OR NOT FOR VARB
		cmp eax,1                                                 ; RETURN EAX DECIDE SCORE INCREMENT OR NOT
		jne notcollecting
		inc SCORE

	 b3:
		call CreateRandomCoin                                ; COLLECT COIN ,SCORE INCREMENT, GENERATE NEW COIN

    notCollecting:
		SETCOLOR    
		jmp gameLoop2
		;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    gameoverj::
	    call clrscr
	   SETCOLOR
	    call clrscr                                              ; CLEAR-SCREEN
	call crlf
	call crlf

	WRITE_STRING 2,15,C_DISPLAY                               ; DISPLAY COIN COLLECTOR 
	

	call crlf

	
	WRITE_STRING 8,18,ground
	INVOKE score_dwin , ADDR PLAY1 , ADDR P1 , ADDR  VARA, SCORE,38
	INVOKE score_dwin , ADDR PLAY2 , ADDR P2 , ADDR  VARB , SCORE2,58
	INVOKE Winner_Display ,SCORE,SCORE2,ADDR P1,ADDR P2
	mov eax, 1000
	call delay
     XY_COUT 27,25,"DO YO WANT TO PLAY AGAIN? (Y/N)"
	 mov dh,27
	 mov dl,60
	 call gotoxy
	 mov eax,0
		call readchar
		call writechar

	    cmp  al,'y'
		je tryagain
	    cmp  al,'Y'
		je tryagain
	exitgame::
	   exit
	gameLoop2:
	ret
	CHECK2 ENDP
END main