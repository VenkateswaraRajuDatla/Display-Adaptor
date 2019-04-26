/*Address counter module to write the data into the Buffer1*/
module buf1write(clock,WE1,reset,addrB);
input clock;
input reset;
input WE1;
output [19:0] addrB;
reg [19:0] addrB;

initial
begin
addrB = 20'b0;
end

always@(posedge clock or negedge clock)
begin
if(reset == 1'b1)
begin
addrB <= 20'b000;
end

/*Write into the buffer only if write enable signal is high*/

else if(WE1 == 1'b1 && reset ==0)
begin
addrB <= addrB + 20'b001;
end

end
endmodule
