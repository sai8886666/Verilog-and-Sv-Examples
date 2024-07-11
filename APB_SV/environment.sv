//************** environment ***************************
class environment;
	mailbox gen_mbx,in_mbx,out_mbx;
	generator h_gen;
	driver h_driv;
	input_monitor h_in;
	output_monitor h_out;
	scoreboard h_sb;
	coverage h_cov;
	virtual intf h_intf;
	int i=0;
			function new(virtual intf h_intf);
				this. h_intf = h_intf;
				gen_mbx = new();
				in_mbx = new();
				out_mbx = new();
			
				h_gen = new(gen_mbx);
				h_driv = new(h_intf,gen_mbx);    //pass the interface handle and the mailbox handle in env to point the mailbox and the interface handle in the driver class
				h_in = new(h_intf,in_mbx);			// """"
				h_out = new(h_intf,out_mbx);
				h_sb = new(in_mbx,out_mbx);
				h_cov = new(h_intf);
			$display($time,"\t \t ******** at environment **********");
			endfunction

		task run();
			begin//{
fork
begin 

//****************************************************  with out randomizig adress and data(errors) ************************************************************
 

				//run(PRESETn,PSELx,PENABLE,PWRITE,PADDR,PWDATA);
				$display($time,"\t \t >>>>>>>>>>>======== all equal to zero=======<<<<<<<<<<");
				 h_gen.run_0(0,0,0,0);
				$display($time,"\t \t >>>>>>>>>>>======== reset it and select high=======<<<<<<<<<<");
				 h_gen.run_0(0,1,0,0);

				$display($time,"\t \t >>>>>>>>>>>======== reset it and enable high=======<<<<<<<<<<<<");
				 h_gen.run_0(0,0,1,0);
				 
				$display($time,"\t \t >>>>>>>>>>>>======== reset it and write high=======<<<<<<<<<<<<<");
				 h_gen.run_0(0,0,0,1);
				 					 
				$display($time,"\t \t >>>>>>>>>>>>======== idle write high =======<<<<<<<<<<<<<<<<<");
				h_gen.run_0(1,0,0,1);
				
				$display($time,"\t \t >>>>>>>>>>>======== no reset and select high=======<<<<<<<<<<");
				 h_gen.run_0(1,1,0,0);
				 
				$display($time,"\t \t >>>>>>>>>>>======== no reset and enable high=======<<<<<<<<<<<<");
				 h_gen.run_0(1,0,1,0);
				 
				$display($time,"\t \t >>>>>>>>>>>>======== no reset and write high=======<<<<<<<<<<<<<");
				 h_gen.run_0(1,0,0,1);

				$display($time,"\t \t >>>>>>>>>>>>>>======== different adress =======<<<<<<<<<<<<<<<<<<<<<");
                h_gen.run(1,1,0,1,2600,16);  //(write_setup)
                h_gen.run(1,1,1,1,2700,16);	//(write_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

                h_gen.run(1,1,0,0,2600,16);    //(read_setup)
                h_gen.run(1,1,1,0,2700,16);	//(read_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

				$display($time,"\t \t >>>>>>>>>>>>>======= comtinous write and read in diff adress =======<<<<<<<<<<<<<<<<<<<");
					 h_gen.run(1,1,0,1,2000,30);  //(write_setup)
                h_gen.run(1,1,1,1,2000,30);	//(write_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

				    h_gen.run(1,1,0,1,2400,33);  //(write_setup1)
                h_gen.run(1,1,1,1,2400,33);	//(write_access1)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

					 h_gen.run(1,1,0,1,2500,35);  //(write_setup2)
                h_gen.run(1,1,1,1,2500,35);	//(write_access2)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

						//---------------
                h_gen.run(1,1,0,0,2000,30);    //(read_setup)
                h_gen.run(1,1,1,0,2000,30);	//(read_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

                h_gen.run(1,1,0,0,2400,33);  //(read setup1)  
					 h_gen.run(1,1,1,0,2400,33);	//(read_access1)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

                h_gen.run(1,1,0,0,2500,35);    //(read_setup2)
                h_gen.run(1,1,1,0,2500,35);	//(read_access2)
					 wait(h_intf.cb_monitor.PREADY==0);
					 wait(h_intf.cb_monitor.PREADY==1);

				$display($time,"\t \t >>>>>>>>>>>>>======= comtinous write and read in same adress =======<<<<<<<<<<<<<<<<<<<");
					
					 h_gen.run(1,1,0,1,1000,100);  //(write_setup)
                h_gen.run(1,1,1,1,1000,100);	//(write_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

					 h_gen.run(1,1,0,1,1000,200);  //(write_setup1)
                h_gen.run(1,1,1,1,1000,200);	//(write_access1)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
					 h_gen.run(1,1,0,1,1000,300);  //(write_setup2)
                h_gen.run(1,1,1,1,1000,300);	//(write_access2)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

						//---------------vsim:/top/DUT
                h_gen.run(1,1,0,0,1000,100);    //(read_setup)
                h_gen.run(1,1,1,0,1000,100);	//(read_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
                h_gen.run(1,1,0,0,1000,200);    //(read_setup1)
                h_gen.run(1,1,1,0,1000,200);	//(read_access1)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
                h_gen.run(1,1,0,0,1000,300);    //(read_setup2)
                h_gen.run(1,1,1,0,1000,300);	//(read_access2)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
				$display($time,"\t \t >>>>>>>>>>>>>======= comtinous write and read in diff adress same data =======<<<<<<<<<<<<<<<<<<<");
					 h_gen.run(1,1,0,1,1100,50);  //(write_setup)
                h_gen.run(1,1,1,1,1100,50);	//(write_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 h_gen.run(1,1,0,1,1200,50);  //(write_setup1)
                h_gen.run(1,1,1,1,1200,50);	//(write_access1)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
					 h_gen.run(1,1,0,1,1300,50);  //(write_setup2)
                h_gen.run(1,1,1,1,1300,50);	//(write_access2)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
						//---------------
                h_gen.run(1,1,0,0,1100,50);    //(read_setup)
                h_gen.run(1,1,1,0,1100,50);	//(read_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
                h_gen.run(1,1,0,0,1200,50);    //(read_setup1)
                h_gen.run(1,1,1,0,1200,50);	//(read_access1)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
                h_gen.run(1,1,0,0,1300,50);    //(read_setup2)
                h_gen.run(1,1,1,0,1300,50);	//(read_access2)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
				$display($time,"\t \t >>>>>>>>>>>>>======= comtinous write and read in same adress same data =======<<<<<<<<<<<<<<<<<<<");
					 h_gen.run(1,1,0,1,1400,60);  //(write_setup)
                h_gen.run(1,1,1,1,1400,60);	//(write_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
					 h_gen.run(1,1,0,1,1400,60);  //(write_setup1)
                h_gen.run(1,1,1,1,1400,60);	//(write_access1)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
				 
					 h_gen.run(1,1,0,1,1400,60);  //(write_setup2)
                h_gen.run(1,1,1,1,1400,60);	//(write_access2)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
						//---------------
                h_gen.run(1,1,0,0,1400,60);    //(read_setup)
                h_gen.run(1,1,1,0,1400,60);	//(read_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);					 
                h_gen.run(1,1,0,0,1400,60);    //(read_setup1)
                h_gen.run(1,1,1,0,1400,60);	//(read_access1)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
                h_gen.run(1,1,0,0,1400,60);    //(read_setup2)
                h_gen.run(1,1,1,0,1400,60);	//(read_access2) 
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

//****************************************************  with randomizig adress and data ****************************************************************************************

				//run(PRESETn,PSELx,PENABLE,PWRITE);	
				 

				$display($time,"\t \t >>>>>>>>>>>>======== idle=======<<<<<<<<<<<<<<");
                h_gen.run_0(1,0,0,0);
				 				 
				$display($time,"\t \t >>>>>>>>>>>>======== normal read and write =======<<<<<<<<<<<<<<<<<<<<");	
                h_gen.run_0(1,1,0,1);  //(write_setup)
                h_gen.run_0(1,1,1,1);	//(write_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
                h_gen.run_0(1,1,0,0);    //(read_setup)
                h_gen.run_0(1,1,1,0);	//(read_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

				$display($time,"\t \t >>>>>>>>>>>>>======== in write access selection is low =======<<<<<<<<<<<<<<<<<<<");
                h_gen.run_0(1,1,0,1);  //(write_setup)
                h_gen.run_0(1,0,1,1);	//(write_access)
					 
                h_gen.run_0(1,1,0,0);    //(read_setup)
                h_gen.run_0(1,1,1,0);	//(read_access)
					 
				$display($time,"\t \t >>>>>>>>>>>>>========in read access selection is low=======<<<<<<<<<<<<<<<<<<<");
                h_gen.run_0(1,1,0,1);  //(write_setup)
                h_gen.run_0(1,1,1,1);	//(write_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
                h_gen.run_0(1,1,0,0);    //(read_setup)
                h_gen.run_0(1,0,1,0);	//(read_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);

					 
				$display($time,"\t \t >>>>>>>>>>>>>======= reset it in setup while write =======<<<<<<<<<<<<<<<<<<<");
				    h_gen.run_0(0,1,0,1);  //(write_setup)
                h_gen.run_0(1,1,1,1);	//(write_access)					 
                h_gen.run_0(1,1,0,0);    //(read_setup)
                h_gen.run_0(1,1,1,0);	//(read_access)
					 
				$display($time,"\t \t >>>>>>>>>>>>>======= reset it in access while write =======<<<<<<<<<<<<<<<<<<<");
				    h_gen.run_0(1,1,0,1);  //(write_setup)
                h_gen.run_0(0,1,1,1);	//(write_access)					 
                h_gen.run_0(1,1,0,0);    //(read_setup)
                h_gen.run_0(1,1,1,0);	//(read_access)
					 					 
				$display($time,"\t \t >>>>>>>>>>>>>======= reset it in setup while read =======<<<<<<<<<<<<<<<<<<<");
				    h_gen.run_0(1,1,0,1);  //(write_setup)
                h_gen.run_0(1,1,1,1);	//(write_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 					 
                h_gen.run_0(0,1,0,0);    //(read_setup)
                h_gen.run_0(1,1,1,0);	//(read_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
				$display($time,"\t \t >>>>>>>>>>>>>======= reset it in access while read =======<<<<<<<<<<<<<<<<<<<");
					 h_gen.run_0(1,1,0,1);  //(write_setup)
                h_gen.run_0(1,1,1,1);	//(write_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 					 
                h_gen.run_0(1,1,0,0);    //(read_setup)
                h_gen.run_0(0,1,1,0);	//(read_access)
						wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
					 
					 
				$display($time,"\t \t >>>>>>>>>>>>>======= write signal low in access state while write =======<<<<<<<<<<<<<<<<<<<");
					 h_gen.run_0(1,1,0,1);  //(write_setup)
                h_gen.run_0(1,1,1,0);	//(write_access)
					 					 
                h_gen.run_0(1,1,0,0);    //(read_setup)
                h_gen.run_0(0,1,1,0);	//(read_access)
		


					 
					 

//*********************************************************sequemce ***************************************************************************************

		$display($time,"\t \t >>>>>>>>>>>>======== =========normal read and write =======<<<<<<<<<<<<<<<<<<<<");	
				//run(PRESETn,PSELx,PENABLE,PWRITE,PADDR);	
				for(i=0;i<=32;i++)
					begin
                h_gen.run_1(1,1,0,1,i);  //(write_setup)
                h_gen.run_1(1,1,1,1,i);	//(write_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
                h_gen.run_1(1,1,0,0,i);  //(read_setup)
                h_gen.run_1(1,1,1,0,i);	//(read_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);					 
					end  
//*******************************************************sequencxe********************************************************************************************
					 
		$display($time,"\t \t >>>>>>>>>>>>======== =========normal read and write =======<<<<<<<<<<<<<<<<<<<<");	
				//run(PRESETn,PSELx,PENABLE,PWRITE,PADDR);	
				for(i=32;i<=127;i++)
					begin
                h_gen.run_1(1,1,0,1,i);  //(write_setup)
                h_gen.run_1(1,1,1,1,i);	//(write_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
                h_gen.run_1(1,1,0,0,i);  //(read_setup)
                h_gen.run_1(1,1,1,0,i);	//(read_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);					 
					end  

		$display($time,"\t \t >>>>>>>>>>>>======== =========normal read and write =======<<<<<<<<<<<<<<<<<<<<");	
				//run(PRESETn,PSELx,PENABLE,PWRITE,PADDR);	
				for(i=127;i<=227;i++)
					begin
                h_gen.run_1(1,1,0,1,i);  //(write_setup)
                h_gen.run_1(1,1,1,1,i);	//(write_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
                h_gen.run_1(1,1,0,0,i);  //(read_setup)
                h_gen.run_1(1,1,1,0,i);	//(read_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);					 
					end  
		$display($time,"\t \t >>>>>>>>>>>>======== =========normal read and write =======<<<<<<<<<<<<<<<<<<<<");	
				//run(PRESETn,PSELx,PENABLE,PWRITE,PADDR);	
				for(i=227;i<=1227;i++)
					begin
                h_gen.run_1(1,1,0,1,i);  //(write_setup)
                h_gen.run_1(1,1,1,1,i);	//(write_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);
                h_gen.run_1(1,1,0,0,i);  //(read_setup)
                h_gen.run_1(1,1,1,0,i);	//(read_access)
					 	wait(h_intf.cb_monitor.PREADY==0);
						wait(h_intf.cb_monitor.PREADY==1);					 
					end  

			end
				h_driv.run();
				h_in.run();
				h_out.run();
				h_sb.run();
				h_cov.run();
join
		end//}
			
		endtask
endclass
