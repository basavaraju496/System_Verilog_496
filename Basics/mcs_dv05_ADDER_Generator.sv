class generator;
	transaction h_trx;
	mailbox h_mbx;

	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;
	endfunction

	task run();
		forever begin
			h_trx = new();
			if(h_trx.randomize());
			h_mbx.put(h_trx);
			//$display("%p",h_trx);
		end
	endtask
endclass
