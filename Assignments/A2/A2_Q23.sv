//23
//		Write a function that add two associative arrays and returns the result with return type associative array.


module A2_Q23;
	typedef int Assoc_array_int [*];
	Assoc_array_int array_a, array_b;
	Assoc_array_int sum[*];
	initial begin
		array_a = '{1:5,100:6,50:8,4:15};//array initilization
		array_b = '{1:1,2:6,3:2,6:8};
		sum = sum_of_array(array_a,array_b);
		$display("%p + %p = %p",array_a,array_b,sum);
	end

	function automatic Assoc_array_int sum_of_array(input Assoc_array_int a,b);
		begin
			int sum_a_b[*];
			int a_index, b_index;
			a.first(a_index);
			b.first(b_index);
			for(int i=0;i<a.size() && i<b.size();i++)begin
				sum_a_b[a_index] = a[a_index]+b[b_index];
				a.next(a_index);
				b.next(b_index);
			end
			return sum_a_b;
		end
	endfunction
endmodule
