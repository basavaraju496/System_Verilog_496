/*reg[31:0]array[7:0];
In the declaration itself, initialize the array with all 8 elements. If an error occurs, how to avoid it.
Explore the reason*/

module A2_Q6;
	reg [31:0] array [7:0] = {25,43,2,4,111,4567,3,22345};
	initial begin
		$display("%p",array);
	end
endmodule
