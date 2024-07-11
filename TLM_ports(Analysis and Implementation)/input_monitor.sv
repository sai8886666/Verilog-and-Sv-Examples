
class input_monitor extends uvm_component;
  
  	`uvm_component_utils(input_monitor)                                  // registering the input_moniotor class in the factory
  
  uvm_analysis_port#(sequence_item) h_ip_analysis_port;                     // CREATING THE HANDLE FOR THE INPUT MONITOR  ANALYSIS PORT
  
  	virtual inter_face h_intf;                                           // handle creation for the virtual interface instance

  	sequence_item h_trans;                                                        // creating the memory for packet handle
  
  	function new(string name = "input_monitor", uvm_component parent);    // constructing the uvm component
    
    		super.new(name,parent);
    
  	endfunction
    
  	function void build_phase(uvm_phase phase);
    
    		super.build_phase(phase);
    
    		h_ip_analysis_port = new("h_ip_analysis_port",this);               // creating the memory for analysis port
    
      		h_trans = new("h_trans");                                               // creating the memory for packet handles
    
    		`uvm_info("IN THE  INPUT MONITOR CLASS","BUILD PHASE IS DONE",UVM_LOW)
    
  	endfunction
  
  	function void connect_phase(uvm_phase phase);
    
    		super.connect_phase(phase);
    
    		assert(uvm_config_db#(virtual inter_face)::get(null,this.get_full_name(),"vintf",h_intf));   // getting the VIRTUAL interface handle using config db  from the top
    
    		`uvm_info("IN THE  INPUT MONITOR CLASS","CONNECT PHASE IS DONE",UVM_MEDIUM)
    
  	endfunction
  
  	task run_phase(uvm_phase phase);
    
    		super.run_phase(phase);
    
    		forever@(h_intf.cb_monitor) begin


			h_trans.reset          = h_intf.cb_monitor.reset;

			h_trans.fifo_write     = h_intf.cb_monitor.fifo_write;

			h_trans.fifo_read      = h_intf.cb_monitor.fifo_read;

			h_trans.fifo_data_in   = h_intf.cb_monitor.fifo_data_in;
  
			self_check();

			$display($time,"@@@@@@@@@@@@@@@@@@@@@@@@the values in the input monitor are reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_dat_out = %0d, fifo_full = %0d, fifo_empty = %0d @@@@@@@@@@@@@@@@@@@@@@",h_trans.reset,h_trans.fifo_write,h_trans.fifo_read,h_trans.fifo_data_in,h_trans.fifo_data_out,h_trans.fifo_full,h_trans.fifo_empty);

			h_ip_analysis_port.write(h_trans);
      
    		end
    
    		`uvm_info("IN THE  INPUT MONITOR CLASS","RUN PHASE IS DONE",UVM_FULL)
    
  	endtask

	task self_check();



	endtask
  
endclass
