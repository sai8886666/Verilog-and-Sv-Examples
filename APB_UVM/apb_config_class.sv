//----------------------------- APB_config class ---------------------------


class apb_config extends uvm_object;
	`uvm_object_utils(apb_config)   //factory registration



/*------------ declare all the internal signals ---------------------*/
	bit [3:0] config_a;


/*------------------- constructor phase--------------------------
---- constructor for the  factory registered component ----------*/
	function new(string name = "");
		super.new(name);
	endfunction


endclass
