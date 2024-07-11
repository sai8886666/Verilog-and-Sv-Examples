//**************** Design **************************
module dut #(parameter width)(clk,reset,din,dout);
  input clk,reset,din;
  output[width-1:0] dout;
  reg [width-1:0] r_reg;
  wire [width-1:0] r_next;
  always@(posedge clk)
    begin
      if(reset) r_reg<={width{1'b0}};
      else r_reg<=r_next;
    end
  assign r_next={din,r_reg[width-1:1]};
  assign dout=r_reg;
endmodule

//******************* Test Bench *********************
module tb;
  reg clk=0,reset,din;
  wire [3:0]dout;
  always #1 clk++;
  dut #(4)des(clk,reset,din,dout);
  initial begin
    reset=1;
    @(negedge clk) reset=0;din=1;
    @(negedge clk) reset=0;din=0;
    @(negedge clk) reset=0;din=1;
    @(negedge clk) reset=0;din=0;
  end
  initial $monitor($time,"clk=%d,reset=%d,din=%d,dout=%b",clk,reset,din,dout);
  initial #20 $finish;
  
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule  
