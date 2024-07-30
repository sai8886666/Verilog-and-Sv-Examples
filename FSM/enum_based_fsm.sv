/*------------------------------------------------------------------
            Sequence_detector = 11101 mealy overlap
---------------------------------------------------------------------*/
module fsm (input clk,reset,in,output reg out);
  typedef enum logic [2:0] {one,two,three,four,five} state;
  
  state pre_state,next_state;
  
  always_ff@(posedge clk or negedge reset) begin
    if(!reset)
      pre_state <= one;
    else
      pre_state <= next_state;
  end
  
  always_comb begin
    case(pre_state)
      one : begin
        next_state = in ? two : one;
        out = 1'b0; 
      end
      two : begin
        next_state = in ? three : one;
        out = 1'b0; 
      end
      three : begin
        next_state = in ? two : four;
        out = 1'b0; 
      end
      four : begin
        next_state = in ? two : one;
        out = in ? 1'b1 : 1'b0; 
      end 
      default : begin
        next_state = one;
        out = 0;
      end
    endcase
  end
  
endmodule



// Code your testbench here
// or browse Examples
module tb;
  reg clk=0,reset,in;
  wire out;
  
  always #5 clk = ~clk;
  
  fsm DUT (clk,reset,in,out);
  
  initial begin
    reset = 0;
    #5;
    reset = 1;
    @(negedge clk) 	  in=1;
    @(negedge clk)    in=1;
    @(negedge clk)    in=0;
    @(negedge clk)    in=1;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    #100; $finish;
  end
endmodule
