//------------- score board--------------------------



class scoreboard;
	mailbox mbx1,mbx2;
	transaction tr_h1,tr_h2;
		
		function new(mailbox mbx1,mbx2);
			this.mbx1 = mbx1;
			this.mbx2 = mbx2;
			$display($time,"\t \t ******** scoreboard **********");
		endfunction

		task run();
			tr_h1 = new();
			tr_h2 = new();
			 repeat(50) begin
			mbx1.get(tr_h1);     // take the vlues from input monitor mailbox
			mbx2.get(tr_h2);    // take the vlues from output monitor mailbox
		/*	if(tr_h1.PRDATA == tr_h2.PRDATA && tr_h1.PREADY == tr_h2.PREADY && tr_h1.PSLVERR == tr_h2.PSLVERR)
				$display($time,"\t \t ==PASS== in verification::adress:tr_h1.PRDATA=%d tr_h1.PREADY=%d tr_h1.PSLVERR=%d [##] in DUT::tr_h2.PRDATA=%d tr_h2.PREADY=%d tr_h2.PSLVERR=%d",tr_h1.PRDATA,tr_h1.PREADY,tr_h1.PSLVERR,tr_h2.PRDATA,tr_h2.PREADY,tr_h2.PSLVERR);
			else
				$display($time,"\t \t ==FAIL== in verification::adress:tr_h1.PRDATA=%d tr_h1.PREAD=%d tr_h1.PSLVERR=%d [##] in DUT::tr_h2.PRDATA=%d tr_h2.PREADY=%d tr_h2.PSLVERR=%d",tr_h1.PRDATA,tr_h1.PREADY,tr_h1.PSLVERR,tr_h2.PRDATA,tr_h2.PREADY,tr_h2.PSLVERR);*/
			//end	

			end
		endtask
endclass
