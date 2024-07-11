module pos(in,clk,out);
  input in;
  input clk;
  output reg out;
  reg prevsig;
  
  
  always @(posedge clk) begin
    prevsig <= in;
  end
  
  assign out = in & !prevsig;
  
endmodule
