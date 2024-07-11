//------------------- environment -------------------------


class environment extends uvm_env;
	`uvm_component_utils(environment)

//--------- declaring handles for factory registerd components 
active_agent  ag_handle;
passive_agent pg_handle;
scoreboard     sc_handle;
coverage      cov_handle;

/*------------------------- constructer -------------------------
---- constructor for the factory registersd component ---------*/
		function new(string name = "environment",uvm_component parent);
			super.new(name,parent);
		`uvm_info("environment",$sformatf("-----------apb_environment is constructed ---------"),UVM_LOW);				
		endfunction

/*--------------------------- build phase --------------------------------
----memory allocation for the factory registered component handles-------*/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("environment",$sformatf("-----------apb_environment is built ---------"),UVM_MEDIUM);
			ag_handle		= active_agent		:: type_id :: create("active_agent",this);
			pg_handle		= passive_agent		:: type_id :: create("pg_handle",this);	
			sc_handle       = scoreboard        :: type_id :: create("sc_handle",this);
			cov_handle      = coverage          :: type_id :: create("cov_handle",this);
	endfunction

/*--------------------------- connect_phase ---------------------------*/
			function void connect_phase(uvm_phase phase);
				super.connect_phase(phase);
				`uvm_info("environment",$sformatf("-----------apb_environment is connect ---------"),UVM_MEDIUM);
					ag_handle.active_agent_export.connect(sc_handle.score_ipmon);    //(connecting the active agent and scoreboard)
					pg_handle.psv_agent_export.connect(sc_handle.score_opmon);		//(connecting the passive agent and scorecard)
					ag_handle.active_agent_export.connect(cov_handle.cov_imp);		//(from active agent taking the values to coverage)
			endfunction



endclass
