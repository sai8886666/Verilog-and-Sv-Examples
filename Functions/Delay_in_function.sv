
module tb;
  reg [2:0]a;
  reg [2:0]b;
  reg  [4:0]out;
  
  function void sum;
    fork
    out = a+b;
    #100;
      $display("*****************out:%b",out);
    join_none
    $display("**----------******out:%b",out);
  endfunction
  
  initial begin
    a=10;
    b=3; 
  end
  
  initial begin
    sum;
  end
endmodule
