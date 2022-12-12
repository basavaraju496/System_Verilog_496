/*a.q1={10,40,5,100,20};
Delete the elements whose value is >20.(Get the indexes and deletes those indexes)
b. Declare a queue and initialize with random values between 0 to 50.
Delete the elements whose value is >20.(Get the indexes and deletes those indexes)*/

module A2_Q15;
	int q1 [], q2 [], q3[$];
	int queue1 [$];
	initial begin
		q1 = new[5];
		q1 = {0,40,5,100,20};
		$display("Original Dynamic array %p",q1);
		q1 = q1.find(x) with (x<=20);
		//q1 = new[q2.size()](q2);
		$display("Updated Dynamic array %p",q1);
		for(int i=0;i<15;i++) begin
			queue1.push_back($urandom_range(10,40));
		end
		$display("Original QUEUE %p",queue1);
		q3 = queue1.find(x) with (x<=20);
		$display("Updated QUEUE %p",q3);
	end
endmodule

