//****************** driver ***************
class driver;
  transaction tr_h;
  mailbox mbx;
  virtual intf h_intf;
  
  function new(virtual intf h_intf,mailbox mbx);
    this.h_intf = h_intf;
    this.mbx = mbx;
	$display($time,"\t \t ************* driver ***********");
  endfunction
  
      task run();
		forever @(h_intf.cb_driver)begin
				tr_h = new();
     				mbx.get(tr_h);  // getting the siganls which are randmixed from the generator	  
      h_intf.cb_driver.PRESETn <= tr_h.PRESETn;
      h_intf.cb_driver.PADDR   <= tr_h.PADDR;
      h_intf.cb_driver.PSELx   <= tr_h.PSELx;
      h_intf.cb_driver.PENABLE <= tr_h.PENABLE;
      h_intf.cb_driver.PWRITE  <= tr_h.PWRITE;
      h_intf.cb_driver.PWDATA  <= tr_h.PWDATA;
		if(h_intf.PREADY)
					begin
						tr_h.PENABLE<=0;   // controlling the enable after ready signal is activated 
					end
			
          $display("11111111[driver] %p",mbx); 
/*	$display("\t \t \t >>---------------------------------------------<<");
	$display($time,"\t \t  in the driver ====  %p ",tr_h);*/
	end
  endtask
endclass
