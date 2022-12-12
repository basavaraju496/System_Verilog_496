//sum of two array's
module A1_Q5;
	reg [3:0] array_a[4],array_b[4];//arrays declaration
	reg [4:0] array_sum[4];//result storing array

	initial begin
		array_a = {5,6,8,15};//array initilization
		array_b = {1,9,7,8};
		sum_of_array;//calling task
		$display("%p + %p = %p", array_a,array_b,array_sum);
	end

	task sum_of_array;///task declaration
		for(int i=0;i<4;i++) begin
			array_sum[i] = array_a[i]+array_b[i];//adding array elements and storing result in result array.
		end
	endtask
endmodule
