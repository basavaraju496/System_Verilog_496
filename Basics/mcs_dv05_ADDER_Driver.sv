class driver;

	virtual adder_intf h_intf;
	mailbox h_mbx;
	transaction h_trx;

	function new(virtual adder_intf h_intf,mailbox h_mbx);
		this.h_mbx = h_mbx;
		this.h_intf = h_intf;
	endfunction

	task run();
		begin
			h_intf.cb_driver.reset <=0;
			@(h_intf.cb_driver) h_intf.cb_driver.reset <=1;
			@(h_intf.cb_driver) h_intf.cb_driver.reset <=0;

			forever@(h_intf.cb_driver) begin
				h_trx = new();
				h_mbx.get(h_trx);
				h_intf.cb_driver.in1 <= h_trx.in1;
				h_intf.cb_driver.in2 <= h_trx.in2;
				h_intf.cb_driver.reset <= h_trx.reset;
			//	$display("driver %p",h_trx);
			end
		end
	endtask
endclass
