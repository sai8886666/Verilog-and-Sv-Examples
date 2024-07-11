//------------------ test class -------------------

class test extends uvm_test;
	`uvm_component_utils(test)
	sequence1 seq1_handle;     //(sequence1 handle)
	//virtual apb_intf h_intf_test;   //(test interface instance)
	//apb_config cfg;     // config classs

//--------- declaring handles for factory registerd components 
	environment env_handle;

/*------------------------- constructer -------------------------
---- constructor for the factory registersd component ---------*/
		function new(string name = "test",uvm_component parent);
			super.new(name,parent);
		`uvm_info("test",$sformatf("-----------apb_test is constructed ---------"),UVM_LOW);				
		endfunction

/*--------------------------- build phase --------------------------------
----memory allocation for the factory registered component handles-------*/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("test",$sformatf("-----------apb_test is built ---------"),UVM_MEDIUM);
			env_handle		= environment		:: type_id :: create("env_handle",this);
		//cfg = apb_config :: type_id :: create("cfg",this);             //create mempry for config clss
	endfunction

/*-------------------------------- connect phase --------------------------------*/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);		
		// uvm_config_db #(virtual apb_intf) :: set (null,"uvm_env.*","interf",h_intf_test);               // using configdb in test 
	        // uvm_config_db #(apb_config) :: set (null,"uvm_env.ag_handle.ip_monitor_handle","key1",cfg);      //setting the config class at the top
	endfunction


/*------------------------- end of eloboration phase -----------------*/
			function void end_of_elaboration_phase(uvm_phase phase);
				uvm_top.print_topology();
			endfunction


//-------------- Run Phase -------------------------
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			`uvm_info("test",$sformatf("--------apb_test run_phase----------"),UVM_NONE);
			seq1_handle = sequence1	:: type_id :: create("seq1_handle");
		//	esq_handle  = error_sequence :: type_id :: create("error_sequence");

					phase.raise_objection(this,"raise_objection");
						seq1_handle.start(env_handle.ag_handle.sequencer_handle);
					#10;
					phase.drop_objection(this,"drop_objection");			
		endtask




endclass
