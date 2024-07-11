//---------------- passive_agent ----------------

class passive_agent extends uvm_agent;
	`uvm_component_utils(passive_agent)    //(Factory registratio for component)

//--------- declaring handles for factory registerd components 
dut_monitor dut_handle;
uvm_analysis_export #(sequence_item) psv_agent_export;   //(analysis [pport)

/*------------------------- constructer -------------------------
---- constructor for the factory registersd component ---------*/
		function new(string name = "passive_agent",uvm_component parent);
			super.new(name,parent);
		`uvm_info("passive_agent",$sformatf("-----------apb_passive_agent is constructed ---------"),UVM_LOW);				
		endfunction

/*------------------------- build phase ---------------------------------
----memory allocation for the factory registered component handles-------*/
			function void  build_phase(uvm_phase phase);
				super.build_phase(phase);
				`uvm_info("passive_agent",$sformatf("-----------apb_passive_agent is built ---------"),UVM_MEDIUM);
				dut_handle = dut_monitor :: type_id :: create("dut_handle",this);
				psv_agent_export = new("psv_agent_export",this);
			endfunction


/*--------------------------- connect_phase ---------------------------*/
			function void connect_phase(uvm_phase phase);
				super.connect_phase(phase);
				`uvm_info("passive_agent",$sformatf("-----------apb_passive_agent is connect ---------"),UVM_MEDIUM);
				dut_handle.op_monitor_port.connect(this.psv_agent_export);	//(connecting op_monitor and the agent)
			endfunction
	
endclass
