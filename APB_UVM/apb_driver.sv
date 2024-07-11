//------------- driver --------------------

class driver extends uvm_driver #(sequence_item);
	`uvm_component_utils(driver);
	virtual apb_intf h_intf_driver;   //(driver interface instance)
		apb_config cfg;        // config class handle

//-------------- consruct_phase ---------------------
	function new(string name = "driver",uvm_component parent);
		super.new(name,parent);
			`uvm_info("driver",$sformatf("--------apb_driver is constructed---------"),UVM_LOW);		
	endfunction

//----------------- build_phase -------------------------
	function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info("driver",$sformatf("--------apb_driver built_phase---------"),UVM_MEDIUM);
			assert(uvm_config_db #(virtual apb_intf) :: get(null,this.get_full_name,"interf",h_intf_driver));    //(connecting the interface signals to the driver using config db)
			assert(uvm_config_db #(apb_config) :: get(null,this.get_full_name,"key1",cfg));	// get config	
			cfg = apb_config :: type_id :: create("cfg",this);             //creating the memory for config class	
	endfunction

//----------------- run_phase --------------------------
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			`uvm_info("driver",$sformatf("--------abp_driver run_phase---------"),UVM_NONE);
				//cfg.config_a = 
				forever begin@(h_intf_driver.apb_cb_driver)
					seq_item_port.get_next_item(req);
					
				      h_intf_driver.apb_cb_driver.PRESETn <= req.PRESETn;
				      h_intf_driver.apb_cb_driver.PADDR   <= req.PADDR;
				      h_intf_driver.apb_cb_driver.PSELx   <= req.PSELx;
				      h_intf_driver.apb_cb_driver.PENABLE <= req.PENABLE;
				      h_intf_driver.apb_cb_driver.PWRITE  <= req.PWRITE;
				      h_intf_driver.apb_cb_driver.PWDATA  <= req.PWDATA;
							if(h_intf_driver.PREADY)
								begin
									req.PENABLE<=0;   // controlling the enable after ready signal is activated 
								end
					seq_item_port.item_done();					
				end						
	endtask
		
endclass
