/*
	4. Write a class with 2 properties var1, var2;
		var1 values should be {2, 4, 10, 12}.
		When you randomize var1, the output value 12 should come more times when compared to 4.
		var2 values should be 2 to 30 or 50 to 80.
		When you randomize var2, the output values 50 to 80 should come
		more number of times when compared to 2 to 30 values.
*/

class class_random;
	rand int var1;
	rand int var2;
	constraint random_vars{
		var1 dist {2:=2,4:=5,10:=3,12:=15};
		var2 dist {[2:30]:=5,[50:80]:=20};
	}
endclass

module A4_Q4;
	class_random h_cr;
	initial begin
		h_cr = new;
		repeat(15) begin
			h_cr.randomize();
			$display("\t%0p",h_cr);
		end
	end
endmodule
