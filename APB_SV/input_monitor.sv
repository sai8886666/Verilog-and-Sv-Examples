//*********** input_monitor *********************
class input_monitor;
  transaction tr_h;
  mailbox mbx;
  virtual intf h_intf;

  	logic [31:0] memory [10737:0];  // memory
// temporary signals for self check to write
	bit [4000:0] temp_addr;
	bit [200:0] temp_write_data; 
	bit temp_write; 

  function new(virtual intf h_intf,mailbox mbx);
    this.h_intf = h_intf;
    this.mbx = mbx;
	$display($time,"\t \t ********** input_monitor ***************");
  endfunction
  
  task run();
    tr_h = new();
    forever begin @(h_intf.cb_monitor);
     tr_h.PRESETn = h_intf.cb_monitor.PRESETn;
      tr_h.PSELx  = h_intf.cb_monitor.PSELx;
      tr_h.PADDR  = h_intf.cb_monitor.PADDR;
      tr_h.PENABLE= h_intf.cb_monitor.PENABLE;
      tr_h.PWDATA = h_intf.cb_monitor.PWDATA;
	  tr_h.PWRITE = h_intf.cb_monitor.PWRITE;
$display("\t \t \t -----------------------------");
		$display($time,"\t reset  =%d",tr_h.PRESETn);
		$display($time,"\t select  =%d",tr_h.PSELx);
		$display($time,"\t enable  =%d",tr_h.PENABLE);
		$display($time,"\t Adress  =%d",tr_h.PADDR);
		$display($time,"\t write data=%d",tr_h.PWDATA);
		$display($time,"\t w_signal =%d",tr_h.PWRITE);
$display("\t \t \t -----------------------------");



      mbx.put(tr_h);         // the values in the iterface are passing to the input monitor through mailbox
		//$display($time,"\t \t in input_monitor === %p ",tr_h);	
		write();
		read();
		error_write();
		error_read();
    end
  endtask

// ************************ self check *************************

//---------------- write task --------------------------------------
	task write();
		if(tr_h.PRESETn==0)
			begin
			//$display($time,"\t \t ------ write reset condition check  -----");
					foreach(memory[i])
						begin
							memory[i] = 32'd0;
						end
			end
				else
					begin
						if(tr_h.PSELx && !tr_h.PENABLE && tr_h.PWRITE)
								begin
									temp_addr 		= tr_h.PADDR;
									temp_write_data = tr_h.PWDATA;
									temp_write 		= tr_h.PWRITE;
								end
									else if(tr_h.PRESETn && tr_h.PSELx && tr_h.PENABLE && tr_h.PWRITE)
														if(h_intf.PREADY)
																	begin
																		memory[temp_addr] = tr_h.PWDATA;
																		$display($time,"\t \t memory[0%d] : %d",temp_addr,memory[temp_addr]);
																	end
					end
	endtask
//------------------- Read task --------------------------------------
	task read();
		if(tr_h.PRESETn==0)
			begin
			//$display($time,"\t \t ------ inread reset condition check  -----");
					foreach(memory[i])
						begin
							memory[i] = 32'd0;
						end
			end
				else
					begin
						if(tr_h.PSELx && !tr_h.PENABLE && !tr_h.PWRITE)
							begin
								temp_addr 		= tr_h.PADDR;
								temp_write_data = tr_h.PWDATA;
								temp_write 		= tr_h.PWRITE;
							end
								else if(tr_h.PSELx && tr_h.PENABLE && !tr_h.PWRITE)
										if(h_intf.PREADY)
													begin
														tr_h.PRDATA = memory[temp_addr];
														$display($time,"\t \t read data : %d",tr_h.PRDATA);
													end	
					end	
	endtask
//---------------------- error_write -----------------------------------
	task error_write();
		if(tr_h.PSELx && tr_h.PENABLE && tr_h.PWRITE)
				if(h_intf.PREADY)
						begin
							if(temp_addr != tr_h.PADDR || temp_write_data != tr_h.PWDATA || temp_write != tr_h.PWRITE)
								begin
									tr_h.PSLVERR = 1;
									$display($time,"\t \t error:%d",tr_h.PSLVERR);
								end
							else
								tr_h.PSLVERR = 0;
						end		
	endtask
//------------------ error_read ----------------------------------------
	task error_read();
		if(tr_h.PSELx && tr_h.PENABLE && !tr_h.PWRITE)
				if(h_intf.PREADY)
						begin
							if(temp_addr != tr_h.PADDR || temp_write_data != tr_h.PWDATA || temp_write != tr_h.PWRITE)
								tr_h.PSLVERR = 1;
							else
								tr_h.PSLVERR = 0;
						end		
	endtask
endclass
