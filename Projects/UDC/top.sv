module top;

	bit clk;
	always #5 clk++;        

	dff_intf h_intf(clk); 
	test h_test;            
//module D_FF(output reg  q_out, input d_in,input clear, preset, enable, clk);

	D_FF dut(h_intf.q_out,h_intf.din,h_intf.clear_in,h_intf.preset,h_intf.enable,h_intf.clk);  // dut module instantiation

	initial
	begin
		h_test = new(h_intf);
		h_test.run();
	end

	initial
	begin
		#200;
		$finish;
	end

endmodule


