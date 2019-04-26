/*Module for Pixel Counter*/
module pixelcounter(clock, ResetPx, IncPx,PxOut);
input clock;
input ResetPx;
input IncPx;
output [9:0] PxOut;
reg [9:0] PxOut;

initial
begin
 PxOut=10'b0;
end

always@(posedge clock)
begin
if(ResetPx==1'b1)
PxOut <= 10'b0;

/*Pixelcounter to increment only when IncPx signal recevied from controller */
else if (ResetPx==0 && IncPx==1)
PxOut <= PxOut + 10'b1;
end
endmodule

