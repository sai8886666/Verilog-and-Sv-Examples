//********* transaction class **********
class transaction;
   randc bit  PRESETn;            //reset signal
   randc bit [31:0]PADDR;         //Adress
   randc bit PSELx;				  // slave select signal
   randc bit PENABLE;			  //Enable signal
   randc bit PWRITE;			  // write enable signal
   randc bit [31:0] PWDATA;		  // data written
    bit PREADY;					  // ready signal
    bit [31:0]  PRDATA;			  // read data
    bit PSLVERR;				  // error signal

	static bit [31:0] adress;
	static bit [31:0] data;

	constraint range {
						soft PADDR inside {[0:4000]};
					 	soft PWDATA inside {[0:200]};
						soft PADDR > 4000;
						//	PADDR%2==0;
												}
	constraint even{ (PADDR == (PADDR%2==0)) -> PWDATA == (PWDATA%2 == 0);   }
	constraint odd {(PADDR == (PADDR%3==0)) -> PWDATA == 0;   }
	//constraint distributive{soft PADDR dist{[0:255]:=40, [255:2048]:=40 , [2049:10737]:=60};  }  
//	constraint distributive_1 {PWDATA dist {50:/70, 150:/70, [215:225]:=70};	}


	function void post_randomize();
		if(PSELx ==1 && PENABLE ==0 && PWRITE ==1)
			begin
				adress = PADDR;
				data   = PWDATA;
			end
		else if (PSELx ==1 && PENABLE == 1 && PWRITE == 1)
				//else
							begin
							PADDR = adress;
							PWDATA= data;
							end
		else if (PWRITE == 0)
							begin
							PADDR = adress;
							PWDATA= data;
							end
	endfunction   

endclass
