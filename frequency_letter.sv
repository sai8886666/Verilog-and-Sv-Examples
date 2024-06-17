module tb;
  string str = "diksha";
  int accos[string];
  string b;
  
  
  initial begin
  foreach(str[i]) begin
    b = string'(str[i]);
    $display("\t b:%s",b);
    if(accos.exists(b))
    accos[b] = accos[b]+1;
  else
    accos[b] = 1;
  end
  
  end
  initial 
    $display("accos=%p",accos);
  

endmodule

