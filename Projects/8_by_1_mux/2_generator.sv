
//====================GENERATOR======================//
class generator;

//---------------------properties-------------------------//
transaction ht1;  // handler for transaction class

mailbox h_mbx_1;    

//---------------------constructor-------------------------//

function new(mailbox incoming_mbx)
				h_mbx_1=incoming_mbx;
		endfunction
//-----------------------method--------------------------//
task randomize_inputs();
repeat(10) begin  //randomizing 10 times

				ht1=new();
							//	if(ht.randomize());
								ht1.randomize();             // variation
								h_mbx_1.put(ht1);
										$display($time," \t inside the generator data in trans handle = %p ",ht1);
										$display($time," \t inside the generator data in mailbox 1 handle  = %p ",h_mbx_1);
										$display($time," \t inside the generator data in mailbox 1 handle = %0p ",h_mbx_1);
					end
endtask

endclass
