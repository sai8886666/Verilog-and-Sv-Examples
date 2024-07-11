//*********************************
class base;
  randc bit[4:0]data;
  randc bit[7:0] addr1;
  randc bit[7:0] addr2;
  
  constraint range {data = restrict(addr1,addr2);}
  
  function bit [4:0] restrict(bit[7:0]addr1,addr2);
    if((addr1<100) && (addr2>200))
      	data%2==0;
    return data;
  endfunction
  
endclass

//**********************************
module tb;
  base b;
  
  initial begin
    b = new();
    b.randomize();
    $display("data:%d \t addr1:%d \t addr2:%d",b.data,b.addr1,b.addr2);
  end
  
endmodule
