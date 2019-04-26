`timescale 10ps/1ps;
module Buf0_Test;
wire [7:0]dataout00;
wire [7:0]dataout01;
wire [7:0]dataout02;
wire [23:0]dataout;
reg [31:0]WData;
reg [19:0]addr0;
reg WE0,RE0,clock;
MemoryA m(dataout,dataout00,dataout01,dataout02,WData,addr0,WE0,RE0,clock);
initial
begin
clock=1;
forever #5 clock=~clock;
end
initial
begin
WE0=1;
RE0=0;
addr0=20'b000;
WData=32'b10101010;
#10
addr0=20'b001;
WData=32'b10101111;
#10
WE0=0;
RE0=1;
addr0=20'b000;
#10
addr0=20'b001;
end
endmodule
