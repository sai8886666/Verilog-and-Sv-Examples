
class env extends uvm_env;

	`uvm_component_utils(env);

	active_agent h_active_agent;

	passive_agent h_passive_agent;

	scoreboard h_scoreboard;

//	coverage h_coverage;


	function new(string name = "", uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		h_active_agent = active_agent::type_id::create("h_active_agent",this);

		h_passive_agent = passive_agent::type_id::create("h_passive_agent",this);

		h_scoreboard = scoreboard::type_id::create("h_scoreboard",this);

		//h_coverage = coverage::type_id::create("h_coverage",this);

		`uvm_info("IN THE ENV CLASS ","BUILD PHASE IS DONE",UVM_LOW);


	endfunction

	function void connect_phase(uvm_phase phase);

		super.connect_phase(phase);

		h_active_agent.h_active_agent_export.connect(h_scoreboard.h_ip_scoreboard_imp);

		//h_active_agent.h_active_agent_export.connect(h_coverage.h_coverage_analysis_imp);

		h_passive_agent.h_passive_agent_export.connect(h_scoreboard.h_op_scoreboard_imp);

		`uvm_info("IN THE ENV CLASS ","CONNECT PHASE IS DONE",UVM_MEDIUM);

	endfunction



endclass
