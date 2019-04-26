/*The test-bench for top module*/

module test_topdisplay;
wire [7:0]Frameout;
wire Buf0EMpty;
wire Buf1Empty;
wire SyncVB;
reg CSDisplay,clk,reset;
integer f,i;
wire [7:0]frame;

/*Instantiating the top module*/

topdisplay td1(clk,reset,CSDisplay,SyncVB,Buf0EMpty,Buf1Empty,Frameout);

/*Generating the clock signals*/

initial
begin
clk=0;
forever #5 clk=~clk;
end

/*Generating the CSDisplay*/

initial
begin
reset=1;
CSDisplay=0;
#4 reset=0;
#3
CSDisplay=1;
end

/*Writing the output to a text file*/ 

initial 
begin
    f = $fopen("output.txt","w");
    @(posedge clk);   
    for (i = 0; i<360; i=i+1) begin
      @(posedge clk);
      $fwrite(f,"%b\n",  Frameout);
    end
 $fclose(f);  
  end

endmodule
