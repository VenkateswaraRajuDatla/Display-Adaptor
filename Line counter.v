/*Module for line counter*/
module linecounter(clock,ResetLine,IncLine,LineOut);
input clock;
input ResetLine;
input IncLine;
output [9:0] LineOut;
reg [9:0] LineOut;

initial
begin
 LineOut=10'b0;
end

always@(posedge clock)
begin
if(ResetLine==1'b1)
LineOut <= 10'b0;
/*Line counter to increment only when IncLine signal received from the controller */

else if (ResetLine==0 && IncLine==1)
LineOut <= LineOut + 10'b1;
end
endmodule

