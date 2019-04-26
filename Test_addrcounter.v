
module test_addrcounter;
reg clock;
reg reset;
reg IncAddr;
wire [19:0] Addr0;

Addrcounter ac(.clock(clock),.ResetAddr(reset),.IncAddr(IncAddr),.Addr0(Addr0));

initial
begin
clock=0;
forever#5 clock=~clock;
end

initial
begin
IncAddr=0;
reset=1;
#5 reset=0;
IncAddr=1;
//ResetAddr=0;
end

endmodule
