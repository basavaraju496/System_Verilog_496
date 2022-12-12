//function
module D_FF(output reg [7:0]q_out,input [7:0]d_in, input clk,reset);
	always@(posedge clk,negedge reset) begin
		if(!reset) q_out<=0;
		else q_out<=d_in;
	end
endmodule
