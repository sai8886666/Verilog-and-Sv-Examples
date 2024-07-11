
class prime;
  randc int queue[$];
  int a;
  
  constraint one {a==func;}
  
  
  function int func;
    int count;
    for(int i=2;i<200;i++)
      begin
      for(int j=1;j<i;j++)
        begin
        if(i%j==0) count++;
      	end
        if(count==1)
          queue.push_back(i);
          count=0;
    end
    
  endfunction
endclass

module tb;
  prime p;
  
  initial begin
    p = new();
    p.randomize();
    $display("\t queue:%p",p.queue);
  end
endmodule
