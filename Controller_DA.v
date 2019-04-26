module display_controller(RE0,WE0,RE1,WE1,SelR0,SelG0,SelR1,SelG1,SelB1,SelBuff0,SelBlank,SelBuff1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1,Pxout,Lineout,VBout,AIPout,AILout,CSDisplay,clock,reset);
output RE0,WE0,RE1,WE1,SelR0,SelG0,SelR1,SelG1,SelB1,SelBuff0,SelBlank,SelBuff1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1;
reg RE0, WE0,RE1,WE1,SelR0,SelG0,SelR1,SelG1,SelB1,SelBuff0,SelBlank,SelBuff1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1;

input [9:0]Pxout;
input [9:0]Lineout;
input [9:0]VBout;
input [9:0]AIPout;
input [9:0]AILout;
input CSDisplay;
input clock;
input reset;

always @(posedge clock)
begin
if(CSDisplay<=1'b1)
begin
//State : Start with Buffer 
SelBlank=1;
Buf1Empty=1;
SyncVB=1;
end
end
always @(SyncVB)
begin
SyncVB=0;
end
endmodule

