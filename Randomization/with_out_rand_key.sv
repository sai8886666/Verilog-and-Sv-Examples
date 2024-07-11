

class base;
  int arr[];
  
  
  function new();
    arr = new[5];
    for(int i=0; i<=arr.size();i++)
      arr[i] = i*i;
    arr.shuffle();
  endfunction
  
endclass

module tb;
  base h_b;
  
  initial begin
    h_b = new();
    $display("%p",h_b.arr);
  end
endmodule
