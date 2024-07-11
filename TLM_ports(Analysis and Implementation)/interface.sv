
interface inter_face(input logic clock);
  
  	logic reset;
  
  	logic fifo_write;
  
  	logic fifo_read;
  
	logic [31:0] fifo_data_in;
  
    	logic [31:0] fifo_data_out;
  
  	logic fifo_full;
  
	logic fifo_empty;

  	clocking cb_driver@(posedge clock);

		input  #0  fifo_data_out,fifo_full,fifo_empty;

		output reset,fifo_write,fifo_read,fifo_data_in;

	endclocking

  	clocking cb_monitor@(posedge clock);

		input #0  fifo_data_out,fifo_full,fifo_empty;

		input #0  reset,fifo_write,fifo_read,fifo_data_in;

	endclocking

  
endinterface

