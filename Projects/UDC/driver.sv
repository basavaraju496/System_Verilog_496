class driver;

	transaction h_trans;    
	mailbox h_mbx;          
	virtual dff_intf h_vintf;   
	function new(virtual dff_intf h_vintf,mailbox h_mbx);   
		this.h_vintf = h_vintf;
		this.h_mbx = h_mbx;
	endfunction
	task run();
			forever// runs untill $finish comes
					begin
						@(h_vintf.cb_driver) // @posedge clk 
						h_trans = new();
						h_mbx.get(h_trans);    
						// taking randomized ips from transhandle
						h_vintf.cb_driver.ncs<=0;//h_trans.preset;
						h_vintf.cb_driver.reset<=0;//h_trans.clear_in;
						h_vintf.cb_driver.nwr<=1;
						h_vintf.cb_driver.nrd<=1;//h_trans.enable;
						h_vintf.cb_driver.A0<=1;//h_trans.enable;
						h_vintf.cb_driver.A1<=1;//h_trans.enable;
						h_vintf.cb_driver.din<=h_trans.din;//h_trans.enable;

					end
	endtask

endclass
