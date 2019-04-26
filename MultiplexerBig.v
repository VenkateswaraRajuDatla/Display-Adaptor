module Bigmux(FrameIn,SelBuf0,SelBlank,SelBuf1,MuxBuf0,MuxBuf1);

input SelBuf0,SelBlank,SelBuf1;
input [7:0]MuxBuf0;
input [7:0]MuxBuf1;
output [7:0]FrameIn;
reg [7:0]FrameIn;

always @( SelBuf0 or SelBlank or SelBuf1 or MuxBuf0 or MuxBuf1 )
begin
   if(SelBuf0==1 && SelBuf1==0 && SelBlank==0)
      FrameIn = MuxBuf0;
   else if( SelBuf0==0 && SelBuf1==1 && SelBlank==0)
      FrameIn = MuxBuf1;
else if(SelBuf0==0 && SelBuf1==0 && SelBlank==1)
FrameIn = 8'b0;
end

endmodule
