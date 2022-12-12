module adder(output reg [8:0] sum, input [7:0] in1,in2,input clock,reset);

	always@(posedge clock) begin
		if(reset) sum<=0;
		else 	sum<=in1+in2;
	end
endmodule
