/*Buffer 1 module*/
module Buf1(dataout1,dout00,dout01,dout02,WData,addr1,addr_read1,WE1,RE1,clock);
output [7:0]dout00;
output [7:0]dout01;
output [7:0]dout02;
output [23:0]dataout1;
input [31:0]WData;
input [19:0]addr1;
input [19:0]addr_read1;
input WE1,RE1,clock;
reg [23:0]SRAM[99:0];//9999 for 100, 99 for 10 pixel
reg [7:0]dout00;
reg [7:0]dout01;
reg [7:0]dout02;
reg [23:0]dataout1;

/*Writing into the Buffer1 */
always@(posedge clock or negedge clock)
begin
if(WE1==1)
SRAM[addr1]<=WData;
end

/*Reading from Buffer1 */

always@ (posedge clock)
begin
if(RE1==1)
begin
dout00=SRAM[addr_read1][7:0];
dout01=SRAM[addr_read1][15:8];
dout02=SRAM[addr_read1][23:16];
end
end
endmodule