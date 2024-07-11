
class test extends uvm_test;

	`uvm_component_utils(test)

	env h_env;
	sequence1 h_seq;

	function new(string name = "", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		h_env = env::type_id::create("h_env",this);
		h_seq = new("h_seq");
		`uvm_info("IN THE TEST CLASS ","BUILD PHASE IS DONE",UVM_LOW);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);       
		//uvm_top.print_topology();                                   // printing the total uvm structure
		print();
		//uvm_top.enable_print_topology=1;
		`uvm_info("IN THE TEST CLASS","END OF ELABORATION  PHASE IS DONE",UVM_HIGH)
	endfunction
  

	task run_phase(uvm_phase phase);    
    		super.run_phase(phase);
		phase.raise_objection(this,"TEST OBJECTION IS RAISED");
		h_seq.start(h_env.h_active_agent.h_sequencer);              // initiating the cammunication between sequnce and sequencer
		#20;	
		phase.drop_objection(this,"TEST OBJECTION IS DROPPED");		
      `uvm_info("IN THE TEST CLASS","RUN PHASE IS DONE",UVM_MEDIUM);   
  	endtask

endclass
