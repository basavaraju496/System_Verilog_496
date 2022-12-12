//`include "A5_Q5_Transaction.sv"
class generator;

	transaction h_trans;
	mailbox h_mbx;

	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;
	endfunction

	task run();
		repeat(50) begin
			h_trans = new();
			if(h_trans.randomize());
			h_mbx.put(h_trans);
		end
	endtask

endclass
