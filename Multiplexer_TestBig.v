module Multiplexer_TestBig;
wire[7:0] FrameIn;
reg[7:0] MuxBuf0;
reg[7:0] MuxBuf1;
reg SelBuf0,SelBlank,SelBuf1;
Bigmux m1(FrameIn,SelBuf0,SelBlank,SelBuf1,MuxBuf0,MuxBuf1);
initial
begin
#10
MuxBuf0=8'b110;
MuxBuf1=8'b101;
#10
SelBuf0=1;
SelBuf1=0;
SelBlank=0;
#10
SelBuf0=0;
SelBuf1=1;
SelBlank=0;
#10
SelBuf0=0;
SelBuf1=0;
SelBlank=1;
end
endmodule
