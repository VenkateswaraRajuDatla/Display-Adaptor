module file_read(WData, clock);
/*Module to read the data from file and load it into memory*/
input clock;
reg [100:1] file_name;
output reg [31:0] WData;
reg [31:0] RAM [199:0];
reg[7:0] counter;
integer file;
integer i = 0;
//2000 for 100
//200 for 10
//11111010000
initial begin
	$readmemb("image.txt", RAM);
	counter <= 8'b11111111;
end


always@(clock)
begin
if(counter == 8'b11001000) counter <= 8'b11111111;
else
begin
	counter = counter + 1;
	WData = RAM[counter];
end
end

endmodule  

