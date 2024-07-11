// -------------------- coverage -------------------------


class coverage extends uvm_component;
	`uvm_component_utils(coverage)


//------------------- declaring handles -----------------------
uvm_analysis_imp #(sequence_item,coverage) cov_imp;
sequence_item seq_it_handle; //(sequence_item handle)
virtual apb_intf h_intf_cov;  

	covergroup cg;
		// ---------------single bins-----------------------
		reset: coverpoint h_intf_cov.PRESETn{
										  bins r1={0};
										  bins r2={1};	}
		select: coverpoint h_intf_cov.PSELx{
										  bins s1={0};
										  bins s2={1};	}	
		write: coverpoint h_intf_cov.PWRITE{
										  bins w1={0};
										  bins w2={1};	}
		enable: coverpoint h_intf_cov.PENABLE{
											bins e1={0};
											bins e2={1};	}
		adress: coverpoint h_intf_cov.PADDR {
											bins a1={[0:10737]};	}
		data:  coverpoint h_intf_cov.PWDATA{
											bins d1={[0:31]};	}
	//---------------- cross bins -----------------------------
		rs: cross reset,select;       //(reset and select)
		rw: cross reset,write;		  //(reset and write)
		se: cross select,enable;	  //(select and write)
		all_comb: cross select,enable,write;  //(select and enable and write)
		all_comb1: cross reset,select,enable,write; //(reset and select and enable and write)
	//--------------- transistion bins --------------------------
		trans_reset: coverpoint h_intf_cov.PRESETn{
												bins tr_reset = (0=>1);
												ignore_bins tr_reset1 = (0=>1=>0);
												bins tr_reset2 = (0=>0=>1);
												bins tr_reset3 = (1=>0=>1); }
		trans_select:coverpoint h_intf_cov.PSELx{
												bins tr_select = (0=>1);
												bins tr_select1 = (0=>1=>0);
												bins tr_select2 = (0=>0=>1);
												bins tr_select3 = (1=>0=>1);  }
		trans_write:coverpoint h_intf_cov.PWRITE{
												bins tr_write = (0=>1);
												bins tr_write1 = (0=>1=>1);
												bins tr_write2 = (0=>0=>1);
												ignore_bins tr_write3 = (1=>0=>1);	}
		trans_read: coverpoint h_intf_cov.PENABLE{
												bins tr_enable = (0=>1);
												bins tr_enable1 = (0=>1=>0);
												bins tr_enable2 = (0=>0=>1);
												bins tr_enable3 = (1=>0=>1);	}
		trans_adress: coverpoint h_intf_cov.PADDR{
												bins tr_addr = (0[*4]=>1[*4]=>2[*4]=>3[*4]=>4[*4]=>5[*4]=>6[*4]=>7[*4]=>8[*4]=>9[*4]=>10[*4]=>11[*4]=>12[*4]=>13[*4]=>14[*4]=>15[*4]=>16[*4]=>17[*4]=>18[*4]=>19[*4]=>20[*4]=>21[*4]=>22[*4]=>23[*4]=>24[*4]=>25[*4]=>26[*4]=>27[*4]=>28[*4]=>29[*4]=>30[*4]=>31[*4]);}
	//-------------- conditional bins --------------------------
		condition1: coverpoint h_intf_cov.PADDR iff (h_intf_cov.PWRITE) { 
																	bins con_addr = {[44:3000]};
																	bins con_addr1 = {[4000:5000]};	} 

		condition2: coverpoint h_intf_cov.PADDR iff (h_intf_cov.PSELx && h_intf_cov.PENABLE && h_intf_cov.PWRITE){
																									bins con2_addr = {[44:3000]};
																									bins con2_addr1 = {[4000:5000]};	}
		condition3: coverpoint h_intf_cov.PWDATA iff (h_intf_cov.PWRITE && h_intf_cov.PSELx){
																					bins con3_data = {[0:31]};
																					bins con4_data = {[31:500]};}
		condition4: coverpoint h_intf_cov.PADDR iff (h_intf_cov.PRESETn){
																	bins con4_addr = {[44:3000]};}
		condition5: coverpoint h_intf_cov.PADDR iff (h_intf_cov.PRESETn){
																	bins con5_addr = {[44:3000]};}
		condition6: coverpoint h_intf_cov.PENABLE iff(h_intf_cov.PSELx){
																	bins con6_enable_0 = {0};
																	bins con6_enable_1 = {1}; }
	//------------- ignore bins ----------------------------------------
			ignore_1 : cross select,enable,write iff(!h_intf_cov.PRESETn) {
																	ignore_bins ig1 = 	binsof (select.s1) && binsof (enable.e2) && binsof (write.w2);
																	illegal_bins ill1 =  binsof (select.s1) && binsof (enable.e2) && binsof (write.w2); 
																																							}
			ignore_2 : cross select,enable,write iff(!h_intf_cov.PRESETn || !h_intf_cov.PSELx) {
																	ignore_bins ig2 = binsof (enable.e2) && binsof (write.w2);
																																}

	endgroup

/*------------------------- constructer -------------------------
---- constructor for the factory registersd component ---------*/
		function new(string name = "coverage",uvm_component parent);
			super.new(name,parent);
				cg = new();
		`uvm_info("coverage",$sformatf("-----------apb_coverage is constructed ---------"),UVM_LOW);				
		endfunction

/*--------------------------- build phase --------------------------------
----memory allocation for the factory registered component handles-------*/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("coverage",$sformatf("-----------apb_coverage is built ---------"),UVM_MEDIUM);
			seq_it_handle = sequence_item :: type_id :: create("seq_it_handle");
			cov_imp =  new ("cov_imp",this);					
	endfunction

	function void write(input sequence_item seq_it_handle);
		this.seq_it_handle = seq_it_handle;
	endfunction

//------------ connect_phase ----------------------
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			`uvm_info("coverage",$sformatf("---------apb_coverage is connect_phase ------------"),UVM_MEDIUM);
				assert(uvm_config_db #(virtual apb_intf) :: get(null,this.get_full_name,"interf",h_intf_cov)); //-------(3)-------
		endfunction

//----------- run phase --------------------------
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			`uvm_info("coverage",$sformatf("---------apb_coverage is run_phase ------------"),UVM_NONE);
				forever @(h_intf_cov.apb_cb_monitor) begin
					cg.sample();
					$display($time,"\t \t coverage : %f ",cg.get_coverage());
				end			
		endtask



endclass
