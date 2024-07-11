module mod5 #(parameter timer =3) (input clk,reset,output[2:0]count);
  reg [2:0]pre_state,next_state;
  reg [2:0]count_pre,count_next;
  
  reg [2:0]temp_cout;
  
  localparam s0=3'd0,s1=3'd1,s2=3'd2,s3=3'd3,s4=3'd4;
  
  
  always@(posedge clk or negedge reset) begin
    if(!reset) begin
      pre_state <= s0;
      count_pre <= 1'b0;
      temp_cout <= 1'b0;
    end
    else begin
      pre_state <= next_state;
      count_pre <= count_next;  
      $display($time,"------count_pre:%d",count_pre);
    end
  end
  
  always@(*) begin
    next_state = pre_state;
    count_next = count_pre;
    $display($time,"count_pre:%d",count_pre);

    case(pre_state)
      s0 :
        begin
          temp_cout = 3'd0;
          if(count_pre == timer -1'b1)
        	begin
              next_state = s1;
              count_next = 1'b0;
      		end
     		else
              begin
              next_state = s0;
              count_next = count_pre + 1'b1;  
              end
        end
      s1 : 
        begin
         temp_cout = 3'd1;
          if(count_pre == timer -1'b1)
        	begin
              next_state = s2;
              count_next = 1'b0;
      		end
     		else
              begin
              next_state = s1;
              count_next = count_pre + 1'b1;                
              end  
        end
      s2 : 
        begin
          temp_cout = 3'd2;
          if(count_pre == timer -1'b1)
        	begin
              next_state = s3;
              count_next = 1'b0;
      		end
     		else
              begin
              next_state = s2;
              count_next = count_pre + 1'b1;                
              end 
        end
      s3 : 
        begin
          temp_cout = 3'd3;
          if(count_pre == timer -1'b1)
        	begin
              next_state = s4;
              count_next = 1'b0;
      		end
     		else
              begin
              next_state = s3;
              count_next = count_pre + 1'b1;                
              end  
        end
      s4 : 
        begin
          temp_cout = 3'd4;
          if(count_pre == timer -1'b1)
        	begin
              next_state = s0;
              count_next = 1'b0;
      		end
     		else
              begin
              next_state = s4;
              count_next = count_pre + 1'b1;                
              end  
        end
    endcase
  end
  
    assign count = temp_cout;
    

endmodule





//*************************** Test Bench ****************************
module tb;
  reg clk=0,reset;
  wire [2:0]count;
  
  always #2 clk = ~clk;
  
  mod5 #(5) DUT (clk,reset,count);
  
  initial begin
    reset = 1'b0;
    #4;
    reset = 1'b1;
    #140;
    reset = 1'b0;
    #10;
    reset = 1'b1;
  end
  
  initial begin
    $monitor($time,"\t clk:%d reset:%d count:%d",clk,reset,count);
    #350; $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule
