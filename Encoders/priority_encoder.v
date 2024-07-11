//--------------- 4 * 2 priority encoder  Design -----------------


/*
case : considers x and z as same as mentioned if it gets exact match the output will be given

casex : considers both x and z as don't care values 

casez : considers z values as don't care (z can be replaced with the ?
*/
module pri_encoder(
  input [3:0]d,
  output reg [1:0]out,
  output reg v
					);
  
  always@(d) begin
    casex(d)
      4'b1000 : begin out = 2'b00; v=1; end
      4'bx100 : begin out = 2'b01; v=1; end
      4'bxx10 : begin out = 2'b10; v=1; end
      4'bxxx1 : begin out = 2'b11; v=1; end
      default : begin $display("invalid bits"); v=0; end
    endcase
  end
endmodule




//************ Test Bench **************************
module tb;
  reg [3:0]d;
  wire [1:0]out;
  wire v;
  
  pri_encoder DUT (.d(d),.out(out),.v(v));
  
  
  initial begin
    //#1;
        $monitor($time,"d %b  ---> out %b **** v %b",d,out,v);
    repeat(15) begin
      d = $random;#1;
    end
  end
  
/*  initial begin
  end*/
  
endmodule
