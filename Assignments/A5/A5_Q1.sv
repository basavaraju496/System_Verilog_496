/*
	1. Create 3 parllel threads:
		Thread 1: takes 10 posedges to complete.
		Thread 2: takes 5 posedges to complete
		Thread 3: takes 30 posedges to complete
	Write a code to achieve above threads.
*/

module A5_Q1;
	bit clock=1;
	always #5 clock++;
	initial begin
		fork
			begin
				$display($time,"\t Thread 1 started");
				repeat(10) @(posedge clock);
				$display($time,"\t Thread 1 Finished");
			end
			begin
				$display($time,"\t Thread 2 started");
				repeat(5) @(posedge clock);
				$display($time,"\t Thread 2 Finished");
			end
			begin
				$display($time,"\t Thread 3 started");
				repeat(30) @(posedge clock);
				$display($time,"\t Thread 4 Finished");
			end
		join
		$finish;
	end


endmodule
