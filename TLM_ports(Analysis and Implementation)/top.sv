
`include"package.sv"

module top;

	import pkg::*;
  
  	import uvm_pkg::*;
  
  	bit clock;                                // declaration of clock
  
  	always #1 clock++;                        // clock generation
  	  
  	inter_face h_intf(clock);                 // interface instance
  
 	fifo_module DUV ( 	. clock(clock),
                             . reset(h_intf.reset),
                             . fifo_write(h_intf.fifo_write),
                             . fifo_read(h_intf.fifo_read),
                             . fifo_data_in(h_intf.fifo_data_in),
                             . fifo_data_out(h_intf.fifo_data_out),
                             . fifo_full(h_intf.fifo_full),
                             . fifo_empty(h_intf.fifo_empty) ) ;

/*	assert_module ASSERTION_INSTANCE ( 	. clock(clock),
                             . reset(h_intf.reset),
                             . fifo_write(h_intf.fifo_write),
                             . fifo_read(h_intf.fifo_read),
                             . fifo_data_in(h_intf.fifo_data_in),
                             . fifo_data_out(h_intf.fifo_data_out),
                             . fifo_full(h_intf.fifo_full),
                             . fifo_empty(h_intf.fifo_empty) ) ;*/

//		bind fifo_module assert_module ASSERTION_INSTANCE ( .*);
  
  	initial begin
    
    		uvm_config_db#(virtual inter_face)::set(null,"uvm_test_top.*","vintf",h_intf);		// setting the interface using config db
    
    		run_test();                             						// calling the run test
  	end

endmodule
