/*a. q1={-3,3,-6,4,2”};
Print the sum of all elements.
b. q2={4’b1010, 4’b1100, 4’b0101, 4’b0001};
Print the final XORed value of all elements.*/

module A2_Q17;
	int q1 [$];
	bit [3:0]q2[$];
	int sum_q1;
	bit [3:0]xor_q2;
	initial begin
		q1 = {-3,3,-6,4,2};
		$display("%p",q1);
		sum_q1 = q1.sum();
		$display("sum of all elements.\n%0d",sum_q1);
		q2={4'b1010, 4'b1100, 4'b0101, 4'b0001};
		foreach(q2[i]) $display("%b",q2[i]);
		xor_q2 = q2.xor();
		$display("XORed value of all elements\n%b",xor_q2);
	end
endmodule
