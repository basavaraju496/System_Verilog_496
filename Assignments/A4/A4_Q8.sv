/*
	8. Write a class with two variables var1, var2.
		var1 can have values in between 0 to 2000. var2 can have values in between 10000 to 2000.
		Randomize 20 times.
			a. For 10 times, when var1<1000 then var2 should be between 5000 to 10000.
			b. For next 10 times, var1 should be 2000 and var2 should be 10000.
*/

class class_random;
	randc int var1;
	randc int var2;
	constraint random_first10{
		var1 inside {[0:2000]};
		var2 inside {[2000:10000]};
		if(var1<1000) var2 inside {[5000:10000]};
	}
	constraint random_next10{
		var1 inside {2000};
		var2 inside {10000};
	}
endclass

module A4_Q8;
	class_random h_cr;
	initial begin
		h_cr = new;
		for(int i=0;i<20;i++) begin
			if(i<10) begin
				h_cr.random_first10.constraint_mode(1);
				h_cr.random_next10.constraint_mode(0);
			end
			else begin
				h_cr.random_first10.constraint_mode(0);
				h_cr.random_next10.constraint_mode(1);
			end
			h_cr.randomize();
			$display("\t%0p",h_cr);
		end
	end
endmodule
