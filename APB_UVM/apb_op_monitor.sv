//---------------- dut_monitor ------------------------


class dut_monitor extends uvm_monitor;
	`uvm_component_utils(dut_monitor)   //(factory registration for component)

//--------------- declaring the handles--------------------
	virtual apb_intf h_intf_op;   //(interface  in output monitor)
		apb_config cfg;        // config class handle
	sequence_item req;
	uvm_analysis_port #(sequence_item) op_monitor_port;   //(analysis ports)

	bit [3:0]xyz;    // internal signal for config class

//----------------- constroctur for factory registerd compoonent ---------------------
	function new(string name = "dut_monitor",uvm_component parent);
		super.new(name,parent);
		`uvm_info("dut_monitor",$sformatf("-----------apb_dut_monitor is constructed ---------"),UVM_LOW);
	endfunction

//--------------build phase -------------------------
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info("dut_monitor",$sformatf("---------apb_dut_monitor is built_phase ------------"),UVM_MEDIUM);
				op_monitor_port = new("op_monitor_port",this);
			cfg = apb_config :: type_id :: create("cfg",this);             //creating the memory for config class
		endfunction

//------------ connect_phase ----------------------
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
				assert(uvm_config_db #(virtual apb_intf) :: get(null,this.get_full_name,"interf",h_intf_op));
			if(!uvm_config_db #(apb_config) :: get(null,this.get_full_name,"key1",cfg))	  // get config
			`uvm_fatal("fatal error",$sformatf("-----------fatal error-------------"));				
			//`uvm_info("dut_monitor",$sformatf("---------apb_dut_monitor is connect_phase ------------"),UVM_MEDIUM);
		endfunction

//----------- RUN phase --------------------------
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			`uvm_info("dut_monitor",$sformatf("---------apb_dut_monitor is connect_phase ------------"),UVM_NONE);
				req = sequence_item :: type_id :: create("req",this);
				    forever begin @(h_intf_op.apb_cb_monitor);
    						 req.PRESETn = h_intf_op.apb_cb_monitor.PRESETn;
 						     req.PSELx  = h_intf_op.apb_cb_monitor.PSELx;
					         req.PADDR  = h_intf_op.apb_cb_monitor.PADDR;
					         req.PENABLE= h_intf_op.apb_cb_monitor.PENABLE;
 						     req.PWDATA = h_intf_op.apb_cb_monitor.PWDATA;
					         req.PWRITE = h_intf_op.apb_cb_monitor.PWRITE;

					         req.PREADY = h_intf_op.apb_cb_monitor.PREADY;
					         req.PRDATA = h_intf_op.apb_cb_monitor.PRDATA;
					         req.PSLVERR = h_intf_op.apb_cb_monitor.PSLVERR;
							
					op_monitor_port.write(req);  //(getting from output  monitor)	
						xyz = cfg.config_a;
					$display($time,"-------- xyz = %d",xyz);							
				end
		endtask
		
endclass
