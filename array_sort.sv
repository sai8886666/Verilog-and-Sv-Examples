module tb;
  int array[$] = {50,25,18,74,33,55};
  int temp;
  
  
  
  initial begin
    for(int i=0;i<array.size();i++)begin
      for(int j=i+1;j<array.size();j++)begin
        if(array[j]<array[i])begin
          temp = array[i];
    	  array[i] = array[j];
    	  array[j] = temp;
        end
      end
    end
  end  
 
  
  
  initial begin
   // array.sort();  //using sort method
    $display("array=%p size:%d",array,array.size());
  end
  
endmodule 