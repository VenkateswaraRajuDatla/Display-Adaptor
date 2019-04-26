/*Module for the controller - implemented a Moore state machine using Case statements*/

module statemachine(RE0,WE0,RE1,WE1,SelR0,SelG0,SelB0,SelR1,SelG1,SelB1,SelBuf0,SelBlank,SelBuf1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1,Pxout,Lineout,CSDisplay,clk,reset);
output RE0,WE0,RE1,WE1,SelR0,SelG0,SelB0,SelR1,SelG1,SelB1,SelBuf0,SelBlank,SelBuf1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1;
reg RE0, WE0,RE1,WE1,SelR0,SelG0,SelB0,SelR1,SelG1,SelB1,SelBuf0,SelBlank,SelBuf1,IncPx,ResetPx,IncLine,ResetLine,SyncVB,Buf0EMpty,Buf1Empty,IncAddr0,ResetAddr0,IncAddr1,ResetAddr1;
input [9:0]Pxout;
input [9:0]Lineout;
reg [9:0]VBout;
reg [9:0] HBout;
reg [9:0]AIPout;
reg [9:0]AILout;
input CSDisplay;
input clk;
input reset;
wire [9:0]Pxout;
wire[9:0]Lineout;

/*Instantiating the Address, Pixel and Line counters*/
linecounter l(.clock(clk),.ResetLine(ResetLine),.IncLine(IncLine),.LineOut(Lineout));
pixelcounter p(.clock(clk), .ResetPx(ResetPx), .IncPx(IncPx),.PxOut(Pxout));
Addrcounter a0(.clock(clk),.ResetAddr(ResetAddr0),.IncAddr(IncAddr0));
Addrcounter a1(.clock(clk),.ResetAddr(ResetAddr1),.IncAddr(IncAddr1));

/*Defining the local paramters for all the states*/
localparam [4:0] // for 39 states : size_state = 4:0
    Start0 = 5'd0, VB0R = 5'd1, VB0G= 5'd2, VB0B = 5'd3, RVB0R = 5'd4, RVB0G = 5'd5, RVB0B = 5'd6, SWTCH0= 5'd7, R0 = 5'd8, G0 = 5'd9, B0 = 5'd10,
 RR0 = 5'd11, RG0 = 5'd12, RB0 = 5'd13, LR0 = 5'd14, LG0 = 5'd15, LB0 = 5'd16, RLR0 = 5'd17, RLG0 = 5'd18, RLB0 = 5'd19,
Start1 = 5'd20, VB1R = 5'd21, VB1G = 5'd22, VB1B = 5'd23, RVB1R  = 5'd24, RVB1G = 5'd25, RVB1B = 5'd26, SWTCH1 = 5'd27, R1= 5'd28, G1=5'd29, B1= 5'd30,
RR1 = 5'd31, RG1 = 5'd32, RB1 = 5'd33, LR1 = 5'd34, LG1 = 5'd35, LB1 = 5'd36, RLR1 = 5'd37, RLG1 = 5'd38, RLB1=5'd39;
    
reg[4:0] state_reg, state_next;

/*Assigning intial value for diferent paramaters*/
initial
begin

state_reg <= Start0;
assign VBout = 10'b10;
assign AIPout = 10'b1010;//currently 10, change to 100 for 100 pixel
assign AILout = 10'b1010; //currently 10, change to 100 for 100 pixel
assign HBout = 10'b0;
RE1=0;
RE0=0;
IncPx = 0;
IncLine=0;
SelBuf0=0;
SelBuf1=0;
SelR0=0;
SelG0=0;
SelB0=0;
SelR1=0;
SelG1=0;
SelB1=0;
SelBlank=0;
IncPx=0;
SyncVB=0;
ResetPx=0;
IncAddr0=0;
IncAddr1=0;
ResetAddr0=0;
ResetAddr1=0;
IncLine=0;
ResetLine=0;
Buf0EMpty=0;
Buf1Empty = 0;
end

/*Defining the conditions for reset and state transition*/
always @(posedge clk,posedge reset)
begin
    if (reset) begin
        state_reg <= Start0;
    end
    else begin
        state_reg <= state_next;
    end
end 

/*Defining the Case statement for differnt states and their parameters*/
always @(state_reg, CSDisplay)
begin 
   state_next = state_reg; // default state_next if(CSDiplay==1)
case({state_reg,CSDisplay})

/*The Start state for Buffer 0*/
        {Start0,1'b1} : begin
		RE1=0;
		RE0=0;
		IncPx = 0;
		IncLine=0;
		SelBuf0=0;
		SelBuf1=0;
		SelR0=0;
		SelG0=0;
		SelB0=0;
		SelR1=0;
		SelG1=0;
		SelB1=0;
		SelBlank=0;
		WE0=1;
		WE1=1;
		@(posedge clk);
		begin
		SelBlank=1;
		Buf1Empty=1;
		SyncVB=1;
		end
                state_next = VB0G; 
		end
/*Start of Vertical Blanking*/

	{VB0R, 1'b1}:begin
        		IncPx = 0;
			IncLine=0;
			ResetPx=0;
			ResetLine=0;
			SyncVB=0;
			SelBlank=1;
			Buf1Empty=1;
			state_next = VB0G;
			end

        {VB0G, 1'b1} : begin
            	SelBlank=1;
		Buf1Empty=1;
		SyncVB=0;
		IncPx = 0;
                state_next = VB0B; 
        	end

        {VB0B, 1'b1} : begin
			SelBlank=1;
			ResetPx=0;
			IncPx = 1; //increment pixel counter by 1
			if(Pxout<AIPout-2) //HBout + AIPout-2
			state_next= VB0R;
			else 
			state_next = RVB0R;
			end
		
/*Last Pixel of the line  */    
	{RVB0R, 1'b1} : begin
			SelBlank=1;
			state_next=RVB0G;
			IncPx = 0;
			end

	{RVB0G, 1'b1} : begin
			SelBlank = 1;
			IncPx = 0;
			if(Lineout<VBout-1)
			state_next=RVB0B;
			else
			state_next=SWTCH0;
			end

	{RVB0B, 1'b1} : begin
			SelBlank=1;
			ResetPx=1;
			ResetLine=0;
			IncLine=1;
			state_next = VB0R;
			end
/*Switch to active image once vertical blanking is complete*/

	{SWTCH0,1'b1}: begin
			ResetPx=1;
			ResetLine=1;
			SelBlank=1;
			WE0=0;
			RE0=1;
			state_next=R0;
			end
/*Reading the active image starts */

	{R0,1'b1}:	begin
			IncPx=0;
			IncLine=0;
			ResetPx=0;
			ResetLine=0;
			SelR0=1;
			SelB0=0;
			SelBlank=0;
			SelBuf0=1;
			RE0=1;
			state_next=G0;
			end

	{G0,1'b1}:	begin
			SelR0=0;
			SelG0=1;
			SelBuf0=1;
			RE0=1;
			ResetAddr0=0;
			IncAddr0=1;
			state_next=B0;
			end

	{B0,1'b1}:	begin
			ResetPx=0;
			IncPx=1;
			IncAddr0=0;
			SelG0=0;
			SelB0=1;
			SelBuf0=1;
			RE0=1;
			if(Pxout<AIPout-2)
			state_next=R0;
			else
			state_next=RR0;
			end
/*Last pixel of the line*/

	{RR0,1'b1}:	begin
			IncPx=0;
			SelB0=0;
			SelR0=1;
			SelBuf0=1;
			RE0=1;
			state_next=RG0;
			end
	{RG0,1'b1}:	begin
			SelR0=0;
			SelG0=1;
			SelBuf0=1;
			IncAddr0=1;
			RE0=1;
			state_next=RB0;
			end

	{RB0,1'b1}:	begin
			ResetPx=1;
			ResetLine=0;
			IncLine=1;
			IncAddr0=0;
			SelG0=0;
			SelB0=1;
			SelBuf0=1;
			if(Lineout<AILout-2)
			state_next=R0;
			else
			state_next=LR0;
			end

	{LR0,1'b1}: begin
			SelB0=0;
			SelR0=1;
			ResetPx=0;
			IncPx=0;
			IncLine=0;
			SelBuf0=1;
			RE0=1;
			state_next=LG0;
			end

	{LG0,1'b1}:begin
			SelR0=0;
			SelG0=1;
			SelBuf0=1;
			RE0=1;
			ResetAddr0=0;
			IncAddr0=1;
			state_next=LB0;
				end

	{LB0,1'b1}:begin
			ResetPx=0;
			IncPx=1;
			SelG0=0;
			SelB0=1;
			IncAddr0=0;
			SelBuf0=1;
			RE0=1;
			if(Pxout<AIPout-2)
			state_next=LR0;
			else
			state_next=RLR0;
			end
/*Last Pixel of the last line in active image*/

	{RLR0,1'b1}:	begin
			IncPx=0;
			SelB0=0;
			SelR0=1;
			SelBuf0=1;
			RE0=1;
			state_next=RLG0;
			end

	{RLG0,1'b1}:	begin
			SelR0=0;
			SelG0=1;
			SelBuf0=1;
			RE0=1;
			ResetAddr0=1;
			state_next=RLB0;
			end

	{RLB0,1'b1}:	begin
			ResetLine=1;
			ResetPx=1;
			ResetAddr0=0;
			SelG0=0;
			SelB0=1;
			SelBuf0=1;
			state_next = Start1;
			end
/*Buffer0 execution complete*/
/*Buffer1 execution starts*/

	{Start1,1'b1} : begin
			IncPx = 0;
			IncLine=0;
			ResetPx=0;
			ResetLine=0;
			SelBuf0=0;
			SelBuf1=0;
			SelR0=0;
			SelG0=0;
			SelB0=0;
			SelR1=0;
			SelG1=0;
			SelB1=0;
			RE0=0;
			//WE1=1;
			SelBlank=1;
			Buf0EMpty=1;
			SyncVB=1;
               		state_next = VB1G; 
			end
/*Vertical Blanking starts*/

	{VB1R, 1'b1}:	begin
        		IncPx = 0;
			IncLine=0;
			ResetPx=0;
			ResetLine=0;
			SyncVB=0;
			SelBlank=1;
			Buf0EMpty=1;
			state_next = VB1G;
			end

        {VB1G, 1'b1} : begin
            		SelBlank=1;
			Buf0EMpty=1;
			SyncVB=0;
			IncPx = 0;
                	state_next = VB1B; 
        		end

        {VB1B, 1'b1} : begin
			SelBlank=1;
			ResetPx=0;
			IncPx = 1; //increment pixel counter by 1
			if(Pxout<AIPout-2) //HBout + AIPout-2
			state_next= VB1R;
			else 
			state_next = RVB1R;
			end
		     
	{RVB1R, 1'b1} : begin
			SelBlank=1;
			state_next=RVB1G;
			IncPx = 0;
			end

	{RVB1G, 1'b1} : begin
			SelBlank = 1;
			IncPx = 0;
			if(Lineout<VBout-1)
			state_next=RVB1B;
			else
			state_next=SWTCH1;
			end

	{RVB1B, 1'b1} : begin
			SelBlank=1;
			ResetPx=1;
			ResetLine=0;
			IncLine=1;
			state_next = VB1R;
			end
/*Vertical blanking ends and switch to active image*/

	{SWTCH1,1'b1}: begin
			ResetPx=1;
			ResetLine=1;
			SelBlank=1;
			WE1=0;
			RE1=1;
			state_next=R1;
			end

/*Active image starts*/
	{R1,1'b1}:	begin
			IncPx=0;
			IncLine=0;
			ResetPx=0;
			ResetLine=0;
			SelB1=0;
			SelR1=1;
			SelBlank=0;
			SelBuf1=1;
			RE1=1;
			state_next=G1;
			end

	{G1,1'b1}:	begin
			SelR1=0;
			SelG1=1;
			SelBuf1=1;
			RE1=1;
			ResetAddr1=0;
			IncAddr1=1;
			state_next=B1;
			end

	{B1,1'b1}:	begin
			ResetPx=0;
			IncPx=1;
			IncAddr1=0;
			SelG1=0;
			SelB1=1;
			SelBuf1=1;
			RE1=1;
			if(Pxout<AIPout-2)
			state_next=R1;
			else
			state_next=RR1;
			end
	
	{RR1,1'b1}:	begin
			IncPx=0;
			SelB1=0;
			SelR1=1;
			SelBuf1=1;
			RE1=1;
			state_next=RG1;
			end

	{RG1,1'b1}:	begin
$display("THe value of test after is rg1");
		//end
			SelR1=0;
			SelG1=1;
			IncAddr1=1;
			SelBuf1=1;
			RE1=1;
			state_next=RB1;
			end

	{RB1,1'b1}:	begin
			RE1=1;
			ResetPx=1;
			ResetLine=0;
			IncLine=1;
			IncAddr1=0;
			SelG1=0;
			SelB1=1;
			SelBuf1=1;
			if(Lineout<AILout-2)
			state_next=R1;
			else
			state_next=LR1;
				end

	{LR1,1'b1}: begin
			SelB1=0;
			SelR1=1;
			ResetPx=0;
			IncPx=0;
			IncLine=0;
			SelBuf1=1;
			RE1=1;
			state_next=LG1;
			end

	{LG1,1'b1}:begin
			SelR1=0;
			SelG1=1;
			SelBuf1=1;
			RE1=1;
			ResetAddr1=0;
			IncAddr1=1;
			state_next=LB1;
			end

	{LB1,1'b1}:begin
			ResetPx=0;
			IncPx=1;
			SelG1=0;
			SelB1=1;
			IncAddr1=0;
			SelBuf1=1;
			RE1=1;
			if(Pxout<AIPout-2)
			state_next=LR1;
			else
			state_next=RLR1;
			end
/*Last pixel of the last line*/

	{RLR1,1'b1}:	begin
			IncPx=0;
			SelB1=0;
			SelR1=1;
			SelBuf1=1;
			RE1=1;
			state_next=RLG1;
			end

	{RLG1,1'b1}:	begin
			SelR1=0;
			SelG1=1;
			SelBuf1=1;
			RE1=1;
			ResetAddr1=1;
			state_next=RLB1;
			end

	{RLB1,1'b1}:	begin
			ResetLine=1;
			ResetPx=1;
			ResetAddr1=0;
			SelG1=0;
			SelB1=1;
			SelBuf1=1;
			state_next = Start0;    /*Buffer1 execution is complete and routed to the start of Buffer0.*/
			end
		
    endcase

end 
endmodule            
