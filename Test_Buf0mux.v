module Multiplexer_TestBuf0;
wire[7:0] MuxBuf0;
reg[7:0] IN0;
reg[7:0] IN1;
reg[7:0] IN2;
reg SelR0,SelG0,SelB0;
Buf0mux m1(MuxBuf0,SelR0,SelG0,SelB0,IN0,IN1,IN2);
initial
begin
#10
IN0=8'b01;
IN1=8'b10;
IN2=8'b11;
#10
SelR0=1;
SelG0=0;
SelB0=0;
#10
SelR0=0;
SelG0=1;
SelB0=0;
#10
SelR0=0;
SelG0=0;
SelB0=1;
end
endmodule
