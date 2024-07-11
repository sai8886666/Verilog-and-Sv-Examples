//********** generator *******************

class generator;
  transaction tr_h;
  mailbox mbx;
  
  function new(mailbox mbx);
    this.mbx = mbx;
    $display($time,"\t \t **************** generator ***********");
  endfunction
//************************* task for normal arguments passing with out randomizating adress and data*************************************
  
 	task run(input logic Reset,input logic select,input logic enable,input logic write,input bit [31:0]adress1,input bit [31:0]data1);
			tr_h = new();           // creating the memory 
    		assert(tr_h.randomize() with {tr_h.PRESETn == Reset; tr_h.PSELx==select; tr_h.PENABLE==enable; tr_h.PWRITE==write; tr_h.PADDR==adress1; tr_h.PWDATA==data1;});
    		mbx.put(tr_h);      // after randomzing pass the signals through mailbox
		//	$display($time,"\t \t in genar == %p",tr_h);
      $display("[][][][[][[ %p",mbx);
 	 endtask 

//************************* task for normal arguments passing with  randomizating adress and data*************************************

	task run_0(input logic reset1, input logic select1, input logic enable1, input logic write1);
		tr_h = new();
		assert(tr_h.randomize() with {tr_h.PRESETn == reset1; tr_h.PSELx == select1; tr_h.PENABLE == enable1; tr_h.PWRITE == write1 ;});
		mbx.put(tr_h);	
		//	$display($time,"\t \t in genar == %p",tr_h);
	endtask   

//*************************  passing with  sequence *************************************

	task run_1(input logic reset, input logic select, input logic enable, input logic write, input logic[31:0] address);
		tr_h = new();
		assert(tr_h.randomize() with {tr_h.PRESETn == reset; tr_h.PSELx == select; tr_h.PENABLE == enable; tr_h.PWRITE == write; tr_h.PADDR == address;});
		mbx.put(tr_h);	
		//	$display($time,"\t \t in genar == %p",tr_h);
	endtask

endclass
