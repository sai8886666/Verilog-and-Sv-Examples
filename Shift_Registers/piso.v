//*********************** Design ********************************

module dut #(parameter width)(clk,reset,load,din,dout);
  input clk,reset,load;
  input [width-1:0] din;
  output reg dout;
  reg [width-1:0] r_reg;
  //reg [width-1:0] r_next;
  always@(posedge clk)
    begin
      if(reset) r_reg={width{1'b0}};
      else if(load) begin
        r_reg=din;
        $display($time,"din=%b",din);
      end
      else begin
        $display($time,"r_reg=%d",r_reg);
        dout=r_reg[0];
        r_reg={1'b0,r_reg[width-1:1]};
        $display($time,"dout=%d",dout);
      end
        
    end
endmodule


//**************************** Test Bench **************************
module tb;
  reg clk=0,reset;
  reg [3:0]din;
  reg load;
  wire dout;
  always #1 clk++;
  dut #(4)des(clk,reset,load,din,dout);
  initial begin
    reset=1;
    @(negedge clk) reset=0;load=1;din=4'b0101;
    @(negedge clk) reset=0;load=0;din=4'b1111;
    
  end
  initial $monitor($time,"clk=%d,reset=%d,din=%b,dout=%b",clk,reset,din,dout);
  initial #20 $finish;
endmodule
