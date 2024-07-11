//-------------------- scoreboard ---------------------------


class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)      //(factory registration for the component)
		`uvm_analysis_imp_decl(_ip_mon);     //(to differentiate btw i/p monitor and o/p monitor export ports we declare here the another port)

//----------------- declaring ports-----------------------------
		uvm_analysis_imp_ip_mon  #(sequence_item,scoreboard) score_ipmon;    //(implementation ports)       
		uvm_analysis_imp   #(sequence_item,scoreboard) score_opmon;
		sequence_item tr_h1,tr_h2;	//(sequence_item handle)

/*------------------------- constructer -------------------------
---- constructor for the factory registersd component ---------*/
		function new(string name = "scoreboard",uvm_component parent);
			super.new(name,parent);
		`uvm_info("scoreboard",$sformatf("-----------apb_scoreboard is constructed ---------"),UVM_LOW);				
		endfunction

/*--------------------------- build phase --------------------------------
----memory allocation for the factory registered component handles-------*/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("scoreboard",$sformatf("-----------apb_scoreboard is built ---------"),UVM_MEDIUM);
			score_ipmon = new("score_ipmon",this);
			score_opmon = new("score_opmon",this);
			tr_h1 = new("tr_h1");
			tr_h2 = new("tr_h2");
	endfunction

	function void write_ip_mon(input sequence_item tr_h1);
		this.tr_h1 = tr_h1;
	endfunction

	function void write(input sequence_item tr_h2);
		this.tr_h2 = tr_h2;
	endfunction



//-------------- Run Phase -------------------------
		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			`uvm_info("scoreboard",$sformatf("--------apb_scoreboard run_phase----------"),UVM_NONE);	
					
				forever begin
					#2;
				/*$display("tr_h1  ********* normal print of ip  ");
				tr_h1.print();
				$display("tr_h2  ********* normal print of op  ***********");
				tr_h2.print();					
				if(tr_h1.compare(tr_h2))
					`uvm_info("**********",$sformatf(" both are equal "),UVM_HIGH)
					else
					`uvm_error("**********"," both are equal ")

						if(tr_h1.PRDATA == tr_h2.PRDATA && tr_h1.PREADY == tr_h2.PREADY && tr_h1.PSLVERR == tr_h2.PSLVERR)

				$display("========== After copying done values in tr_h2 ============");
				tr_h2.copy(tr_h1);         //(copy_method)
				tr_h1.print();
				tr_h2.print();
				if(tr_h1.compare(tr_h2))
					`uvm_info("**********",$sformatf(" both are equal "),UVM_HIGH)
					else
					`uvm_error("**********"," both are not equal ")*/





						if(tr_h1.PRDATA == tr_h2.PRDATA && tr_h1.PREADY == tr_h2.PREADY && tr_h1.PSLVERR == tr_h2.PSLVERR)

							begin
`uvm_info("scorebord -> TB-PASSED",$sformatf("IPMON @ score_borad [TB_PASS] ==> reset:%d select:%d enable:%d Adrss:%d w-r:%d data:%d",tr_h1.PRESETn,tr_h1.PSELx,tr_h1.PENABLE,tr_h1.PADDR,tr_h1.PWRITE,tr_h1.PWDATA),UVM_FULL);
`uvm_info("scorebord -> TB-PASSED",$sformatf("OPMON @ score_borad [DUT_PASS] ==>reset:%d select:%d enable:%d Adrss:%d w-r:%d data:%d",tr_h2.PRESETn,tr_h2.PSELx,tr_h2.PENABLE,tr_h2.PADDR,tr_h2.PWRITE,tr_h2.PWDATA),UVM_FULL);
							end
						else
							begin
`uvm_info("scorebord -> TB-FAILED",$sformatf("IPMON @ score_borad [TB_FAIL] ==> reset:%d select:%d enable:%d Adrss:%d w-r:%d data:%d",tr_h1.PRESETn,tr_h1.PSELx,tr_h1.PENABLE,tr_h1.PADDR,tr_h1.PWRITE,tr_h1.PWDATA),UVM_FULL);
`uvm_info("scorebord -> TB-FAILED",$sformatf("OPMON @ score_borad [DUT_FAIL] ==>reset:%d select:%d enable:%d Adrss:%d w-r:%d data:%d",tr_h2.PRESETn,tr_h2.PSELx,tr_h2.PENABLE,tr_h2.PADDR,tr_h2.PWRITE,tr_h2.PWDATA),UVM_FULL);
							end

				end
		endtask



	
endclass
