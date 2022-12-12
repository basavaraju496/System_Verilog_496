/*
	4. Write a program with the below two tasks.
		int addr_q[$];
		int data_q[$];
		task drive(input int addr, input int data);
			repeat(10)
				begin
					#10;
					addr_q.push_front(addr);
					data_q.push_front(data);
				end
		endtask
		task display();
			repeat(10)
				begin
					#20;
					$display(“addr queue =%p”,addr_q);
					$display(“data queue =%p”,data_q);
				end
		endatask

	a. Call these two tasks parallely. As soon as the this parallel process gets started,
		it should come out and execute the next lines of the code.
	b.	The next lines of code include: Checking whether queue is empty or not.
		If queue is empty, then hold untill the above threads gets completed.
		If queue is not empty, then display the contents of the queue.
*/

module A5_Q4;
	int addr_q[$];// = '{1};
	int data_q[$];// = '{2};

	task drive(input int addr, input int data);
		repeat(10) begin
			#10;
			$display($time);
			addr_q.push_front(addr);
			data_q.push_front(data);
		end
	endtask

	task display();
		repeat(10) begin
			#20;
			$display($time,"\taddr queue =%p",addr_q);
			$display($time,"\tdata queue =%p",data_q);
		end
	endtask

	initial begin
		fork
			display();
			drive(1,2);
		join_none
		if(addr_q.size()==0||data_q.size()==0) begin
			wait fork;
		end
		else begin
			$display("addr queue =%p",addr_q);
			$display("data queue =%p",data_q);
		end
	end

endmodule
