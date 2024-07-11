//**************************** Design *******************************
module dut #(parameter width=5) (clk,reset,din,dout);
  input clk,din,reset;
  output dout;
  reg [width-1:0] r_reg;
  wire [width-1:0] r_next;
  always@(posedge clk)
    begin
      if(!reset) r_reg<={width{1'b0}};
      else
        begin
          r_reg<=r_next;
          $display($time,"clk %b \t reset:%b \t din:%b \t r_reg:%b",clk,din,r_reg);
        end
    end
  assign r_next={din,r_reg[width-1:1]};
  assign dout=r_reg[0];
endmodule


//**************** Test Bench **************************************
module tb;
  reg clk=0,reset,din;
  wire dout;
  always #1 clk++;
  dut #(4)des(clk,reset,din,dout);
  initial begin
    reset=0;
    @(negedge clk) reset=1;din=1;
    @(negedge clk) reset=1;din=0;
    @(negedge clk) reset=1;din=1;
    @(negedge clk) reset=1;din=0;
  end
  initial $monitor($time,"clk=%d,reset=%d,din=%d,dout=%d",clk,reset,din,dout);
  initial #20 $finish;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule 
