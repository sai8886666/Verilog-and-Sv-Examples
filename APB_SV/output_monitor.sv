//*********** output_monitor *********************
class output_monitor;
  transaction tr_h;
  mailbox mbx;
  virtual intf h_intf;
  
  function new(virtual intf h_intf,mailbox mbx);
    this.h_intf = h_intf;
    this.mbx = mbx;
	$display($time,"\t \t ********** output_monitor ***************");	
  endfunction
  
  task run();
    tr_h = new();
    forever begin @(h_intf.cb_monitor);
     tr_h.PRESETn = h_intf.cb_monitor.PRESETn;
      tr_h.PSELx  = h_intf.cb_monitor.PSELx;
      tr_h.PADDR  = h_intf.cb_monitor.PADDR;
      tr_h.PENABLE= h_intf.cb_monitor.PENABLE;
      tr_h.PWDATA = h_intf.cb_monitor.PWDATA;
      tr_h.PREADY = h_intf.cb_monitor.PREADY;
      tr_h.PRDATA = h_intf.cb_monitor.PRDATA;
      tr_h.PSLVERR = h_intf.cb_monitor.PSLVERR;
	  tr_h.PWRITE = h_intf.cb_monitor.PWRITE;
		$display($time,"\t \t  ready = %d",tr_h.PREADY);
      mbx.put(tr_h);         // the values in the iterface are passing to the input monitor through mailbox
	//$display($time,"\t \t in output_monitor === %p",tr_h);
	//$display("\t \t \t >>---------------------------------------------<<");
    end
  endtask
endclass
