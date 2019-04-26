
module test_counterwrite;
reg clock;
reg reset;
reg WE1;
wire [19:0] addrB;

buf1write bf1(clock,WE1,reset,addrB);

initial
begin
clock=0;
forever#5 clock=~clock;
end

initial
begin
WE1=0;
reset=1;
#5 reset=0;
WE1=1;
//ResetAddr=0;
end

endmodule
