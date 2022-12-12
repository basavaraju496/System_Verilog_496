class driver;

	transaction h_trans;
	mailbox h_mbx;
	virtual memoryInterface h_memintf;

	function new(virtual memoryInterface h_memintf,mailbox h_mbx);
		this.h_mbx = h_mbx;
		this.h_memintf = h_memintf;
	endfunction

	task run();
		h_memintf.cb_driver.reset <= 0;
		@(h_memintf.cb_driver) h_memintf.cb_driver.reset <= 1;
		@(h_memintf.cb_driver) h_memintf.cb_driver.reset <= 0;

		forever begin
			@(h_memintf.cb_driver)
			h_trans = new();
			//extracting signals data from generator mailbox
			h_mbx.get(h_trans);

			//passing data from generator to interface
			h_memintf.cb_driver.data_in <= h_trans.data_in;
			h_memintf.cb_driver.addr <= h_trans.address;
			h_memintf.cb_driver.wr_en <= h_trans.wr_enable;
		end
	endtask

endclass
