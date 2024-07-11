//-------------- sequence_item --------------------

class sequence_item extends uvm_sequence_item;
	//`uvm_object_utils(sequence_item);   //((factory registration)

	function new(string name = "sequence_item");
		super.new(name);
	endfunction

   rand bit  PRESETn;            //reset signal
   randc bit [31:0]PADDR;         //Adress
   rand bit PSELx;				  // slave select signal
   rand bit PENABLE;			  //Enable signal
   rand bit PWRITE;			  // write enable signal
   randc bit [31:0] PWDATA;		  // data written
    bit PREADY;					  // ready signal
    bit [31:0]  PRDATA;			  // read data
    bit PSLVERR;				  // error signal

	static bit [31:0] adress;
	static bit [31:0] data;

		constraint range {
						 PADDR inside {[0:5000]};
					 	 PWDATA inside {[0:1000]};
														}

//----------------- field macros -----------------------------
		`uvm_object_utils_begin(sequence_item)
			`uvm_field_int(PRESETn,UVM_NOCOPY);
			`uvm_field_int(PADDR,UVM_ALL_ON || UVM_UNSIGNED);
			`uvm_field_int(PSELx,UVM_ALL_ON);
			`uvm_field_int(PENABLE,UVM_ALL_ON);
			`uvm_field_int(PWDATA,UVM_ALL_ON || UVM_UNSIGNED);
			`uvm_field_int(PREADY,UVM_ALL_ON);
			`uvm_field_int(PRDATA,UVM_ALL_ON || UVM_UNSIGNED);
			`uvm_field_int(PSLVERR,UVM_ALL_ON);
		`uvm_object_utils_end
	
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
