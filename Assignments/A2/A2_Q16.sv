/*q1={10,5,20};
a.Put 3 other values at front.
b.Put 4 other values at back.
c.Arrange all items in ascending order.
d. Delete last 4 elements.
e. Keep any 10 new elements at front one after other*/

module A2_Q16;
	int q1 [$];
	initial begin
		q1 = {'d10,5,20};
		$display("%p\nPut 3 other values at front",q1);
		repeat(3) begin
			q1.push_front($urandom_range(10,50));
		end
		$display("%p\nPut 4 other values at back.",q1);
		repeat(4) begin
			q1.push_back($urandom_range(10,50));
		end
		$display("%p\nArrange all items in ascending order",q1);
		q1.sort();
		$display("%p\nDelete last 4 elements",q1);
		repeat(4) begin
			q1.pop_back();
		end
		$display("%p\nKeep any 10 new elements at front one after othe",q1);
		for(int i=0;i<10;i++) begin
			q1.insert(i,$urandom_range(10,50));
			$display("%p",q1);
		end
	end
endmodule
