//---------------- input_monitor ----------------------

class input_monitor extends uvm_monitor;
	`uvm_component_utils(input_monitor)

//--------------- declaring the handles-------------------
		virtual apb_intf h_intf_ip;      //(interface using in input monitor)
		apb_config cfg;        // config class handle		
			sequence_item req;
			uvm_analysis_port #(sequence_item) ip_monitor_port;
	
	logic [31:0] memory [10000:0];  // memory
// temporary signals for self check to write
	bit [4000:0] temp_addr;
	bit [200:0] temp_write_data; 
	bit temp_write;


	bit [3:0] ips = 6;    //internal signal 

//-------------- consruct_phase ---------------------
	function new(string name = "input_monitor",uvm_component parent);
		super.new(name,parent);
			`uvm_info("input_monitor",$sformatf("--------apb_input_monitor is constructed---------"),UVM_LOW);		
	endfunction

//------------- build_phase ------------------------
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			`uvm_info("input_monitor_build",$sformatf("--------apb_input_monitor built_phase---------"),UVM_MEDIUM);		
				ip_monitor_port = new("ip_monitor_port",this);	
			cfg = apb_config :: type_id :: create("cfg",this);             //creating the memory for config class	
		endfunction

//------------- connect_phase ------------------------
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info("input_monitor",$sformatf("--------apb_input_monitor connect_phase---------"),UVM_MEDIUM);
			assert(uvm_config_db #(virtual apb_intf) :: get(null,this.get_full_name,"interf",h_intf_ip));	
			assert(uvm_config_db #(apb_config) :: get(null,this.get_full_name,"key1",cfg));	  // get config				
		endfunction


//-------------- Run Phase -------------------------
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			`uvm_info("input_monitor",$sformatf("--------apb_input_monitor run_phase----------"),UVM_NONE);
				req = sequence_item :: type_id :: create("req",this);
				forever begin@(h_intf_ip.apb_cb_monitor)

				      req.PRESETn = h_intf_ip.apb_cb_monitor.PRESETn;
					  req.PSELx  = h_intf_ip.apb_cb_monitor.PSELx;
				      req.PADDR  = h_intf_ip.apb_cb_monitor.PADDR;
    				  req.PENABLE= h_intf_ip.apb_cb_monitor.PENABLE;
     				  req.PWDATA = h_intf_ip.apb_cb_monitor.PWDATA;
	  				  req.PWRITE = h_intf_ip.apb_cb_monitor.PWRITE;	
				`uvm_info("i/p monitor",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_LOW);
						self_check();

					ip_monitor_port.write(req);    //(putting the signals into the write like mailbox put)
					cfg.config_a = ips;
					$display($time,"-------- ips = %d",cfg.config_a);						
				end
		endtask


// ************************ self check *************************

task self_check();
	write();
	read();
	error_write();
	error_read();	
endtask

//---------------- write task --------------------------------------
	task write();
		if(req.PRESETn==0)
			begin
					foreach(memory[i])
						begin
							memory[i] = 32'd0;
						end
			end
				else
					begin
						if(req.PSELx && !req.PENABLE && req.PWRITE)
								begin
									temp_addr 		= req.PADDR;
									temp_write_data = req.PWDATA;
									temp_write 		= req.PWRITE;
								end
									else if(req.PRESETn && req.PSELx && req.PENABLE && req.PWRITE)
														if(h_intf_ip.PREADY)
																	begin
																		memory[temp_addr] = req.PWDATA;
																	`uvm_info("write",$sformatf(" \t \t ********** memory[0%d] : %d",temp_addr,memory[temp_addr]),UVM_HIGH);
																	end
					end
	endtask
//------------------- Read task --------------------------------------
	task read();
		if(req.PRESETn==0)
			begin
					foreach(memory[i])
						begin
							memory[i] = 32'd0;
						end
			end
				else
					begin
						if(req.PSELx && !req.PENABLE && !req.PWRITE)
							begin
								temp_addr 		= req.PADDR;
								temp_write_data = req.PWDATA;
								temp_write 		= req.PWRITE;
							end
								else if(req.PSELx && req.PENABLE && !req.PWRITE)
										if(h_intf_ip.PREADY)
													begin
														req.PRDATA = memory[temp_addr];
														//$display($time,"\t \t read data : %d",req.PRDATA);
														`uvm_info("read",$sformatf("\t \t ********** read data : %d",req.PRDATA),UVM_HIGH);
													end	
					end	
	endtask
//---------------------- error_write -----------------------------------
	task error_write();
		if(req.PSELx && req.PENABLE && req.PWRITE)
				if(h_intf_ip.PREADY)
						begin
							if(temp_addr != req.PADDR || temp_write_data != req.PWDATA || temp_write != req.PWRITE)
								begin
									req.PSLVERR = 1;
								//	$display($time,"\t \t error:%d",req.PSLVERR);
									`uvm_info("error_write",$sformatf("\t \t ************* error:%d",req.PSLVERR),UVM_HIGH);

								end
							else
								req.PSLVERR = 0;
						end		
	endtask
//------------------ error_read ----------------------------------------
	task error_read();
		if(req.PSELx && req.PENABLE && !req.PWRITE)
				if(h_intf_ip.PREADY)
						begin
							if(temp_addr != req.PADDR || temp_write_data != req.PWDATA || temp_write != req.PWRITE)
								req.PSLVERR = 1;
							else
								req.PSLVERR = 0;
						end		
	endtask


endclass
