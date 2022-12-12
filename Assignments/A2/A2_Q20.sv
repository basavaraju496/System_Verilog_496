/*Write RTL code for 8 bit D flipflop.
It has two inputs, one is clock and other is [7:0]data_in.
It has one output, [7:0]data_out
a.In testbench take these arrays
int arr1[int]; //input array
int arr2[int];//output array
Store some random data into this array1.
Drive this array1 data on to the data_in line with respect to posedge clk.Sample the data_out and store it in array2 with respect to negedge clk.*/

//function
module A2_Q20;
	byte unsigned Assoc_Array_in[int],Assoc_Array_out[int];
	wire[7:0] q_out;
	reg [7:0] d_in;
	bit clock=0,reset=0;
	always #5 clock++;
	initial begin
		#400
		$display("%p",Assoc_Array_in);
		$finish;
	end

	D_FF DUT(q_out,d_in,clock,reset);
	initial begin
		for(int i=0; i<40;i++) begin
	  		Assoc_Array_in[i]=$random;
		end
		$display("%p",Assoc_Array_in);
		fork
			stimulus;
		join
	end
	task stimulus;
		foreach(Assoc_Array_in[i])begin
			@(posedge clock)
			d_in = Assoc_Array_in[i];
			reset=1;
		end
	endtask
	int i=0;
	always@(negedge clock) begin
		Assoc_Array_out[i]='{q_out};
		i++;
	end

	//initial $monitor("%d , %d , %b",q_out,d_in,reset);
endmodule
