//******** interface *****************
interface intf (input bit PCLK);
  logic PRESETn;
  logic [31:0] PADDR;
  logic PSELx;
  logic PENABLE;
  logic PWRITE;
  logic [31:0] PWDATA;
 // logic PREADY = 1'b1 ;
  logic PREADY;
  logic [31:0] PRDATA;
  logic PSLVERR;
  
  clocking cb_driver@(posedge PCLK);
    output  PRESETn,PADDR,PSELx,PENABLE,PWRITE,PWDATA;
    input  PREADY,PSLVERR,PRDATA;    
  endclocking
  
  clocking cb_monitor@(posedge PCLK);  
    input PRESETn,PADDR,PSELx,PENABLE,PWRITE,PWDATA;
    input PREADY,PSLVERR,PRDATA;
  endclocking

	always @(posedge PCLK)
		 begin
		//	$display($time,"\t \t in interface -> PRESETn:%d PADDR:%d PSELx:%d PENABLE:%d PWRITE:%d PWDATA:%d",PRESETn,PADDR,PSELx,PENABLE,PWRITE,PWDATA);
		end
endinterface
