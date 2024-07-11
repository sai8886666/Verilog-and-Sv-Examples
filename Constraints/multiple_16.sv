class mul_16_s;
  randc bit [6:0] data; 
  
  constraint range{
    data%16==0 && (data/16)%2==1; 
  					}
endclass

module ex;
  mul_16_s tr_h;
  
  initial begin
    tr_h = new();
    repeat(10) begin
      tr_h.randomize();
      $display($time," \t \t data :%d",tr_h.data);
      
    end
  end
endmodule
