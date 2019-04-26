/*Multiplexer module for Buffer0*/

module Buf0mux(MuxBuf0,SelR0,SelG0,SelB0,IN0,IN1,IN2);
input SelR0,SelG0,SelB0;
input [7:0]IN0;
input [7:0]IN1;
input [7:0]IN2;
output [7:0]MuxBuf0;
reg [7:0]MuxBuf0;

/*The select signals are received from the controller and accordingly the multiplexer gives output*/

always @(MuxBuf0 or SelR0 or SelG0 or SelB0 or IN0 or IN1 or IN2)
begin
   if(SelR0==1 && SelG0==0 && SelB0==0)
      MuxBuf0=IN0;
   else if( SelR0==0 && SelG0==1 && SelB0==0)
      MuxBuf0=IN1;
else if(SelR0==0 && SelG0==0 && SelB0==1)
MuxBuf0 = IN2;
end

endmodule
