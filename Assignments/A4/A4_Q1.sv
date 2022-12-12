/*
	1. Write a class with 4 variables:
		int var1;
		bit[4:0]var2;
		bit[4:0]var3;
		reg[6:0]var4;
	Generate 20 random values for above variables.
		a. for var1 – get any random values for 20 times.
		b. for var2,var3,var4 – get all different values(i.e., var2!=var3!=var4)
*/

class class_random;
	rand int var1;
	randc bit [4:0] var2;
	randc bit [4:0] var3;
	randc reg [6:0] var4;

	constraint random_vars{
		//var2!=var3;
		//var3!=var4;
		//var4!=var2;
		!(var3 inside {var2});
		!(var4 inside {var3,var2});
	}
endclass

module A4_Q1;
	class_random h_cr;
	initial begin
		h_cr = new;
		repeat(20) begin
			h_cr.randomize();
			$display("\t%0p",h_cr);
		end
	end
endmodule
