/*
	3. Write a program containing the following two threads.
		T1: forever
				begin
					#1;
					addr=$random_range(10,100);
				end
		T2: forever
				begin
					#2;
					$display(addr);
				end
		a. After 20 time units T1, T2 should be stopped.
		b. Display the addr values. Then finish the simulation
*/

module A5_Q3;
	int addr;
	initial begin
		fork
			begin
				forever begin
					#1;
					addr=$urandom_range(10,100);
					//$display($time,"\taddr = %0d",addr);
				end
			end
			begin
				forever begin
					#2;
					$display($time,"\taddr = %0d",addr);
				end
			end
		join_none
		#20;
		$finish;
	end
endmodule
