/*Buffer 0 module*/
module Buf0(dataout,dataout00,dataout01,dataout02,WData,addr0,addr_read0,WE0,RE0,clock);
output [7:0]dataout00;
output [7:0]dataout01;
output [7:0]dataout02;
output [23:0]dataout;
input [31:0]WData;
input [19:0]addr0;
input [19:0]addr_read0;
input WE0,RE0,clock;
reg [23:0]SRAM[99:0];//99 for 10 pixel, 9999 for 1000 pixel
reg [7:0]dataout00;
reg [7:0]dataout01;
reg [7:0]dataout02;
reg [23:0]dataout;

/*Writing the data into Buffer0 */
always@(posedge clock or negedge clock)
begin
if(WE0==1)
SRAM[addr0]<=WData;
end

/*Reading the data from Buffer0 */

always@ (posedge clock)
begin
if(RE0==1)
begin
dataout00=SRAM[addr_read0][7:0];
dataout01=SRAM[addr_read0][15:8];
dataout02=SRAM[addr_read0][23:16];
end
end
endmodule
