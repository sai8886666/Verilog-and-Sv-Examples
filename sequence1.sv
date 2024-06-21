


class array;
  rand reg [0:10]arr1;
  
 /* constraint range {
    				arr1.size() == 14;
  					}*/
  
  constraint range1 {
    				foreach(arr1[i])
                      if(i%4==0 || i%4==1)
                      {
                        arr1[i]==1;
                      }
                        else
                        {
                          if(i%4==2 || i%4==3)
                          {
                            arr1[i] == 0;
                          }
                        }
                            
  						}
endclass


module tb;
  array arr;
  
  initial begin
    arr = new();
    //arr.constraint_mode(0);
    arr.randomize();
    $display("%b",arr.arr1);
  end
  
endmodule