////////////////////////score_board/////////////////////
class scoreboard;

	mailbox h_mbx1,h_mbx2;   // created two h_mbx1,2 for storing the data from the dut and data from the ip monitor(checker)
	transaction h_trans1,h_trans2;   
	function new(mailbox h_mbx1,h_mbx2);
		this.h_mbx1 = h_mbx1;            // checker mbx
		this.h_mbx2 = h_mbx2;            // dut mbx
	endfunction

	task run();
	begin
		forever
		begin
			h_trans1 = new();    // to handle the checker data
			h_trans2 = new();    // to handle dut data
			h_mbx1.get(h_trans1);  // getting daata ffrom checker to trans1
			h_mbx2.get(h_trans2);  //getting data from dut to trans2

			if(h_trans1.cout === h_trans2.cout)
			$display($time,"PASS \t DUT=%p \n checker=%p ",h_trans2,h_trans1);
			else
			$display($time,"FAIL \t DUT=%p \n checker=%p ",h_trans2,h_trans1);
		end
	end
	endtask

endclass
