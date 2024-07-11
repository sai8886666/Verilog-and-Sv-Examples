//-------------------- assertions ------------------------------


module assertions(input PCLK,PRESETn,PSELx,[31:0]PADDR,PENABLE,[31:0]PWDATA,PWRITE,[31:0]PRDATA,PREADY,PSLVERR);

import uvm_pkg::*;

	`include "uvm_macros.svh"
//------------ clock checking ---------------------------------------
property clock_check;
	realtime time1,time2;
	int timeperiod = 2;
	@(posedge PCLK) (1,time1 = $realtime) ##1 (1,time2 = $realtime) |-> (time2 - time1 == timeperiod);
endproperty
//------------------- sequences ---------------------------------
sequence setup;
	(PSELx==1) && (PWRITE==1) && (PENABLE==0);
endsequence

sequence access;
	(PSELx==1) && (PWRITE==1) && (PENABLE==1);
endsequence

//------------------- properties ---------------------------------------
property reset;
	@(posedge PCLK) !PRESETn |-> ((PSLVERR==0) && (PRDATA==0) && (PREADY==0));
endproperty

property idle_to_setup;
	@(posedge PCLK) (PSELx==0) && (PENABLE==0)  |=> (PSELx==1) && (PENABLE==0); 
endproperty

property setup_to_access;
	@(posedge PCLK) (PSELx==1) && (PENABLE==0)  |=> (PSELx==1) && (PENABLE==1); 
endproperty

property ready;
	@(posedge PCLK) $rose (PREADY) |=> $fell (PENABLE);
endproperty

property enable_check;
	@(posedge PCLK) (PSELx==1) && (PREADY==1) && (PWRITE==1) |=> (PENABLE==0); 
endproperty

property adress_check;
	@(posedge PCLK) disable iff(PRESETn)
				setup |=> access |-> $stable(PADDR); 
endproperty

property data_check;
	@(posedge PCLK) disable iff(PRESETn)
				setup |=> access |-> $stable(PWDATA); 
endproperty
//----------------- asserting the properties ------------------------------

assert property (clock_check)
	`uvm_info("clock_check",$sformatf("PASSED"),UVM_HIGH)
	else
	`uvm_error("clock_check","FAILED")
assert property (reset)
	`uvm_info("reset check",$sformatf("PASSED"),UVM_HIGH)
	else
	`uvm_error("reset check","FAILED")
assert property (idle_to_setup)
	`uvm_info("idle_to_setup",$sformatf("PASSED"),UVM_HIGH)
	else
	`uvm_error("idle_to_setup","FAILED")
assert property (setup_to_access)
	`uvm_info("setup_to_access",$sformatf("PASSED"),UVM_HIGH)
	else
	`uvm_error("setup_to_access","FAILED")
assert property (ready)
	`uvm_info("ready",$sformatf("PASSED"),UVM_HIGH)
	else
	`uvm_error("ready","FAILED")	
assert property (enable_check)
	`uvm_info("enable_check",$sformatf("PASSED"),UVM_HIGH)
	else
	`uvm_error("enable_check","FAILED")	
assert property (adress_check)
	`uvm_info("adress_check",$sformatf("PASSED"),UVM_HIGH)
	else
	`uvm_error("adress_check","FAILED")	
assert property (data_check)
	`uvm_info("data_check",$sformatf("PASSED"),UVM_HIGH)
	else
	`uvm_error("data_check","FAILED")	
endmodule
