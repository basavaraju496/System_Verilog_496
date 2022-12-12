
module top;

	bit clk;
	always #(`CLK_PERIOD/2) clk++;        

	UDC_intf h_intf(clk); 
	coverage h_cov;

	test h_test;            
//module updown ( din, ncs, nrd, nwr, a0, a1, clk, start, reset, cout, err, dir, ec ) ;

	updown dut(h_intf.din,h_intf.ncs,h_intf.nrd,h_intf.nwr,h_intf.A0,h_intf.A1,h_intf.clk,h_intf.start_in,h_intf.reset,h_intf.cout,h_intf.err,h_intf.dir,h_intf.ec);
	initial
	begin
		h_test = new(h_intf);
		h_cov = new(h_intf);

		fork
		h_test.run();
		forever @(h_intf.cd_monitor) begin h_cov.coverGroup.sample();end
		join


	end

	initial
	begin
		#`END_SIMULATION;
		$finish;
	end

endmodule


