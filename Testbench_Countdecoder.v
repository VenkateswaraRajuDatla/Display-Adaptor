
module test_pixelcounter;
reg clock;
reg reset;
reg IncPx;
wire [9:0] PxOut;
pixelcounter p1(clock, reset, IncPx, PxOut);

initial
begin
clock=0;
forever#5 clock=~clock;
end

initial
begin
IncPx=0;
reset=1;
#5 reset=0;
IncPx=1;
end

endmodule
