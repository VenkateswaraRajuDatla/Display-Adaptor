/*The top module for Display Adaptor*/
module topdisplay(clk, reset, CSDisplay,SyncVB,Buf0EMpty,Buf1Empty, Frameout);
output [7:0]Frameout;
input clk;
input reset;
input CSDisplay;
output SyncVB;
output Buf0EMpty;
output Buf1Empty;

/*Defining wires and registers*/

reg [7:0]Frameout;
wire [31:0] WDataw;
wire [19:0]Addrw0;
wire [19:0]Addrw1;
wire [7:0]mux0data0;
wire[7:0]mux0data1;
wire [7:0]mux0data2;
wire [7:0]mux1data0;
wire [7:0]mux1data1;
wire [7:0]mux1data2;
wire [7:0] muxbuf0out;
wire [7:0] muxbuf1out;
wire [9:0]Pxout;
wire[9:0]Lineout;
wire [7:0]frame;
wire IncAddr00;
wire IncAddr11;
wire [19:0]Addrr0;
wire [19:0]Addrr1;

/*Instantiating the multiple modules for data-path*/

counter c1(.clock(clk),.WE0(WE0),.reset(reset),.addrA(Addrw0));

buf1write bf1(.clock(clk),.WE1(WE1),.reset(reset),.addrB(Addrw1));

file_read fr(.WData(WDataw),.clock(clk));

Buf0 buf0(.dataout00(mux0data0),.dataout01(mux0data1),.dataout02(mux0data2),.WData(WDataw),.addr0(Addrw0),.addr_read0(Addrr0),.WE0(WE0),.RE0(RE0),.clock(clk));

Buf1 buf1(.dout00(mux1data0),.dout01(mux1data1),.dout02(mux1data2),.WData(WDataw),.addr1(Addrw1),.addr_read1(Addrr1),.WE1(WE1),.RE1(RE1),.clock(clk));

Bigmux bgmux(.FrameIn(frame),.SelBuf0(SelBuf0),.SelBlank(SelBlank),.SelBuf1(SelBuf1),.MuxBuf0(muxbuf0out),.MuxBuf1(muxbuf1out));

Buf0mux buf0mx (.MuxBuf0(muxbuf0out),.SelR0(SelR0),.SelG0(SelG0),.SelB0(SelB0),.IN0(mux0data2),.IN1(mux0data1),.IN2(mux0data0));

Buf1mux bf1mx(.MuxBuf1(muxbuf1out),.SelR1(SelR1),.SelG1(SelG1),.SelB1(SelB1),.IN0(mux1data2),.IN1(mux1data1),.IN2(mux1data0));

statemachine fsm(.RE0(RE0),.WE0(WE0),.RE1(RE1),.WE1(WE1),.SelR0(SelR0),.SelG0(SelG0),.SelB0(SelB0),
.SelR1(SelR1),.SelG1(SelG1),.SelB1(SelB1),.SelBuf0(SelBuf0),
.SelBlank(SelBlank),.SelBuf1(SelBuf1),.IncPx(IncPx),.ResetPx(ResetPx),.IncLine(IncLine),.ResetLine(ResetLine),
.SyncVB(SyncVB),.Buf0EMpty(Buf0EMpty),.Buf1Empty(Buf1Empty),.IncAddr0(IncAddr00),.ResetAddr0(ResetAddr0),.IncAddr1(IncAddr11),.ResetAddr1(ResetAddr1),
.Pxout(Pxout),.Lineout(Lineout),.CSDisplay(CSDisplay),.clk(clk),.reset(reset));

linecounter l(.clock(clk),.ResetLine(ResetLine),.IncLine(IncLine),.LineOut(Lineout));

pixelcounter p(.clock(clk), .ResetPx(ResetPx), .IncPx(IncPx),.PxOut(Pxout));

Addrcounter a0(.clock(clk),.ResetAddr(ResetAddr0),.IncAddr(IncAddr00),.Addr0(Addrr0));

Addrcounter a1(.clock(clk),.ResetAddr(ResetAddr1),.IncAddr(IncAddr11),.Addr0(Addrr1));

/*Delivering output to the Frame buffer */
always @(posedge clk)
begin
Frameout <= frame;
end

endmodule
