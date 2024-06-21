
class exam;
  rand bit [2:0] a;
  int queue[$];
  randc bit[2:0]b;
  
  constraint range {!(a inside {queue});
                    unique {queue};
                   }
  
  function void post_randomize();
    queue.push_back(a);
    if(queue.size()==10)
      queue.delete();
  endfunction
  
endclass


module tb;
  exam em;
 
  initial begin
    repeat(8) begin
    em = new();
    
    em.randomize();
      $display($time,"\t a:%d   rand :%d",em.a,em.b);
    end
  end
endmodule