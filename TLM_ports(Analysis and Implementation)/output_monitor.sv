
class output_monitor extends uvm_component;
  
  	`uvm_component_utils(output_monitor)                                 // registering the output_monitor class in the factory
  
  uvm_analysis_port#(sequence_item) h_op_analysis_port;                    // CREATING THE HANDLE FOR THE OUTPUT MONITOR  ANALYSIS PORT
  
  	virtual inter_face h_intf;                                            // handle creation for the virtual interface instance

  	sequence_item h_pkt;                                                         // creating the memory for packet handle
  
  	function new(string name = "output_monitor", uvm_component parent);    // constructing the uvm component
    
    		super.new(name,parent);
    
  	endfunction
    
  	function void build_phase(uvm_phase phase);
    
    		super.build_phase(phase);
    
    		h_op_analysis_port = new("h_op_analysis_port",this);               // creating the memory for analysis port
    
    		h_pkt                 = new("h_pkt");                               // creating the memory for packet handles
    
    		`uvm_info("IN THE  OUTPUT MONITOR CLASS","BUILD PHASE IS DONE",UVM_LOW)
    
  	endfunction
  
  	function void connect_phase(uvm_phase phase);
    
    		super.connect_phase(phase);

		$display($time,"CONNECT PHASE IN OUTPUT MONITOR");
    
    		assert(uvm_config_db#(virtual inter_face)::get(null,this.get_full_name(),"vintf",h_intf));     // getting the VIRTUAL interface handle using config db  from the top
    
    		`uvm_info("IN THE  OUTPUT MONITOR CLASS","CONNECT PHASE IS DONE",UVM_MEDIUM)
    
  	endfunction
  
  	task run_phase(uvm_phase phase);
    
    		super.run_phase(phase);

		$display($time,"RUN PHASE IN OUTPUT MONITOR");
    
    		forever@(h_intf.cb_monitor) begin
      
      			h_pkt.reset         = h_intf.cb_monitor.reset;  
        
			h_pkt.fifo_write    = h_intf.cb_monitor.fifo_write; 
        	
			h_pkt.fifo_read     = h_intf.cb_monitor.fifo_read;
        
			h_pkt.fifo_data_in  = h_intf.cb_monitor.fifo_data_in;
        
			h_pkt.fifo_data_out = h_intf.cb_monitor.fifo_data_out; 
        
			h_pkt.fifo_full     = h_intf.cb_monitor.fifo_full; 

        		h_pkt.fifo_empty    = h_intf.cb_monitor.fifo_empty;


			$display($time,"$$$$$$$$$$$$$$$$$$$$$$$the values in the output monitor are reset = %0d, fifo_write = %0d, fifo_read = %0d, fifo_data_in = %0d, fifo_data_out = %0d, fifo_full = %0d, fifo_empty = %0d $$$$$$$$$$$$$$$$$$",h_pkt.reset,h_pkt.fifo_write,h_pkt.fifo_read,h_pkt.fifo_data_in,h_pkt.fifo_data_out,h_pkt.fifo_full,h_pkt.fifo_empty);
      
      			h_op_analysis_port.write(h_pkt);
      
    		end
    
    		`uvm_info("IN THE  OUTPUT MONITOR CLASS","RUN PHASE IS DONE",UVM_FULL)
    
  	endtask
  
  
endclass
