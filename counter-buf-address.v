/*Address counter module to write the data into the Buffer0*/
module counter(clock,WE0,reset,addrA);
input clock;
input reset;
input WE0;
output [19:0] addrA;
reg [19:0] addrA;

initial
begin
addrA = 20'b0;
end

always@(posedge clock or negedge clock)
begin
if(reset == 1'b1)
begin
addrA <= 20'b000;
end

/*Write into the buffer only if write enable signal is high*/

else if(WE0 == 1'b1 && reset ==0)
begin
addrA <= addrA + 20'b001;
end

end
endmodule
