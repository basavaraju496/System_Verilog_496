//Using TASK in system verilog
module A1_Q18_a_sv;
	byte unsigned value_a,value_b,sum;
	bit clk;
	always #1 clk++;
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


//Using function in System Verilog
module A1_Q18_b_sv;
	byte unsigned value_a,value_b,sum;
	bit clk;
	always #1 clk++;
	always@(posedge clk) begin
		value_a=$urandom_range(10,20);
		value_b=$urandom_range(50,150);
	end
	always@(posedge clk) addition(value_a,value_b);
	function addition(input byte a,b);
		sum = a+b;
	endfunction
	initial $monitor("%d + %d = %d ",value_a,value_b,sum);
	initial #50 $finish;
endmodule
