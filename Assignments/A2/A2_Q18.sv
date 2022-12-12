/*18.
		assoc={“ele1”:10, “ele2”:5, “el1”:5, “el0”:7, “e”:10};
		Store the unique values of above array into another array.*/

module A2_Q18;
	int assoc [string] = '{"ele1":10, "ele2":5, "el1":5, "el0":7, "e":10};
	string array[$];
	int assoc_result[string];
	initial begin
		$display("%p",assoc);
		array = assoc.unique_index;
		foreach(array[i]) begin
			assoc_result[array[i]] = assoc[array[i]];
		end
		$display("%p",assoc_result);
	end
endmodule
