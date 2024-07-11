//------------- sequence -----------------------

class sequence1 extends uvm_sequence #(sequence_item);
	`uvm_object_utils(sequence1)
	virtual apb_intf h_intf_seq;   //(sequence handle)
	 int i;

		function new(string name = "sequence1");
			super.new(name);
		endfunction



	task body();
				assert(uvm_config_db #(virtual apb_intf) :: get(null,this.get_full_name,"interf",h_intf_seq));	
		//forever begin @(h_intf_seq.apb_cb_driver)
		//repeat (20) begin
			dont();
			dont1();
			reset();
			reset_select_high();
			reset_enable_high();
			reset_write_high();
			reset_enable_write_high();
			idle_phase_write_high();
			not_reset_select_high();
			not_reset_enable_high();
			not_reset();

			transfer(1,1,0,1,10,24);
			transfer(1,1,1,1,10,24);
			wait(h_intf_seq.apb_cb_driver.PREADY);
			transfer(1,1,0,0,10,24);
			transfer(1,1,1,0,10,24);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);


			transfer(1,1,0,1,11,23);
			transfer(1,1,1,1,11,23);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);
			transfer(1,1,0,0,11,23);
			transfer(1,1,1,0,11,23);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);

       //------(normal write and read)----------
			random_transfer(1,1,0,1);
			random_transfer(1,1,1,1);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);
			random_transfer(1,1,0,0);
			random_transfer(1,1,1,0);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);
		//-------( reset in setup phase )---------------------------
			random_transfer(0,1,0,1);
			random_transfer(1,1,1,1);
			@(h_intf_seq.apb_cb_driver);
			random_transfer(1,1,0,0);
			random_transfer(1,1,1,0);
			@(h_intf_seq.apb_cb_driver);
		//-------( reset in access phase )---------------------------
			random_transfer(1,1,0,1);
			random_transfer(0,1,1,1);
			@(h_intf_seq.apb_cb_driver);
			random_transfer(1,1,0,0);
			random_transfer(1,1,1,0);
			@(h_intf_seq.apb_cb_driver);
		//-------( write signal low in access state while write )---------------------------
			random_transfer(1,1,0,1);
			random_transfer(1,1,1,0);
			@(h_intf_seq.apb_cb_driver);
			random_transfer(1,1,0,0);
			random_transfer(1,1,1,0);
			//@(h_intf_seq.apb_cb_driver);
		//-------( reset in setup phase while read )---------------------------
			random_transfer(1,1,0,1);
			random_transfer(1,1,1,1);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);
			random_transfer(0,1,0,0);
			random_transfer(1,1,1,0);
			@(h_intf_seq.apb_cb_driver);
		//-------( reset in access phase while read )---------------------------
			random_transfer(1,1,0,1);
			random_transfer(1,1,1,1);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);
			random_transfer(1,1,0,0);
			random_transfer(0,1,1,0);
			@(h_intf_seq.apb_cb_driver);
		//---------(write access selection low) -------------------------------
			random_transfer(1,1,0,1);
			random_transfer(1,0,1,1);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);
			random_transfer(1,1,0,0);
			random_transfer(1,1,1,0);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);
		//---------(read access selection low) -------------------------------
			random_transfer(1,1,0,1);
			random_transfer(1,1,1,1);
			@(h_intf_seq.apb_cb_driver);
			wait(h_intf_seq.apb_cb_driver.PREADY);
			random_transfer(1,1,0,0);
			random_transfer(1,0,1,0);
			@(h_intf_seq.apb_cb_driver);
			

//--------------------------- (500 sequence) --------------------------------
				for(i=0;i<=5000;i++)
					begin
                for_loop_sequence(1,1,0,1,i);  //(write_setup)
                for_loop_sequence(1,1,1,1,i);	//(write_access)
						@(h_intf_seq.apb_cb_driver);
						wait(h_intf_seq.apb_cb_driver.PREADY);
                for_loop_sequence(1,1,0,0,i);  //(read_setup)
                for_loop_sequence(1,1,1,0,i);	//(read_access)		
						@(h_intf_seq.apb_cb_driver);
						wait(h_intf_seq.apb_cb_driver.PREADY);
					end  

	endtask

/*********************************************************************** Tasks ***************************************************************************************************************************************************************************************************************************************************************************************************/

		task dont();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 0; req.PSELx==0; req.PENABLE==0; req.PWRITE==0; req.PADDR==32'dx; req.PWDATA==32'dx;});
					`uvm_info("reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask

		task dont1();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 1'bx; req.PSELx==1'bx; req.PENABLE==0; req.PWRITE==0; req.PADDR==32'dx; req.PWDATA==32'dx;});
					`uvm_info("reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask

		task dont2();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 0; req.PSELx==0; req.PENABLE==1'bx; req.PWRITE==1'bx; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask

//------------------------------------
		task reset();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 0; req.PSELx==0; req.PENABLE==0; req.PWRITE==0; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask
//-------------------------------------
		task reset_select_high();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 0; req.PSELx==1; req.PENABLE==0; req.PWRITE==0; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_NONE);	
				finish_item(req);
		endtask
//-------------------------------------
		task reset_enable_high();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 0; req.PSELx==0; req.PENABLE==1; req.PWRITE==0; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask
//-------------------------------------
		task reset_write_high();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 0; req.PSELx==0; req.PENABLE==0; req.PWRITE==1; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask
//-------------------------------------
		task reset_enable_write_high();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 0; req.PSELx==0; req.PENABLE==1; req.PWRITE==1; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask

//-------------------------------------		
			
		task not_reset();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 1; req.PSELx==0; req.PENABLE==0; req.PWRITE==0; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("not_reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask
//-------------------------------------

		task idle_phase_write_high();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 1; req.PSELx==0; req.PENABLE==0; req.PWRITE==1; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("not_reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);			
		endtask
//-------------------------------------
		task not_reset_select_high();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 1; req.PSELx==1; req.PENABLE==0; req.PWRITE==0; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("not_reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask
//-------------------------------------
		task not_reset_enable_high();
			req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == 1; req.PSELx==0; req.PENABLE==1; req.PWRITE==0; req.PADDR==0; req.PWDATA==0;});
					`uvm_info("not_reset",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);
		endtask



//--------------------------------------

		task transfer (input logic Reset,input logic select,input logic enable,input logic write,input bit [31:0]adress1,input bit [31:0]data1);
			req = sequence_item :: type_id :: create("req");
				start_item(req);
    		 		assert(req.randomize() with {req.PRESETn == Reset; req.PSELx==select; req.PENABLE==enable; req.PWRITE==write; req.PADDR==adress1; req.PWDATA==data1;});
					`uvm_info("sequence",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);	
		endtask
//---------------------------------------

		task random_transfer(input logic reset1, input logic select1, input logic enable1, input logic write1);
					req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == reset1; req.PSELx == select1; req.PENABLE == enable1; req.PWRITE == write1 ;});
				`uvm_info("random_transfer",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);	
		endtask
//----------------------------------------

		task for_loop_sequence(input logic reset, input logic select, input logic enable, input logic write, input logic[31:0] address);
					req = sequence_item :: type_id :: create("req");
				start_item(req);
					assert(req.randomize() with {req.PRESETn == reset; req.PSELx == select; req.PENABLE == enable; req.PWRITE == write; req.PADDR == address;});
			`uvm_info("for_loop_sequence",$sformatf("reset:%d sel:%d enable:%d write:%d adrr:%d data:%d ",req.PRESETn,req.PSELx,req.PENABLE,req.PWRITE,req.PADDR,req.PWDATA),UVM_DEBUG);	
				finish_item(req);	
		endtask
//-----------------------------------------
endclass











