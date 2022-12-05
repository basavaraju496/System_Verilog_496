//=========================ENVIRONMENT ====================//

 class environment;

//--------------------------HANDLERS-----------------------//
	virtual mux_out h_vintf;     
	mailbox h_mbx_1,h_mbx_2,h_mbx_3;

	generator h_generator;    // genertor class handler
	driver h_driver;          // driver class handler
	input_monitor h_ip_monitor;   // ip monitor class handler
	output_monitor h_op_monitor;   // op monitr class handler
	scoreboard h_score_board;      // scoreboard class handler

//---------------------constructor-------------------------//

function new(virtual adder_intf h_vintf);
	this.h_vintf = h_vintf;
	h_mbx_1 = new();   // creating memory for generator handle
	h_mbx_2 = new();  // creating memory for ipmo handle(checker)
	h_mbx_3 = new();  // creating memory for opmo handle(dut op)

	h_generator = new(h_mbx_1); 
	h_driver = new(h_vintf,h_mbx_1);   
	h_ip_monitor = new(h_vintf,h_mbx_2);  
	h_op_monitor = new(h_vintf,h_mbx_3);   
	h_score_board = new(h_mbx_2,h_mbx_3);  

endfunction
//-----------------------method--------------------------//
task run();
	fork
		h_generator.randomize_inputs();  
		h_driver.drive_to_interface();  
		h_ip_monitor.take_ip_do_checker();
		h_op_monitor.take_from_dut();
		h_score_board.comparator();
	join
endtask

endclass
