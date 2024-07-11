module tb;
  reg in,clk;
  wire out;
  
  initial clk = 0;
  
  always #1 clk = ~clk;
  
  //pos DUT (in,clk,out);   //for posedge detection
  //neg DUT (in,clk,out);   //for negedge detection
  dual_edge DUT (in,clk,out);   //for dual edge detection
  
  initial begin
    #2;
    @(negedge clk) in = 0;
    @(negedge clk) in = 1;
    @(negedge clk) in = 1;
    @(negedge clk) in = 1;    
    @(negedge clk) in = 0;
    @(negedge clk) in = 1;
  end
  
  initial begin
    $monitor($time,"\t clk:%b in:%b out:%b",clk,in,out);
    #30; $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule
