/*
	2. Write a class with above 4 properties:
		a. for var1 – random values should be picked from 100 to 200
		b. for var2 – random values should be 100 or 50 or 200 or 250 or 300
		c. for var3 – random values should be 30 or 40 or 300 or between 10 to 20;
		d. for var4 – random values should be 60 or 70 or between 10 to 20(10:20) or between 30 to 60.
*/

class class_random;
	rand int var1;
	randc bit [8:0] var2;
	randc bit [8:0] var3;
	randc reg [6:0] var4;

	constraint random_vars{
		var1 inside {[100:200]};
		var2 inside {100,200,250,300,50};
		var3 inside {[10:20],30,40,300};
		var4 inside {60,70,[10:20],[30:60]};
	}
endclass

module A4_Q2;
	class_random h_cr;
	initial begin
		h_cr = new;
		repeat(20) begin
			h_cr.randomize();
			$display("\t%0p",h_cr);
		end
	end
endmodule
