///////////////////////////.environment/////////////////////////////
class environment;

	virtual UDC_intf h_vintf;    
	mailbox h_mbx_gen,h_mbx_ipmo,h_mbx_opmo;
	generator h_gen;   
	driver h_driv;         
	input_monitor h_ipmo;  
	output_monitor h_opmo;  
	scoreboard h_scrbd;      

function new(virtual UDC_intf h_vintf);
	this.h_vintf = h_vintf;
	h_mbx_gen = new();  
	h_mbx_ipmo = new(); 
	h_mbx_opmo = new(); 
	h_gen = new(h_mbx_gen);           
	h_driv = new(h_vintf,h_mbx_gen); 
	h_ipmo = new(h_vintf,h_mbx_ipmo); 
	h_opmo = new(h_vintf,h_mbx_opmo);  
	h_scrbd = new(h_mbx_ipmo,h_mbx_opmo); 
endfunction

/*task run();
	fork
		h_gen.run(); 
		h_driv.run();  
		h_ipmo.run();
		h_opmo.run();
		h_scrbd.run();
	join
endtask*/

	task run();
		fork
			begin
		/*	$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			$display("\t\t\t\t TEST CASE 0 - Reset and Read");
			$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
					h_gen.task_reset;   // reset test
					h_gen.task_read;    // read after reset
			$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			$display("\t\t\t\t TEST CASE 1 - Write and Read");
			$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

					h_gen.task_write(10,15,5,1);     // writing with basic values
					h_gen.task_read;    // read after write
			$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			$display("\t\t\t\t TEST CASE 2 - ncs=1 and reset=1 ");
			$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				h_gen.task_basic(1,1,1,0);//ncs nwr nrd reset
			$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			$display("\t\t\t\t TEST CASE 3 - ncs=0 and reset=0 nwr=1 nrd=1 ");
			$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
				h_gen.task_basic(0,1,1,0);//ncs nwr nrd reset*/
//========================================================counter cases==============================================================================//
				h_gen.task_write_start_count(10,15,5,1,1);    // PLR ULR LLR CCR   basic

				wait(h_vintf.ec == 0);
				wait(h_vintf.ec == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.task_write_start_count(5,5,5,1,1);    // PLR ULR LLR CCR   basic

				wait(h_vintf.ec == 0);

				wait(h_vintf.ec == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.task_write_start_count(5,10,5,1,1);//PLR=LLR



				wait(h_vintf.ec == 0);

				wait(h_vintf.ec == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.task_write_start_count(10,10,5,1,1);//PLR=ULR

			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.task_write_start_count(5,7,3,1,1);//PLR=ULR-2=LLR+2

			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.task_write_start_count(5,6,4,1,1);//PLR=ULR-1=LLR+1

			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.task_write_start_count(5,7,5,1,1);//PLR=LLR=ULR-2

			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.task_write_start_count(7,7,5,1,1);//PLR=ULR=LLR+2

			//wait(h_vintf.ec==0);
			//	wait(h_vintf.ec == 1);
			//	repeat(2)@(h_vintf.cd_monitor);
			//	h_gen.task_write_start_count(0,255,0,1,1); // error in dut 

/*
repeat(1) begin//{
		//	wait(h_vintf.ec==0);
		//		wait(h_vintf.ec == 1);
				//			repeat(2)@(h_vintf.cd_monitor);
									h_gen.task_write_random;

			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
							repeat(2)@(h_vintf.cd_monitor);
									h_gen.task_write_random;
			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
							repeat(2)@(h_vintf.cd_monitor);
									h_gen.task_write_random;
			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
							repeat(2)@(h_vintf.cd_monitor);
									h_gen.task_write_random;
			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
							repeat(2)@(h_vintf.cd_monitor);
									h_gen.task_write_random;
			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
							repeat(2)@(h_vintf.cd_monitor);
									h_gen.task_write_random;
			wait(h_vintf.ec==0);
				wait(h_vintf.ec == 1);
							repeat(2)@(h_vintf.cd_monitor);
									h_gen.task_write_random;
									end//}*/


			end
		h_driv.run();  
		h_ipmo.run();
		h_opmo.run();
		h_scrbd.run();
		join
	endtask



endclass

/*
 1.ec is coming in next pulse for normal case and co
 2.count is same after ec also
 
 
 
				h_gen.task_write_start_count(0,255,0,1,1);   // error case
 
 
 
 
 
 
 
 
 */


