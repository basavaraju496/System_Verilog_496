class scoreboard;

	mailbox h_mbx_tb,h_mbx_dut;
	transaction h_trans_tb,h_trans_dut;

	function new(mailbox h_mbx_tb,h_mbx_dut);
		this.h_mbx_tb = h_mbx_tb;
		this.h_mbx_dut = h_mbx_dut;
	endfunction

	task run();
		begin
			forever begin
				#1;
				h_trans_tb = new();
				h_trans_dut = new();
				h_mbx_tb.get(h_trans_tb);
				h_mbx_dut.get(h_trans_dut);
				$display("%p\n%p",h_trans_tb,h_trans_dut);
				if(h_trans_dut.data_out === h_trans_tb.data_out) begin
					$display("PASS");
				end
				else $display("FAIL---------------------");
			end
		end
	endtask
endclass
