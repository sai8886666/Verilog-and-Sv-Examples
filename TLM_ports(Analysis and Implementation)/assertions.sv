

	module assert_module(

		input clock,

		input reset,

		input fifo_write,

		input fifo_read,

		input [7:0] fifo_data_in,

		input [7:0] fifo_data_out,

		input fifo_full,

		input fifo_empty,

		input [7:0] fifo_data_mem[0:7],

		input [2:0] FIFO_COUNT,

		input [2:0] write_pointer,

		input [2:0] read_pointer);

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//**************************************
	// 1) RESET CHECK
	//**************************************

		property p1;

			@(posedge clock) disable iff(!reset) ($rose(reset) |=> ((fifo_data_out==0)&&(fifo_full==0)&&(fifo_empty==1)));

		endproperty

		reset_check : assert property (p1)	$display($time,"-------------------------------------ASSERTED[RESET_CHECK]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[RESET_CHECK]----------------------------");

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//************************************
	// 2)  FIFO FULL CHECK
	//************************************


		property p2;

			@(posedge clock) disable iff(reset) ((FIFO_COUNT >= 7) |=> (fifo_full));		

		endproperty

		fifo_full_check : assert property(p2)   $display($time,"-------------------------------------ASSERTED[FIFO FULL CHECK]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[FIFO FULL CHECK]----------------------------");	

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//************************************
	// 3) FIFO EMPTY CHECK
	//************************************


		property p3;

			@(posedge clock) disable iff(reset) ((FIFO_COUNT == 0) |=> (fifo_empty));		

		endproperty

		fifo_empty_check : assert property(p3)   $display($time,"-------------------------------------ASSERTED[FIFO EMPTY CHECK]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[FIFO EMPTY CHECK]----------------------------");	

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//************************************
	// 4) FIFO COUNT INCREMENT  CHECK
	//************************************


		property p4;

			@(posedge clock) disable iff(reset) ((fifo_write)|=> (FIFO_COUNT == $past(FIFO_COUNT+1)));		

		endproperty

		fifo_count_increment_check : assert property(p4)   $display($time,"-------------------------------------ASSERTED[FIFO COUNT INCREMENT  CHECK]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[FIFO COUNT INCREMENT  CHECK]----------------------------");	

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//************************************
	// 5) FIFO COUNT DECREMENT  CHECK
	//************************************


		property p5;

			@(posedge clock) disable iff(reset) ((fifo_read)|=> (FIFO_COUNT == $past(FIFO_COUNT-1)));		

		endproperty

		fifo_count_decrement_check : assert property(p5)   $display($time,"-------------------------------------ASSERTED[FIFO COUNT DECREMENT  CHECK]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[FIFO COUNT DECREMENT  CHECK]----------------------------");	

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//************************************
	// 6)  WRITE POINTER INCREMENT CHECK
	//************************************

		property p6;

			@(posedge clock) disable iff(reset) ((fifo_write)|=> (write_pointer == $past(write_pointer+1)));		

		endproperty

		fifo_write_pointer_increment_check : assert property(p6)   $display($time,"-------------------------------------ASSERTED[WRITE POINTER INCREMENT CHECK]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[WRITE POINTER INCREMENT CHECK]----------------------------");	

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//************************************
	// 7)  READ POINTER INCREMENT CHECK
	//************************************


		property p7;

			@(posedge clock) disable iff(reset) ((fifo_read) |=> (read_pointer == $past(read_pointer+1)));		

		endproperty

		fifo_read_pointer_increment_check : assert property(p7)   $display($time,"-------------------------------------ASSERTED[READ POINTER INCREMENT CHECK]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[READ POINTER INCREMENT CHECK]----------------------------");	

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//************************************
	// 8)  FIFO DATA OUT CHECK
	//************************************

/*		property p8;

			@(posedge clock) disable iff(reset) ((fifo_read) |=> (fifo_data_out != $past(fifo_data_out)));		

		endproperty

		fifo_data_out_check : assert property(p8)   $display($time,"-------------------------------------ASSERTED[FIFO DATA OUT CHECK]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[FIFO DATA OUT CHECK]----------------------------");	*/

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	
	//************************************
	// 9)   CHECK
	//************************************

/*		property p9;

			@(posedge clock) disable iff(reset) ();		

		endproperty

		fifo_data_out_check : assert property(p9)   $display($time,"-------------------------------------ASSERTED[]------------------------------") ;
									 else 	$display($time,"-----------------------------------NOT ASSERTED[]----------------------------");	*/

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	endmodule
