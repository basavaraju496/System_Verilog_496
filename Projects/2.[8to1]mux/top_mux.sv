//===============================INTERFACE MODULE ==========================//

module top;

	bit clk;
	always #5 clk++;         // generating clk 
	
	mux_intf h_intf(clk);  // creating handle and sending clk ip to the intf
	test h_test;              // handle for test

//------------------------------DUT instansiation ----------------------------//

	mux8to1 dut(h_intf.data_in,h_intf.selection_in,h_intf.mux_out,h_intf.clk); 

//-----------------------------procedural block-------------------------------//
	initial
	begin
		h_test = new(h_intf); 
		h_test.run(); 
		//$display(" h_intf=%p ",h_intf);
	end
//---------------------finishing simulation--------------------------------//

	initial
	begin
		#200;
		$finish;
	end

endmodule
