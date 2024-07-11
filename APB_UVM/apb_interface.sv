//--------------- interface -----------------

interface apb_intf(input bit PCLK);
	import pkg::*;

  logic PRESETn;
  logic [31:0] PADDR;
  logic PSELx;
  logic PENABLE;
  logic PWRITE;
  logic [31:0] PWDATA;
  logic PREADY;
  logic [31:0] PRDATA;
  logic PSLVERR;
  
  clocking apb_cb_driver@(posedge PCLK);
    output  PRESETn,PADDR,PSELx,PENABLE,PWRITE,PWDATA;
    input  PREADY,PSLVERR,PRDATA;    
  endclocking
  
  clocking apb_cb_monitor@(posedge PCLK);  
    input PRESETn,PADDR,PSELx,PENABLE,PWRITE,PWDATA;
    input PREADY,PSLVERR,PRDATA;
  endclocking
 
endinterface
