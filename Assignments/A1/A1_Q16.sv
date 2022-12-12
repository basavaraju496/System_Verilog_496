module A1_Q16;
	bit clk;
	always #1 clk++;
	reg[1:0] state, state_next, count_next;
	always_ff@(posedge clk)
		  state<=state_next;
	always@(posedge clk)
		  state<=count_next;
	always@(negedge clk) begin
		state_next=$random;
		count_next=$random;
	end
	initial begin
		$monitor("state=%d",state);
		#20 $finish;
	end
endmodule
//state_next is getting assigned in the 1st instance,
//later continuously the count_next is getting assigned.
// in both the cases always and always_ff
//
//IF only one always_ff and one always is used then error is thrown
//Error (suppressible): A1_Q16.sv(8): (vlog-7061) Variable 'state' driven in an always_ff block, may not be driven by any other process. See A1_Q16.sv(6).
