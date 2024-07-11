

class active_agent extends uvm_component;

	`uvm_component_utils(active_agent);

	sequencer h_sequencer;

	driver h_driver;

	input_monitor h_input_monitor;
  

  uvm_analysis_export#(sequence_item) h_active_agent_export; // analysis export
  

	function new(string name = "active_agent",uvm_component parent);
		super.new(name,parent);
	endfunction
  
  

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		h_sequencer = sequencer::type_id::create("h_sequencer",this);
		h_driver = driver::type_id::create("h_driver",this);
		h_input_monitor = input_monitor::type_id::create("h_input_monitor",this);
		h_active_agent_export = new("h_active_agent_export",this);
		`uvm_info("IN THE ACTIVE AGENT CLASS"," BUILD PHASE IS DONE",UVM_LOW);
	endfunction
  

	function void connect_phase(uvm_phase phase);
		super.build_phase(phase);		
		h_driver.seq_item_port.connect(h_sequencer.seq_item_export);
		h_input_monitor.h_ip_analysis_port.connect(this.h_active_agent_export);
		`uvm_info("IN THE ACTIVE AGENT CLASS"," CONNECT PHASE IS DONE",UVM_MEDIUM);
	endfunction


endclass
