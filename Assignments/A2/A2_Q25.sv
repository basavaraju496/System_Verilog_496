//25
//		Write a function that add two queues and returns the result with return type queue.


module A2_Q25;

	typedef int Assoc_array_int [$];
	Assoc_array_int array_a, array_b;
	Assoc_array_int sum;
	initial begin
		array_a = '{1,5,2,6,3,8,4,15};//array initilization
		array_b = '{1,1,2,6,3,2,4,8};
		sum = sum_of_array(array_a,array_b);
		$display("%p + %p + %p",array_a,array_b,sum);
	end

	function automatic Assoc_array_int sum_of_array(input Assoc_array_int a,b);
		begin
			int sum_a_b[$];
			int count_a = a.size(),count_b = b.size();
			for(int i=0;i<count_a && i<count_b;i++) begin
				sum_a_b[i]=a[i]+b[i];
			end
			return sum_a_b;
		end
	endfunction
endmodule
