
typedef enum {s0,s1,s2,s3}states;
class invalid;
  randc states sa;
  logic a;
  randc bit ctrl;
  
  constraint unknown {if(ctrl) sa inside {s2,s3};
                      else       sa inside {s0,s1};}
  
  function void post_randomize;
    case(sa)
      s0 : a= '0;
      s1 : a='1;
      s2 : a='x;
      s3 : a='z;
    endcase
  endfunction
  
endclass

module tb;
  
  invalid in;
  initial begin
    repeat(10) begin
    in = new();
    in.randomize();
    $display("%d",in.a);
    end
  end
endmodule
