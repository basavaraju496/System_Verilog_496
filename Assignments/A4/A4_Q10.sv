/*
	10. Write a program with two variables var1, var2.
		At runtime for 2 times restrict var1 to get 1 to 100 and var2 to get 30 to 400.
		Next 2 time, get any random values without the mentioned conditions.
		For next 2 times, get previous values (no randomization should happen).
*/

class class_random;
	randc int var1;
	randc int var2;
	constraint random_next10{
		var1 inside {[1:100]};
		var2 inside {[30:400]};
	}
endclass

module A4_Q10;
	class_random h_cr;
	initial begin
		h_cr = new;
		for(int i=0;i<6;i++) begin
			if(i<2) begin
				h_cr.random_next10.constraint_mode(1);
			end
			else if (i<4)begin
				h_cr.random_next10.constraint_mode(0);
			end
			else begin
				h_cr.rand_mode(0);
			end
			h_cr.randomize();
			$display("\t%d %0p",i,h_cr);
		end
	end
endmodule
