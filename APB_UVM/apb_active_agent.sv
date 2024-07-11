// ---------------- active_agent ----------------------

class active_agent extends uvm_agent;
	`uvm_component_utils(active_agent)         //(Factory registration for component)
		

//--------- declaring handles for factory registerd components 
sequencer  sequencer_handle;
driver     driver_handle;
input_monitor ip_monitor_handle;
uvm_analysis_export #(sequence_item) active_agent_export;  //(analysisis port)

/*------------------- constructor phase--------------------------
---- constructor for the  factory registered component ----------*/
	function new(string name = "active_agent",uvm_component parent);
		super.new(name,parent);
		`uvm_info("active_agent",$sformatf("-----------apb_active_agent is constructed ---------"),UVM_LOW);		
	endfunction

/*---------------- build phase ----------------------------------
----memory allocation for the factory registered component handles-------*/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("active_agent",$sformatf("-----------apb_active_agent is built ---------"),UVM_MEDIUM);
			sequencer_handle	= sequencer		:: type_id :: create("sequencer_handle",this);
			driver_handle		= driver		:: type_id :: create("driver_handle",this);	
			ip_monitor_handle	= input_monitor	:: type_id :: create("ip_monitor_handle",this);
			active_agent_export = new ("active_agent_export",this);				
	endfunction

/*--------------- connect_phase --------------------------------*/
		function void  connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		`uvm_info("active_agent",$sformatf("-----------apb_active_agent is connect ---------"),UVM_MEDIUM);
			driver_handle.seq_item_port.connect(sequencer_handle.seq_item_export);         //(connecting between driver and sequencer)
			ip_monitor_handle.ip_monitor_port.connect(this.active_agent_export);             //(connecting between ip_monitor and actie agent)
		endfunction

endclass
