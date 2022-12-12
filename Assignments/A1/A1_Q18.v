//Using TASK in verilog
module A1_Q18_a_v;
	reg [7:0] value_a,value_b,sum;
	reg clk=0;
	always #1 clk=~clk;
	always@(posedge clk) begin
		value_a=$urandom_range(10,20);
		value_b=$urandom_range(50,150);
	end
	always@(posedge clk) addition;
	task addition;
		sum = value_a+value_b;
	endtask
	initial $monitor("%d + %d = %d ",value_a,value_b,sum);
	initial #50 $finish;
endmodule


//Using function in Verilog
module A1_Q18_b_v;
	reg[7:0] value_a,value_b,sum;
	reg clk=0;
	always #1 clk=~clk;
	always@(posedge clk) begin
		value_a=$urandom_range(10,20);
		value_b=$urandom_range(50,80);
	end
	always@(value_a,value_b) begin sum = addition( value_a,value_b);end
	function [7:0] addition(input [7:0] a,b);
	begin
		addition = a+b;
	end
	endfunction
	initial $monitor("%d + %d = %d ",value_a,value_b,sum);
	initial #50 $finish;
endmodule
