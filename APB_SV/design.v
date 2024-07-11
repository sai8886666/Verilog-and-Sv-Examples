module apb_logi (input pclk,
                  input reset_n,
                  input [31:0]paddress,
                  input pwrite,
                  input pselx,
                  input penable,
                  input [31:0]pwdata,
                  output reg pslverr,                 
                  output reg pready,
                  output reg [31:0]prdata
                  );

reg [31:0]read_only;
reg [31:0]write_only;
reg [31:0]read_write;
reg [31:0]fixed_only=32'hAA;
reg psel1;
reg penable1;
reg [31:0]address1;
reg pwrite1;
reg [31:0]pwdata1;


////////////////////////   LOGIC FOR DATA read and write   //////////////////////////////////////////////
  

always@(posedge pclk)
begin
   read_only<=write_only;
          
   psel1<=pselx;

   penable1<=penable;

   address1<=paddress;

   pwrite1<=pwrite;
  
   pwdata1<=pwdata;

end




always@(posedge pclk)
begin
  

   if(~reset_n)
      begin
      prdata<=0;
      pslverr<=0;
      pready<=0;
      read_only<=0;
      write_only<=0;
      read_write<=0;
      fixed_only=32'hAA;
      end


   else if(penable && pselx && ~penable1 && psel1 &&(pwdata==pwdata1) && (paddress==address1) && (pwrite==pwrite1))
          
    begin


           pslverr<=0;
           pready<=0;
           prdata<=0;    
           case(paddress)

               32'd0:     begin 
                    
                              if(pwrite)
                         
                                    begin
                                    pready<=1;
                                    pslverr<=0;
                                 
                                    end

                             else
      
                                    begin
                                    pready<=1;
                                    prdata<=read_only;
                                    end 
 
                            end



              32'd4:      begin
  
                                if(pwrite)

                                    begin
                                    pready<=1;
                                    read_write<=pwdata;
                                    end
                         
                                else

                                    begin
                                   	pready<=1;

	                                prdata<=read_write;
                                    end

                         end



               32'd8:     begin
                         
                                if(pwrite)

                                    begin
                                    pready<=1;
                                    write_only<=pwdata;
                                    end

                                else
                         
                                    begin
                                    pready<=1; 
                                    pslverr<=1;
                                    prdata<=32'dx;
                                    end

                           end
                    
                         
                     
      
               
               
             32'd12:      begin

                               if(pwrite)

                                    begin
                                    pready<=1;
                                    pslverr<=1;              
                                    end

                               else
 
                                    begin
                                    pready<=1;
                                    prdata<=fixed_only;
                                    end
                          end


             default:     begin
                                   if(pwrite)

                                    begin
                                    pready<=1;
                                    pslverr<=1;              
                                    end

                               else
 
                                    begin
                                    pready<=1;
                                    pslverr<=1;              
                                    prdata<=32'h40;

                                  
                   
													                 end

                       end
              endcase
               
            
      end

  else if( penable && pselx && ~penable1 && psel1 && ((pwdata!=pwdata1) || (paddress!=address1) || (pwrite!=pwrite1)))

            begin
  
             pready<=1;
              pslverr<=1;
	    if(!pwrite1)
		prdata<=32'hx;
           end
   else if( penable && pselx && ~penable1 && ~psel1 )


            begin
  
             pready<=1;
              pslverr<=1;
		 if(!pwrite1)
		prdata<=32'hx;	  
           end

   else if( ~penable)

           begin
        
            pready<=0;
            pslverr<=0;
            prdata<=0;
          end
         

               else

                        begin
                        pready<=0;
                        pslverr<=0;
                        prdata<=0;
                        end               

end



   
endmodule
