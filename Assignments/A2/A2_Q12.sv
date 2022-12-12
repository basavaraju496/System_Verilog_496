//Declare an array with positive and negative indexes. Find out what are the first and last elements.

module A2_Q12;
/*	typedef bit signed [3:0]  Nibble;
	int array [Nibble];

	initial begin
		for(int i=0; i<10; i++) begin
			array[$urandom_range(-10,10)] = $urandom_range(10,20);
		end
		$display("Array Available\n\t%p",array);
	//	$display("The first element index is %0d",array.first(array_index));
//		$display("The last element index is %0d",array.last(array_index));
	end//*/

	int array [byte];
	byte array_index;
	initial begin
		array[10] = $urandom_range(10,50);
		array[9] = $urandom_range(10,50);
		array[1] = $urandom_range(10,50);
		array[5] = $urandom_range(10,50);
		array[2] = $urandom_range(10,50);
		array[8] = $urandom_range(10,50);
		array[-10] = $urandom_range(10,50);
		array[-24] = $urandom_range(10,50);
		array[-2] = $urandom_range(10,50);
		array[24] = $urandom_range(10,50);
		array[-100] = $urandom_range(10,50);
		array[50] = $urandom_range(10,50);
		array[-49] = $urandom_range(10,50);
		array[-81] = $urandom_range(10,50);//*/

		$display("Array Available\n\t%p",array);
		array.first(array_index);
		$display("The first element array[%0d] = %0d",array_index,array[array_index]);
		array.last(array_index);
		$display("The last element array[%0d] = %0d",array_index,array[array_index]);
	end//*/
endmodule
