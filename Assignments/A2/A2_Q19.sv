/*	a. string ass_arr[string];
		ass_arr={“SUN”:5, “SOON”:10, “GOODS”:2, “GOOD”:20};
		Find out first and last elements.
	b. string q1[$];
		q1={“SUN”,”SOON”,”GOODS”,”GOOD”};
		Find out the first and last elements.
	c. Check the difference between the above two outputs. Justify your answer.*/

module A2_Q19;
	string ass_arr[string];
	string q1[$],q1_temp[$];
	string assoc_index;
	initial begin
		//ass_arr={"SUN":5, "SOON":10, "GOODS":2, "GOOD":20};-----------> ERROR
		ass_arr='{"SUN":"5", "SOON":"10", "GOODS":"2", "GOOD":"20"};
		q1={"SUN","SOON","GOODS","GOOD"};
		$display("\nAssociate array = %p\nQueue is %p",ass_arr,q1);
		ass_arr.first(assoc_index);
		$display("Associate array\n\t1st element ass_arr[\"%0s\"] = %s",assoc_index,ass_arr[assoc_index]);
		ass_arr.last(assoc_index);
		q1_temp = q1;
		$display("\tlast element ass_arr[\"%0s\"] = %s",assoc_index,ass_arr[assoc_index]);
		$display("QUEUE\n\t1st element  %s",q1_temp.pop_front);
		$display("\tlast element  %s",q1_temp.pop_back);
	end
endmodule

/*
# Associate array = '{"GOOD":"20", "GOODS":"2", "SOON":"10", "SUN":"5" }
# Queue is '{"SUN", "SOON", "GOODS", "GOOD"}
# Associate array
# 		1st element ass_arr["GOOD"] = 20
# 		last element ass_arr["SUN"] = 5
# QUEUE
# 		1st element  SUN
# 		last element  GOOD
in Associative array's the values are placed in the ascending order of index's,
in QUEUE's the order of data is fixed. first entered is in 1st position and
for next insertions the position is incremented.
Hence the 1st and last elements in queues are the 1st and last inserted data,
where as in Associate array's the 1st and last elements are least index and highest inex values.
*/
