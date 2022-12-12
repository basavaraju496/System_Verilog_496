/*array={“RAMA”:10, “RAJU”:20, “KING”:30, “KIND”:5};
Find out the first, next, last elements and how it got stored.*/
module A2_Q13;
	int array [string];
	string array_index;
	initial begin
		array["RAMA"] = 10;
		array["RAJU"] = 20;
		array["KING"] = 30;
		array["KIND"] = 5;
		$display("Array Available\n\t%p",array);
		array.first(array_index);
		$display("The first element array[\"%0s\"] = %0d",array_index,array[array_index]);
		array.next(array_index);
		$display("The next element array[\"%0s\"] = %0d",array_index,array[array_index]);
		array.last(array_index);
		$display("The last element array[\"%0s\"] = %0d",array_index,array[array_index]);
		array.prev(array_index);
		$display("The prev element array[\"%0s\"] = %0d",array_index,array[array_index]);
	end
endmodule
