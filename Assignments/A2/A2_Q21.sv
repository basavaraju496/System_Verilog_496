/*Write RTL code for 8 bit D flipflop.
It has two inputs, one is clock and other is [7:0]data_in.
It has one output, [7:0]data_out
a.In testbench take these queues
int q1[$]; //input array
int q2[$];//output array
Store some random data into this q1.
Drive this q1 data on to the data_in line with respect to posedge clk.
Sample the data_out and store it in q2 with respect to negedge clk.*/
module A2_Q21;
	byte unsigned queue_in[$],queue_out[$];
	wire[7:0] q_out;
	reg [7:0] d_in;
	bit clock=0,reset=0;
	always #5 clock++;
	initial begin
		#400
		$display("%p",queue_in);
		$finish;
	end

	D_FF DUT(q_out,d_in,clock,reset);
	initial begin
		repeat(40) queue_in.push_back($random);
		$display("%p",queue_in);
		fork
			stimulus;
		join
	end
	task stimulus;
		foreach(queue_in[i])begin
			@(negedge clock)
			d_in = queue_in[i];
			reset=1;
		end
	endtask
	always@(q_out) begin
		queue_out.push_back('{q_out});
	end

	//initial $monitor("%d , %d , %b",q_out,d_in,reset);
endmodule
