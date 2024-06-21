
class sequence1;
  randc bit [7:0] arr[];
  
  constraint one {arr.size() inside {[20:30]};}
  constraint two {
    			foreach(arr[i]){
                  if(i%2==0) arr[i] ==0;
                  else if(i==1) arr[i] ==1;
                  else if(i%19==0) arr[i] ==1;
                  else
                    arr[i] == arr[i-2] +1;}
  					}
endclass
                  
            module tb;
              sequence1 s;
              
              initial begin
                s = new();
                s.randomize();
                $display("\t   arr:%p",s.arr,s.arr.size());
              end
            endmodule