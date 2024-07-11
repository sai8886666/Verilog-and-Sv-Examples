//--------------- top module ------------------------



module top;
//	test h_test;
	bit PCLK;
	always #1 PCLK++;

	test h_test;
  	intf h_intf(PCLK);

apb_logi DUT(.pclk(h_intf.PCLK),.reset_n(h_intf.PRESETn),.paddress(h_intf.PADDR),.pwdata(h_intf.PWDATA),.pwrite(h_intf.PWRITE),.pselx(h_intf.PSELx),.penable(h_intf.PENABLE),.pslverr(h_intf.PSLVERR),.pready(h_intf.PREADY),.prdata(h_intf.PRDATA));



	initial begin
		h_test = new(h_intf);
		h_test.run();
	end

	initial begin
		#21000 $finish;
	end
		
endmodule
