
module top;

	bit clk;
	always #(`CLK_PERIOD/2) clk++;        

	UDC_intf h_intf(clk); 
	test h_test;            
//module D_FF(output reg  q_out, input d_in,input clear, preset, enable, clk);
//module updown ( din, ncs, nrd, nwr, a0, a1, clk, start, reset, cout, err, dir, ec ) ;

	updown dut(h_intf.din,h_intf.ncs,h_intf.nrd,h_intf.nwr,h_intf.A0,h_intf.A1,h_intf.clk,h_intf.start_in,h_intf.reset,h_intf.cout,h_intf.err,h_intf.dir,h_intf.ec);
	initial
	begin
		h_test = new(h_intf);
		h_test.run();
	end

	initial
	begin
		#1000;
		$finish;
	end

endmodule


