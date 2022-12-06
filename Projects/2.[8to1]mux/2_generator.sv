
//====================GENERATOR======================//
class generator;

//---------------------properties-------------------------//
transaction ht1;  // handler for transaction class

mailbox h_mbx_1;    

//---------------------constructor-------------------------//

function new(mailbox incoming_mbx);                              //mistake ; not kept
				h_mbx_1=incoming_mbx;
		endfunction
//-----------------------method--------------------------//
task randomize_inputs();
repeat(20) begin  //randomizing 10 times
//#10
				ht1=new();
								if(ht1.randomize());
							//	ht1.randomize();             // variation will give warning 
								h_mbx_1.put(ht1);
							//	$display("-------------------1-------------------------");
									//	$display($time," \t inside the generator data in trans handle = %p ",ht1);
									//	$display($time," \t inside the generator data in mailbox 1 handle  = %p ",h_mbx_1);
								//	$display($time," \t inside the generator data in mailbox 1 handle = %0p ",h_mbx_1);
					end
endtask

endclass

/** Warning: 2_generator.sv(21): (vlog-2240) Treating stand-alone use of function 'randomize' as an implicit VOID cast.


 0 	 inside the generator data in trans handle = '{data_in:51, selection_in:2, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:68, selection_in:3, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:26, selection_in:1, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:39, selection_in:5, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:110, selection_in:5, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:119, selection_in:6, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:11, selection_in:5, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:77, selection_in:7, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:77, selection_in:6, clk:0, mux_out:0} 
#                    0 	 inside the generator data in trans handle = '{data_in:62, selection_in:5, clk:0, mux_out:0} 


















*/
