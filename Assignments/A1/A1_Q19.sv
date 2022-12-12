//Using TASK in verilog
module A1_Q19;
	logic a,b;
	task check;
	begin
		if(a==?b) $display("a=%b and b=%b are EQUAL",a,b);
		if(a!=?b) $display("a=%b and b=%b are NOT EQUAL",a,b);
	end
	endtask
	initial begin
		a=0;b=0;check;
		#1 a=0;b=1;check;
		#1 a=1;b=0;check;
		#1 a=1;b=1;check;
		#1 a=1'bx;b='bx;check;
		#1 a='bx;b='bz;check;
		#1 a='bz;b='bx;check;
		#1 a='bz;b='bz;check;
	end
endmodule
