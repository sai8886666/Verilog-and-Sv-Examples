
class arrayindex;
  rand bit[15:0] array[];
  
  constraint one {array.size() inside {[5:20]};}
  
  constraint two {foreach(array[i]){
    unique{array};
    if(i%2==0)
      array[i]%2==0;}
                 }
    constraint three {array.sum() with (int'(item)) <1000;}
  
endclass

module tb;
  arrayindex  arr;
  
  initial begin
    repeat(5) begin
    arr = new();
    arr.randomize();
    $display($time," \t array:%p  \n sum:%d ",arr.array,arr.array.sum());
    end
  end
endmodule
