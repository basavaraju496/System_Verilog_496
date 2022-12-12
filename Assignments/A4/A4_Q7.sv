/*
	7. Write a class with 4 variables.
	a. var1 can have any values, but when var2 value is 20 then var1 value should be between 0 to 10.
	b. var2 can have values{20,40,10}
	c. var3 can have values{90,500}
	d. var4 – when var3 is 90, then var4 should be 90 otherwise var4 should be between 10 to 50.
*/

class class_random;
	randc int var1;
	randc int var2;
	randc int var3;
	randc int var4;
	constraint random_var2{
		var2 inside {20,40,10};
	}
	constraint random_var3{
		var3 inside {90,500};
	}
	constraint random_var1{
		if(var2==20) var1 inside {[0:10]};
	}
	constraint random_var4{
		if(var3==90) var4==90;
		else var4 inside {[10:50]};
	}
endclass

module A4_Q7;
	class_random h_cr;
	initial begin
		h_cr = new;
		repeat(45) begin
			h_cr.randomize();
			$display("\t%0p",h_cr);
		end
	end
endmodule
