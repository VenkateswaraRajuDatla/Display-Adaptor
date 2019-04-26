//`timescale 10ps/1ps;
module DAControllerTest;
wire RE0,WE0,RE1,WE1,SelR0,SelG0,SelR1,SelG1,SelB1,SelBuff0,SelBlank,SelBuff1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1;
reg [9:0]Pxout;
reg [9:0]Lineout;
reg [9:0]VBout;
reg [9:0]AIPout;
reg [9:0]AILout;
reg CSDisplay;
reg clock;
reg reset;

display_controller dac(RE0,WE0,RE1,WE1,SelR0,SelG0,SelR1,SelG1,SelB1,SelBuff0,SelBlank,SelBuff1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1,Pxout,Lineout,VBout,AIPout,AILout,CSDisplay,clock,reset);
initial
begin
clock=0;
forever #5 clock=~clock;
end

initial
begin
#7
CSDisplay=1;
end
endmodule
