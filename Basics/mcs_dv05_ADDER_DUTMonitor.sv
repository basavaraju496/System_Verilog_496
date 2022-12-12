class dutMonitor;

	virtual adder_intf h_intf;
	mailbox h_mbx;
	transaction h_trx;

	function new(virtual adder_intf h_intf,mailbox h_mbx);
		this.h_mbx = h_mbx;
		this.h_intf = h_intf;
	endfunction

	task run();
		begin
			forever@(h_intf.cb_monitor) begin
				h_trx = new();
				h_trx.in1 = h_intf.cb_monitor.in1;
				h_trx.in2 = h_intf.cb_monitor.in2;
				h_trx.reset = h_intf.cb_monitor.reset;
				//$display("DUTM %p",h_trx);
				h_trx.sum = h_intf.cb_monitor.sum;

				h_mbx.put(h_trx);
			end
		end
	endtask
endclass
