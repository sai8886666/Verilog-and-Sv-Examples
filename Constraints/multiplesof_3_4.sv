class transaction;
  
  randc bit[5:0] data1 [];
  randc bit[5:0] data2 [];
  
  constraint r { data1.size() >5; data1.size() <10;
                 data2.size() >5; data2.size() <10;}
 
  constraint range{
    foreach(data1[i]){
      (data1[i]%3==0 || data1[i]%4==0);}
  					}
  constraint range1{
    foreach (data2[i]){
      (data2[i]%3==0 || data2[i]%4==0);}
  					}

  
endclass


module con;
  transaction tr_h;
  
  initial begin
    tr_h = new();
    repeat(20) begin
      
      tr_h.randomize();
      $display($time,"\t \t data1:%p \t \t data2:%p",tr_h.data1,tr_h.data2);
    end
  end
endmodule
