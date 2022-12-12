//22
//		Write a function that add two arrays and returns the result with return type array.
module A2_Q22;
	reg [3:0] array_a[4],array_b[4];//array declaration
	reg [4][4:0]array_sum;//result storing array

	initial begin
		array_a = {5,6,8,15};//array initilization
		array_b = {1,6,2,8};
		array_sum = sum_of_array(array_a,array_b);//calling function
		$display("%p + %p = %p", array_a,array_b,array_sum);
	end

	function [4][4:0]sum_of_array(input [3:0] a[4],b[4]);//function declaration
	begin
		reg [4][4:0]array;
		for(int i=0;i<4;i++) begin
			array[i] = a[i]+b[i];//left shifting the element by one bit.
		end
		return array;
	end
	endfunction
endmodule
