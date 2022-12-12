//	14.
//		a. int array1[int]={1:10,0:30};
//			Add index 2 with value 5 and then print the array.
//		b. int q1[$]={1,10,20};
//			Insert an element 5 in between 1,10 in the queue.

module A2_Q14;
	int array1[int] = {1:10,0:30};
	int q1[$] = {1,10,20};
	initial begin
		$display("Associate array is = %p\nQueue is %p",array1,q1);
		array1[2] = 5;
		q1.insert(1,5);
		$display("UPDATED\nAssociate array is = %p\nQueue is %p",array1,q1);
	end
endmodule
