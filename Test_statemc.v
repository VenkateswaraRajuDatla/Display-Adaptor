module test_FSM;
wire SelBlank;
wire Buf0EMpty;
wire Buf1Empty;
wire SyncVB;
reg CSDisplay,clk,reset;
wire [9:0]Pxout;
wire [9:0]Lineout;

//statemachine sm1(RE0,WE0,RE1,WE1,SelR0,SelG0,SelR1,SelG1,SelB1,SelBuff0,.SelBlank(SelBlank),SelBuff1,.IncPx(IncPx),.ResetPx(ResetPx),.IncLine(IncLine),.ResetLine(ResetLine),.SyncVB(SyncVB),.Buf0EMpty(Buf0EMpty),Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1,.Pxout(PxOut),.Lineout(LineOut),.CSDisplay(CSDisplay),.clk(clk),.reset(reset));
//linecounter l(.clock(clk),.ResetLine(ResetLine),.IncLine(IncLine),.LineOut(Lineout));
//pixelcounter p(.clock(clk), .ResetPx(ResetPx), .IncPx(IncPx),.PxOut(Pxout));

statemachine sm1(RE0,WE0,RE1,WE1,SelR0,SelG0,SelB0,SelR1,SelG1,SelB1,SelBuf0,SelBlank,SelBuf1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1,Pxout,Lineout,CSDisplay,clk,reset);

initial
begin
clk=0;
forever #5 clk=~clk;
end

initial
begin
reset=1;
#4 reset=0;
#3
CSDisplay=1;
end
endmodule
