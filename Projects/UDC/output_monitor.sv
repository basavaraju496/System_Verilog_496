class output_monitor;

	virtual dff_intf h_vintf; 
	mailbox h_mbx;             
	transaction h_trans;      
	function new(virtual dff_intf h_vintf,mailbox h_mbx); 
		this.h_vintf = h_vintf;
		this.h_mbx = h_mbx;
	endfunction

task run();
begin
	forever
	begin
		@(h_vintf.cb_monitor)  // taking ips and ops with zero delay 
		h_trans = new();
		// collecting ops from dut
		h_trans.preset = h_vintf.cb_monitor.preset; 
		h_trans.clear_in = h_vintf.cb_monitor.clear_in; 
		h_trans.enable= h_vintf.cb_monitor.enable; 
		h_trans.din = h_vintf.cb_monitor.din;  // taking out from intf(it got from dut)
		h_trans.q_out = h_vintf.cb_monitor.q_out;  // taking out from intf(it got from dut)

		h_mbx.put(h_trans);   // keeping the all values in mailbox inorder to transfer to the scoreboard
		$display("inside the op monitor %p",h_trans);
	end
end
endtask

endclass
