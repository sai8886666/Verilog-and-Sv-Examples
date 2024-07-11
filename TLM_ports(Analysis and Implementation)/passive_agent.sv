
class passive_agent extends uvm_component;

	`uvm_component_utils(passive_agent)                                // registering the passive_agent class in the factory
  
  	output_monitor h_output_monitor;           // handle creation for the output monitor class

  	uvm_analysis_export#(sequence_item) h_passive_agent_export;    // handle creation for the passive agent analysis export
  
  	function new(string name = "passive_agent", uvm_component parent); // constructing the uvm component
      super.new(name,parent);
  	endfunction
  
  
  	function void build_phase(uvm_phase phase);   
    		super.build_phase(phase);
    		h_output_monitor       = output_monitor::type_id::create("h_output_monitor",this);   //allocating the memory for output monitor class handle using the create method
		h_passive_agent_export = new("h_passive_agent_export",this);                         // creating the memory for passsive agent analysis export  
    		`uvm_info("IN THE  PASSIVE AGENT CLASS","BUILD PHASE IS DONE",UVM_LOW)   
  	endfunction
  
  	function void connect_phase(uvm_phase phase); 
    		super.connect_phase(phase);    
		h_output_monitor.h_op_analysis_port.connect(this.h_passive_agent_export);              // connecting the output monitor analysis port to the passive agent analysis export    
    		`uvm_info("IN THE  PASSIVE AGENT  CLASS","CONNECT PHASE IS DONE",UVM_MEDIUM)    
  	endfunction

endclass
