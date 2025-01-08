INCLUDE MY_MACROS.inc

DrawPlayer PROTO , 
              var1:BYTE,var2:BYTE,var3:BYTE
Game_Over PROTO,
              var1:BYTE,var2:BYTE 
Player_name PROTO,
              var1:PTR BYTE,var2:PTR BYTE,var3:PTR BYTE,var4:BYTE
coin_Collect PROTO,
             var1:BYTE,var2:BYTE,var3:BYTE,var4:BYTE 
Draw_Score PROTO,
              var1:PTR BYTE,var2:PTR BYTE,var3:PTR BYTE,var4:BYTE 
Draw_Border PROTO,
               var1:PTR BYTE       
UpdatePlayer PROTO , 
              var1:BYTE,var2:BYTE
Winner_Display PROTO,
            var1:BYTE,var2:BYTE,var4:PTR BYTE,var5:PTR BYTE
score_dwin PROTO,
             var1:PTR BYTE,var2:PTR BYTE,var3:PTR BYTE,var4:BYTE,var5:BYTE
