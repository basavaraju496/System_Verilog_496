module A1_Q17_a;
	byte out,c;
	bit s1,s2;
	bit clk;
	always #1 clk++;
	always@(*) begin
		if(s1) out=c;
		else if(s2) out=1;
	end
	always@(posedge clk) begin
		c=$random;
		s1=$random;
		s2=$random;
	end
	initial begin
		$monitor("out= %d, c=%d,s1=%d, s2=%d",out,c,s1,s2);
		#50 $finish;
	end
endmodule

module A1_Q17_b;
	byte out,c;
	bit s1,s2;
	bit clk;
	always #1 clk++;
	always_comb begin
		if(s1) out=c;
		else if(s2) out=1;
	end
	always@(posedge clk) begin
		c=$random;
		s1=$random;
		s2=$random;
	end
	initial begin
		$monitor("out= %d, c=%d,s1=%d, s2=%d",out,c,s1,s2);
		#50 $finish;
	end
endmodule

//always_comb represents always@(*)
