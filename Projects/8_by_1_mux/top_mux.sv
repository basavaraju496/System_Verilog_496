//===============================INTERFACE MODULE ==========================//

module top;

	bit clk;
	always #5 clk++;         // generating clk 
	
	adder_intf h_intf(clk);  // creating handle and sending clk ip to the intf
	test h_test;              // handle for test

//------------------------------DUT instansiation ----------------------------//

	adder dut(.in1(h_intf.in1),.in2(h_intf.in2),.rst(h_intf.rst),.clk(h_intf.clk),.out(h_intf.out)); 

//-----------------------------procedural block-------------------------------//
	initial
	begin
		h_test = new(h_intf); 
		h_test.run(); 
	end
//---------------------finishing simulation--------------------------------//

	initial
	begin
		#200;
		$finish;
	end

endmodule