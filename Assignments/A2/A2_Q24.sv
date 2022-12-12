//24
//		Write a function that add two dynamic arrays and returns the result with return type dynamic array.


module A2_Q24;

	typedef int Dynamic_Array [];
	Dynamic_Array array_a, array_b;
	Dynamic_Array sum;
	initial begin
		array_a = '{1,5,2,6,3,8,4,15};//array initilization
		array_b = '{1,1,2,6,3,2,4,8};
		sum = sum_of_array(array_a,array_b);
		$display("%p + %p = %p",array_a,array_b,sum);
	end

	function automatic Dynamic_Array sum_of_array(input Dynamic_Array a,b);
		begin
			Dynamic_Array sum_a_b;
			int count_a = a.size(),count_b = b.size();
			for(int i=0;i<count_a && i<count_b;i++) begin
				sum_a_b = new[i+1](sum_a_b);
				sum_a_b[i]=a[i]+b[i];
			end
			return sum_a_b;
		end
	endfunction
endmodule
