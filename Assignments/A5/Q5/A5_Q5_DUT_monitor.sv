class dutmonitor;

	transaction h_trans;
	mailbox h_mbx;
	virtual memoryInterface h_memintf;

	function new(virtual memoryInterface h_memintf,mailbox h_mbx);
		this.h_memintf = h_memintf;
		this.h_mbx = h_mbx;
	endfunction

	task run();
		begin
			forever begin
				@(h_memintf.cb_monitor)
				h_trans = new();

				h_trans.reset = h_memintf.cb_monitor.reset;
				h_trans.data_in = h_memintf.cb_monitor.data_in;
				h_trans.address = h_memintf.cb_monitor.addr;
				h_trans.wr_enable = h_memintf.cb_monitor.wr_en;
				h_trans.data_out = h_memintf.cb_monitor.data_out;

				//mailbox data insertion
				h_mbx.put(h_trans);
			end
		end
	endtask

endclass
