class tbmonitor;

	transaction h_trans;
	mailbox h_mbx;
	virtual memoryInterface h_memintf;
	int memory [0:255];

	function new(virtual memoryInterface h_memintf,mailbox h_mbx);
		this.h_memintf = h_memintf;
		this.h_mbx = h_mbx;
	endfunction

	task run();
		begin
			forever begin
				@(h_memintf.cb_monitor)
				h_trans = new();
				//Checker
				h_trans.reset = h_memintf.cb_monitor.reset;
				h_trans.data_in = h_memintf.cb_monitor.data_in;
				h_trans.address = h_memintf.cb_monitor.addr;
				h_trans.wr_enable = h_memintf.cb_monitor.wr_en;

				if(h_trans.reset == 1) begin
					h_trans.data_out=1'bz;
					foreach(memory[i]) begin
						memory[i] = 0;
					end
				end
				else begin
					if(h_trans.wr_enable == 0) begin
						memory[h_trans.address] = h_trans.data_in;
						h_trans.data_out = 1'bz;
					end
					else begin
						h_trans.data_out = memory[h_trans.address];
					end
				end


				//mailbox data insertion
				h_mbx.put(h_trans);
			end
		end
	endtask
endclass
