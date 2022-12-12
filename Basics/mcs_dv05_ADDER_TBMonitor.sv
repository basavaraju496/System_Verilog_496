class tbMonitor;

	virtual adder_intf h_intf;
	mailbox h_mbx;
	transaction h_trx;

	function new(virtual adder_intf h_intf,mailbox h_mbx);
		this.h_mbx = h_mbx;
		this.h_intf = h_intf;
	endfunction

	task run();
		begin
		//	$display("TBM %p",h_trx);
			forever begin
				@(h_intf.cb_monitor)
				h_trx = new();
				h_trx.in1 = h_intf.cb_monitor.in1;
				h_trx.in2 = h_intf.cb_monitor.in2;
				h_trx.reset = h_intf.cb_monitor.reset;

				h_trx.sum = (h_trx.reset ==0) ? h_trx.in1+h_trx.in2 : 0;

				h_mbx.put(h_trx);
			//	$display("TBM %p",h_intf.cb_monitor.in1);
			end
		end
	endtask
endclass
