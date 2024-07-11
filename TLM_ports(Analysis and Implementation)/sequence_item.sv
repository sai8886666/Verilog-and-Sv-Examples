
class sequence_item extends uvm_sequence_item;
  
  `uvm_object_utils(sequence_item)

  	rand bit reset;
  
  	randc bit fifo_write;
  
  	rand bit fifo_read;
  
  	rand bit [7:0] fifo_data_in;
  
  	bit [7:0] fifo_data_out;

  	bit fifo_empty;
  
  	bit fifo_full;

  
  /*	`uvm_object_utils_begin(packet)                  // registering the packet in the factory


		`uvm_field_int(reset,UVM_ALL_ON)

		`uvm_field_int(fifo_write,UVM_ALL_ON)

		`uvm_field_int(fifo_read,UVM_ALL_ON)

		`uvm_field_int(fifo_data_in,UVM_ALL_ON|UVM_UNSIGNED)

		`uvm_field_int(fifo_data_out,UVM_ALL_ON|UVM_UNSIGNED)

		`uvm_field_int(fifo_empty,UVM_ALL_ON)

		`uvm_field_int(fifo_full,UVM_ALL_ON)




	`uvm_object_utils_end*/
  

  
  	function new(string name = "sequence_item");       // constructing the uvm object
    
    		super.new(name);
    
  	endfunction
  
endclass
  
  
  
