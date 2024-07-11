
class driver extends uvm_driver#(sequence_item);
  
  	`uvm_component_utils(driver)                                  // registering the driver class in the factory
  
  	virtual inter_face h_intf;                                    // handle creation for the virtual interface instance
  
  	function new(string name = "driver", uvm_component parent);    // constructing the uvm component
    
    		super.new(name,parent);
    
  	endfunction
  
  	function void connect_phase(uvm_phase phase);
    
    		super.connect_phase(phase);
    
    		assert(uvm_config_db#(virtual inter_face)::get(null,this.get_full_name,"vintf",h_intf));  // getting the VIRTUAL interface handle using config db  from the top
    
    		`uvm_info("IN THE  DRIVER CLASS","CONNECT PHASE IS DONE",UVM_MEDIUM)
    
  	endfunction
  
  	task run_phase(uvm_phase phase);
    
    		super.run_phase(phase);

		$display($time,"RUN PHASE IN DRIVER");

		req = sequence_item::type_id::create("req");
    
    		forever@(h_intf.cb_driver) begin
      
      			seq_item_port.get_next_item(req);

			$display($time,"###############################the values in the driver are reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_data_out = %0d, fifo_full = %0d, fifo_empty = %0d ########################",req.reset,req.fifo_write,req.fifo_read,req.fifo_data_in,req.fifo_data_out,req.fifo_full,req.fifo_empty);
      
      			h_intf.cb_driver.reset         <= req.reset;
          
         		h_intf.cb_driver.fifo_read     <= req.fifo_read;
          
          		h_intf.cb_driver.fifo_data_in  <= req.fifo_data_in;
          
          		h_intf.cb_driver.fifo_write    <= req.fifo_write;
        
      			seq_item_port.item_done();
      
    		end
    
    		`uvm_info("IN THE DRIVER  CLASS","RUN PHASE IS DONE",UVM_FULL)
    
  	endtask
  
  
endclass
