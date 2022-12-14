class driver;

	transaction h_trans;    
	mailbox h_mbx;          
	virtual UDC_intf h_vintf;   
	function new(virtual UDC_intf h_vintf,mailbox h_mbx);   
		this.h_vintf = h_vintf;
		this.h_mbx = h_mbx;
	endfunction
	task run();
			h_vintf.cb_driver.reset <= 0;
		@(h_vintf.cb_driver) h_vintf.cb_driver.reset <= 1;
		@(h_vintf.cb_driver) h_vintf.cb_driver.reset <= 0;
			forever// runs untill $finish comes
					begin
						@(h_vintf.cb_driver) // @posedge clk 
						h_trans = new();
						h_mbx.get(h_trans);    // get is blocking until data is filled it wont take data in mailbox
						// taking randomized ips from trans handle
						h_vintf.cb_driver.ncs<=h_trans.ncs;
						h_vintf.cb_driver.reset<=h_trans.reset;
						h_vintf.cb_driver.nwr<=h_trans.nwr;
						h_vintf.cb_driver.nrd<=h_trans.nrd;
						h_vintf.cb_driver.A0<=h_trans.A0;
						h_vintf.cb_driver.A1<=h_trans.A1;
						h_vintf.cb_driver.start_in<=h_trans.start_in;
						h_vintf.cb_driver.din<=(h_trans.nwr==0)?h_trans.din:8'bz;
						

		//	$display($time,"\ndriver data is %p",h_trans);  
					end
	endtask

endclass
