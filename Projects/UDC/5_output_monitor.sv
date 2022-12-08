class output_monitor;

	virtual UDC_intf h_vintf; 
	mailbox h_mbx;             
	transaction h_trans;      
	function new(virtual UDC_intf h_vintf,mailbox h_mbx); 
		this.h_vintf = h_vintf;
		this.h_mbx = h_mbx;
	endfunction
	
task run();
		begin
			forever@(h_vintf.cd_monitor) begin
				h_trans = new();
				h_trans.din = h_vintf.cd_monitor.din;
				h_trans.A0 = h_vintf.cd_monitor.A0;
				h_trans.A1 = h_vintf.cd_monitor.A1;
				h_trans.nwr = h_vintf.cd_monitor.nwr;
				h_trans.nrd = h_vintf.cd_monitor.nrd;
				h_trans.cout = h_vintf.cd_monitor.cout;
				h_trans.dir = h_vintf.cd_monitor.dir;
				h_trans.err = h_vintf.cd_monitor.err;
				h_trans.ec = h_vintf.cd_monitor.ec;
				h_trans.start_in = h_vintf.cd_monitor.start_in;
				h_trans.reset= h_vintf.cd_monitor.reset;
				h_trans.ncs = h_vintf.cd_monitor.ncs;
		
				h_mbx.put(h_trans);   // keeping the all values in mailbox inorder to transfer to the scoreboard
		
			//	$display("inside the op monitor %p",h_trans);
			end

		end
	endtask
endclass
