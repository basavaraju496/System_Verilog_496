//function
module A1_Q6;
	reg [3:0] array_a[4];//array declaration
	reg [4][4:0]array_sum;//result storing array

	initial begin
		array_a = {5,6,8,15};//array initilization
		array_sum = sum_of_array(array_a);//calling function
		$display("%p  = %p", array_a,array_sum);
	end

	function [4][4:0]sum_of_array(input [3:0]a[4]);//function declaration
	begin
		reg [4][4:0]array;
		for(int i=0;i<4;i++) begin
			array[i] = a[i]<<1;//left shifting the element by one bit.
		end
		return array;
	end
	endfunction
endmodule
