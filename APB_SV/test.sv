//-------------- test class--------------------------

class test;
	environment h_env;
	virtual intf h_intf;

		function new(virtual intf h_vintf);
			h_intf = h_vintf;
			h_env = new(h_vintf);  // passing the handle of interface  in test to point the interface handle in environment
			$display($time,"\t \t ******** At test **********");
		endfunction

	task run();
		h_env.run();
	endtask

endclass
