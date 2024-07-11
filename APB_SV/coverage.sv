class coverage;
	transaction tr_h;
	virtual intf h_intf;

	covergroup cg;
		// ---------------single bins-----------------------
		reset: coverpoint h_intf.PRESETn{
										  bins r1={0};
										  bins r2={1};	}
		select: coverpoint h_intf.PSELx{
										  bins s1={0};
										  bins s2={1};	}	
		write: coverpoint h_intf.PWRITE{
										  bins w1={0};
										  bins w2={1};	}
		enable: coverpoint h_intf.PENABLE{
											bins e1={0};
											bins e2={1};	}
		adress: coverpoint h_intf.PADDR {
											bins a1={[0:10737]};	}
		data:  coverpoint h_intf.PWDATA{
											bins d1={[0:31]};	}
	//---------------- cross bins -----------------------------
		rs: cross reset,select;       //(reset and select)
		rw: cross reset,write;		  //(reset and write)
		se: cross select,enable;	  //(select and write)
		all_comb: cross select,enable,write;  //(select and enable and write)
		all_comb1: cross reset,select,enable,write; //(reset and select and enable and write)
	//--------------- transistion bins --------------------------
		trans_reset: coverpoint h_intf.PRESETn{
												bins tr_reset = (0=>1);
												ignore_bins tr_reset1 = (0=>1=>0);
												bins tr_reset2 = (0=>0=>1);
												bins tr_reset3 = (1=>0=>1); }
		trans_select:coverpoint h_intf.PSELx{
												bins tr_select = (0=>1);
												bins tr_select1 = (0=>1=>0);
												bins tr_select2 = (0=>0=>1);
												bins tr_select3 = (1=>0=>1);  }
		trans_write:coverpoint h_intf.PWRITE{
												bins tr_write = (0=>1);
												bins tr_write1 = (0=>1=>1);
												bins tr_write2 = (0=>0=>1);
												ignore_bins tr_write3 = (1=>0=>1);	}
		trans_read: coverpoint h_intf.PENABLE{
												bins tr_enable = (0=>1);
												bins tr_enable1 = (0=>1=>0);
												bins tr_enable2 = (0=>0=>1);
												bins tr_enable3 = (1=>0=>1);	}
		trans_adress: coverpoint h_intf.PADDR{
												bins tr_addr = (0[*4]=>1[*4]=>2[*4]=>3[*4]=>4[*4]=>5[*4]=>6[*4]=>7[*4]=>8[*4]=>9[*4]=>10[*4]=>11[*4]=>12[*4]=>13[*4]=>14[*4]=>15[*4]=>16[*4]=>17[*4]=>18[*4]=>19[*4]=>20[*4]=>21[*4]=>22[*4]=>23[*4]=>24[*4]=>25[*4]=>26[*4]=>27[*4]=>28[*4]=>29[*4]=>30[*4]=>31[*4]);}
	//-------------- conditional bins --------------------------
		condition1: coverpoint h_intf.PADDR iff (h_intf.PWRITE) { 
																	bins con_addr = {[44:3000]};
																	bins con_addr1 = {[4000:5000]};	} 

		condition2: coverpoint h_intf.PADDR iff (h_intf.PSELx && h_intf.PENABLE && h_intf.PWRITE){
																									bins con2_addr = {[44:3000]};
																									bins con2_addr1 = {[4000:5000]};	}
		condition3: coverpoint h_intf.PWDATA iff (h_intf.PWRITE && h_intf.PSELx){
																					bins con3_data = {[0:31]};}
		condition4: coverpoint h_intf.PADDR iff (h_intf.PRESETn){
																	bins con4_addr = {[44:3000]};}
		condition5: coverpoint h_intf.PADDR iff (h_intf.PRESETn){
																	bins con5_addr = {[44:3000]};}
		condition6: coverpoint h_intf.PENABLE iff(h_intf.PSELx){
																	bins con6_enable_0 = {0};
																	bins con6_enable_1 = {1}; }
	//------------- ignore bins ----------------------------------------
			ignore_1 : cross select,enable,write iff(!h_intf.PRESETn) {
																	ignore_bins ig1 = 	binsof (select.s1) && binsof (enable.e2) && binsof (write.w2);
																	illegal_bins ill1 =  binsof (select.s1) && binsof (enable.e2) && binsof (write.w2); 
																																							}
		
	endgroup 
	

		function new(virtual intf h_intf);
			this.h_intf = h_intf; 
			cg = new();     // creating the memory for covergroup
			tr_h = new();	// creating memory for transaction class		
		endfunction

		task run();
			forever @(h_intf.cb_monitor) 
							begin
								cg.sample();    // covergroup sample 
							end
		endtask	
endclass
