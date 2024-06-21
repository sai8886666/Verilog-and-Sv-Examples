

class seq;
  randc bit[4:0] arr[$];
  
  constraint one {arr.size() inside {[10:20]};}
  
  constraint two {
    foreach(arr[i]) 
      if(i%3==0 || i%3==1)
        arr[i] ==0;
    else if (i%3==2)
      arr[i] == (i+1)/3;
  		}
endclass

module tb;
  seq s;
  
  initial begin
    s = new();
    s.randomize();
    $display(" \t arr:%p",s.arr);
  end
endmodule