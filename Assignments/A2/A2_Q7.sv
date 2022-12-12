/*reg[31:0]array[7:0];
Initialize the above array with 5,10, 2, 8, 12, 50, 80. Store the >10 value elemets into another array.
Do it in the simplest way.*/

module A2_Q7;
	reg [31:0] array [7:0];
	reg [31:0] output_array[$];
	initial begin
		array = {5,10, 2, 8, 12, 50, 80,25};
		output_array = array.find(x) with (x>10);
		$display("Original array\n%p\nFILTERED ARRAY (filter->values with greater than 10)\n%p",array,output_array);
	end
endmodule
