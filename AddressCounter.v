/*Address counter module for providing addresses to read from Buffer 0 & Buffer 1.*/
module Addrcounter(clock, ResetAddr,IncAddr,Addr0);
input clock;
input ResetAddr;
input IncAddr;
output [19:0] Addr0;
reg [19:0] Addr0;

initial
begin
 Addr0=20'b0;
end

always@(posedge clock)
begin
if(ResetAddr==1'b1)
Addr0 <= 10'b0;

/*Addrress counter to be incremented only when IncAddr signal received from the controller*/

else if (ResetAddr==0 && IncAddr==1)
Addr0 <= Addr0 + 10'b1;
end
endmodule

