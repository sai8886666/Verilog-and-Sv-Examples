// 2D Dimensional ARRAY
//       Square Matrix 3*3

class two_dim;
  rand bit [7:0] my_arr[][];
  
  constraint done { my_arr.size() == 3;}
  
  constraint two {
    				foreach(my_arr[i]) 
                      my_arr[i].size() ==3;}
  constraint three {
    				foreach(my_arr[i,j])
                      my_arr[i][j] inside {[1:10]};}
endclass

module tb;
  two_dim td;
  
  initial begin
    td = new();
    td.randomize();
    foreach(td.my_arr[i,j]) begin
      $display($time,"my_arr[%0d][%0d] = %0d ",i,j,td.my_arr[i]);
    end
  end
endmodule 
