module top;

	bit clock;
	always #5 clock++;
	initial begin
		#1000 $finish;
	end
	test h_test;
	adder_intf h_intf(clock);
	coverageClass h_cov;

	adder DUT(h_intf.sum,h_intf.in1,h_intf.in2,clock,h_intf.reset);

	initial begin
		h_test = new(h_intf);
		h_cov = new(h_intf);
		h_test.run();
	end

	/*covergroup coverGroup;
		in_1: coverpoint h_intf.in1{
				bins binbasava[] = {[0:100]};
				bins binArjun = {[100:200]};
			}
		in_2: coverpoint h_intf.in2;
		rst: coverpoint h_intf.reset;
	endgroup//*/

	initial begin
		forever @(h_intf.cb_driver) begin
			h_cov.coverGroup.sample();
		end
	end//*/
endmodule
