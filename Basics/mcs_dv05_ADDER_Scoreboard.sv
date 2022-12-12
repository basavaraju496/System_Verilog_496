class scoreboard;

	mailbox h_mbx_tb,h_mbx_dut;
	transaction h_trx_tb,h_trx_dut;

	function new(mailbox h_mbx_dut,mailbox h_mbx_tb);
		this.h_mbx_tb = h_mbx_tb;
		this.h_mbx_dut = h_mbx_dut;
	endfunction

	task run();
		begin
			forever begin
				#1;
				h_trx_tb = new();
				h_trx_dut = new();
				h_mbx_tb.get(h_trx_tb);
				h_mbx_dut.get(h_trx_dut);
				if(h_trx_dut.sum === h_trx_tb.sum) begin
					$display("%p \n%p",h_trx_tb,h_trx_dut);
					$display("=============PASS==========");
				end
				else begin
					$display("%p \n%p",h_trx_tb,h_trx_dut);
					$display("=============FAIL==========");
				end
			end
		end
	endtask
endclass
