`timescale 1us / 1us
`include "top.v"

module top_tb;

  // Inputs
  reg clk=0, echo=0;

  // Outputs
  wire trig, led1, led2, led3;

  // Instantiate the Unit Under Test (UUT)
top UUT(clk, echo, trig, led1, led2, led3);

always #1 clk=!clk;


initial begin
	$dumpfile("top_tb.vcd");
	$dumpvars(0,top_tb);
	
	#25 echo=1;
	#15 echo=0;
	#1 echo=0;
	#120 echo=1;
	#7 echo=0;
	#1 echo=0;
	#40 echo=1;
	#15 echo=0;
	#1 echo=0;
	#120 echo=1;
	#7 echo=0;
	#1 echo=0;
	    // Display 
    $display("test completd!");
	#150 $finish();
end
endmodule