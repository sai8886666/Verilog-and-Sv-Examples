
class coverage extends uvm_component;
  
  	`uvm_component_utils(coverage)                                   // registering the coverage class in the factory

	virtual inter_face h_intf;                                       // handle creation for the virtual interface instance
  
  	uvm_analysis_imp#(packet,coverage) h_coverage_analysis_imp;               // CREATING THE HANDLE FOR THE COVERAGE  ANALYSIS IMPLEMENT

  	packet h_pkt;                                                    // creating the memory for packet handle
  
  	covergroup cov_group;                                            // COVER GROUPS 

		C1_reset:coverpoint h_pkt.reset;

		C2_write:coverpoint h_pkt.fifo_write;

		C2_read:coverpoint h_pkt.fifo_read;

	endgroup
  
  	function new(string name = "covergae", uvm_component parent);    // constructing the uvm component
    
    		super.new(name,parent);

		cov_group      = new();
    
  	endfunction
    
  	function void build_phase(uvm_phase phase);
    
    		super.build_phase(phase);
    
    		h_coverage_analysis_imp = new("h_coverage_analysis_imp",this);                    // creating the memory for analysis IMPLEMENT

    		h_pkt          = new("h_pkt");                                  // creating the memory for packet handles

    		`uvm_info("IN THE  COVERAGE CLASS","BUILD PHASE IS DONE",UVM_FULL)
    
  	endfunction
  
  	function void connect_phase(uvm_phase phase);
    
    		super.connect_phase(phase);

		assert(uvm_config_db#(virtual inter_face)::get(null,this.get_full_name,"vintf",h_intf));  // getting the VIRTUAL interface handle using config db  from the top
    
    		`uvm_info("IN THE  COVERAGE CLASS","CONNECT PHASE IS DONE",UVM_HIGH)
    
  	endfunction
  
  	function write(input packet h_pkt);

		this.h_pkt = h_pkt;                                             // assigning the data from input monitor packet handle  to the COVERAGE packet handle 

	endfunction
  
  	task run_phase(uvm_phase phase);
    
    		super.run_phase(phase);

		forever @(h_intf.cb_monitor)begin
    
    			cov_group.sample();

			$display($time,"coverage == %f",cov_group.get_coverage());

		end
    
    		`uvm_info("IN THE  COVERAGE CLASS","RUN PHASE IS DONE",UVM_MEDIUM)
    
  	endtask
  
  
endclass
