/*8.
a. Initialize the dynamic array of size 20 elements with random values between 20 and 60.
Find out the indexes of the elements whose value is <50. Display those indexes.
b. Change the above dynamic array size to 30 elements and retain the old values.*/

module A2_Q8;
	reg [31:0] array [];//Dynamic array of location size 32 bit.
	int output_array[$];//Associate array of int type.
	initial begin
		array = new[20]; //initilizing for 20 locations
		foreach(array[i])	begin
			array[i] = $urandom_range(20,60);
		end
		check;
		$display("Original array of size %0d\n%p\nFILTERED ARRAY (filter->index with value less than 50)\n%p",array.size(),array,output_array);

		// increasing 10 more locations without disturbing previous location values.
		array = new[30](array);
		for(int i=20;i<30;i++)	begin
			array[i] = $urandom_range(20,60);
		end
		check;
		$display("Original array of size %0d\n%p\nFILTERED ARRAY (filter->index with value less than 50)\n%p",array.size(),array,output_array);
	end



	task check;
	begin
		output_array = array.find_index(x) with (x<50);
	end
	endtask
endmodule
