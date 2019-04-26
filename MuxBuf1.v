/*Mutliplexer module for Buffer1*/
module Buf1mux(MuxBuf1,SelR1,SelG1,SelB1,IN0,IN1,IN2);
input SelR1,SelG1,SelB1;
input [7:0]IN0;
input [7:0]IN1;
input [7:0]IN2;
output [7:0]MuxBuf1;
reg [7:0]MuxBuf1;

/*The select signals are received from the controller and accordingly the multiplexer gives output*/
always @(MuxBuf1 or SelR1 or SelG1 or SelB1 or IN0 or IN1 or IN2)
begin
   if(SelR1==1 && SelG1==0 && SelB1==0)
      MuxBuf1=IN0;
   else if( SelR1==0 && SelG1==1 && SelB1==0)
      MuxBuf1=IN1;
else if(SelR1==0 && SelG1==0 && SelB1==1)
MuxBuf1 = IN2;
end

endmodule
