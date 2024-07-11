module top;
	import uvm_pkg::*;
	import pkg::*;
	
		bit PCLK;
		always #1 PCLK++;
	    apb_intf h_intf(PCLK);   //interface 

	apb_config cfg;            //config class
		
	apb_slave2 UUT(
					  .reset(h_intf.PRESETn), 
					  .clock(h_intf.PCLK),
					  .pselx(h_intf.PSELx),
					  .penable(h_intf.PENABLE),
					  .paddr(h_intf.PADDR),
					  .pw_data(h_intf.PWDATA),
					  .pwrite(h_intf.PWRITE),
					  .pr_data(h_intf.PRDATA),
					  .pready(h_intf.PREADY),
					  .pslverror(h_intf.PSLVERR)
					 );
	
	assertions dut (
			 		.PRESETn(h_intf.PRESETn),	
					.PCLK(h_intf.PCLK),
					 .PSELx(h_intf.PSELx),
					  .PENABLE(h_intf.PENABLE),
					  .PADDR(h_intf.PADDR),
					  .PWDATA(h_intf.PWDATA),
					  .PWRITE(h_intf.PWRITE),
					  .PRDATA(h_intf.PRDATA),
					  .PREADY(h_intf.PREADY),
					  .PSLVERR(h_intf.PSLVERR)			
					);

		initial begin
			cfg = new();
		uvm_config_db #(virtual apb_intf) :: set (null,"uvm_test_top.*","interf",h_intf);   //setting the virtual interface using config db
	        uvm_config_db #(apb_config) :: set (null,"uvm_test_top.*","key1",cfg);      //setting the config class at the top
		 run_test();
		end



endmodule
