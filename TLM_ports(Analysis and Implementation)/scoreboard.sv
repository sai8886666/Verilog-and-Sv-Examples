

class scoreboard extends uvm_scoreboard;

	`uvm_component_utils(scoreboard)                                      // registering the scoreboard class in the factory
  
  	`uvm_analysis_imp_decl(_i_mon)                                        // declaring the user defined analysis implement because of we are connecting the two monitors for scoreboard

  	uvm_analysis_imp_i_mon#(sequence_item,scoreboard)h_ip_scoreboard_imp;        // handle creation for the scoreboard input monitor amalysis implement

  	uvm_analysis_imp#(sequence_item,scoreboard) h_op_scoreboard_imp;             // handle creation for the scoreboard output monitor amalysis implement

	sequence_item h_pkt1,h_pkt2;                                                 // creating the two handles for packet(sequence item) to store data from ip and op monitor
  
  	function new(string name = "scoreboard", uvm_component parent);        // constructing the uvm component
    
    		super.new(name,parent);
    
  	endfunction
    
  	function void build_phase(uvm_phase phase);
    
    	super.build_phase(phase);
    
    	h_ip_scoreboard_imp = new("h_scoreboard_ip_imp",this);             // creating the memory for analysis implement

		h_op_scoreboard_imp = new("h_scoreboard_op_imp",this);
    
		h_pkt1              = new("h_pkt1");                               // creating the memory for packet handles

		h_pkt2              = new("h_pkt2");

    
    		`uvm_info("IN THE  SCOREBOARD CLASS","BUILD PHASE IS DONE",UVM_LOW)
    
  	endfunction

  
  	function void write_i_mon(input sequence_item h_pkt1);

		this.h_pkt1 = h_pkt1;                                               // assigning the data from input monitor packet handle  to the scoreboard packet handle 

	endfunction

	function void write(input sequence_item h_pkt2);

		this.h_pkt2 = h_pkt2;                                               // assigning the data from output monitor packet handle  to the scoreboard packet handle

	endfunction
  
  	task run_phase(uvm_phase phase);
    
    		super.run_phase(phase);
    
    		forever begin
		
			#1;	

			h_pkt1.print();
          
         	//$display("\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ \n",$time,"!!!!!!!!the values in the scoreboard from input monitor are reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_data_out = %0d, fifo_full = %0d, fifo_empty = %0d !!!!!!!!!!!!!!!!!!!!!!!!",h_pkt1.reset,h_pkt1.fifo_write,h_pkt1.fifo_read,h_pkt1.fifo_data_in,h_pkt1.fifo_data_out,h_pkt1.fifo_full,h_pkt1.fifo_empty);
         
			h_pkt2.print();
			
         	//$display($time,"-------the values in the scoreboard from output monitor are reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_data_out = %0d, fifo_full = %0d, fifo_empty = %0d   --------------------------------",h_pkt2.reset,h_pkt2.fifo_write,h_pkt2.fifo_read,h_pkt2.fifo_data_in,h_pkt2.fifo_data_out,h_pkt2.fifo_full,h_pkt2.fifo_empty);
          
 /*         if((h_pkt1.reset   == h_pkt2.reset)&&
             (h_pkt1.fifo_write    == h_pkt2.fifo_write)&&
             (h_pkt1.fifo_read   == h_pkt2.fifo_read)&&
             (h_pkt1.fifo_data_in     == h_pkt2.fifo_data_in)&&
             (h_pkt1.fifo_data_out  == h_pkt2.fifo_data_out)&&
             (h_pkt1.fifo_full   == h_pkt2.fifo_full)&&
             (h_pkt1.fifo_empty   == h_pkt2.fifo_empty) ) begin                           // comparig the ip and op monitor data

             	`uvm_info("/// PASS ////",$sformatf("================PASS ==================\n THE VALUES IN THE INPUT MONITOR   => reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_data_out = %0d, fifo_full = %0d, fifo_empty = %0d\n THE VALUES IN THE OUTPUT MONITOR  => reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_data_out = %0d, fifo_full = %0d, fifo_empty = %0d ",h_pkt1.reset,h_pkt1.fifo_write,h_pkt1.fifo_read,h_pkt1.fifo_data_in,h_pkt1.fifo_data_out,h_pkt1.fifo_full,h_pkt1.fifo_empty,h_pkt2.reset,h_pkt2.fifo_write,h_pkt2.fifo_read,h_pkt2.fifo_data_in,h_pkt2.fifo_data_out,h_pkt2.fifo_full,h_pkt2.fifo_empty),UVM_NONE)
              
			end
		
			else begin
              
             	`uvm_error("/// FAIL ////",$sformatf("================FAIL ==================\n THE VALUES IN THE INPUT MONITOR   => reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_data_out = %0d, fifo_full = %0d, fifo_empty = %0d\n THE VALUES IN THE OUTPUT MONITOR  => reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_data_out = %0d, fifo_full = %0d, fifo_empty = %0d  ",h_pkt1.reset,h_pkt1.fifo_write,h_pkt1.fifo_read,h_pkt1.fifo_data_in,h_pkt1.fifo_data_out,h_pkt1.fifo_full,h_pkt1.fifo_empty,h_pkt2.reset,h_pkt2.fifo_write,h_pkt2.fifo_read,h_pkt2.fifo_data_in,h_pkt2.fifo_data_out,h_pkt2.fifo_full,h_pkt2.fifo_empty))
              
			end*/
          
         	#1;

		end
   
    
    		`uvm_info("IN THE  SCOREBOARD CLASS","RUN PHASE IS DONE",UVM_HIGH)
    
  	endtask
  
endclass
