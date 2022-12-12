/*
	9. Write a class with 10 properties,
		a. Display the contents
		b. Randomize the values. You should get some defined random values.
		c. After 10 time units, randomize with condition var1,var2, var3, var4, var5 should be between 10 to 20.
			var6, var7, var8, var9, var10 should be between 100 to 90.
*/

class class_random;
	randc int var1;
	randc int var2;
	randc int var3;
	randc int var4;
	randc int var5;
	randc int var6;
	randc int var7;
	randc int var8;
	randc int var9;
	randc int var10;
	constraint random_next10{
		var1 inside {[10:20]};
		var2 inside {[10:20]};
		var3 inside {[10:20]};
		var4 inside {[10:20]};
		var5 inside {[10:20]};
		var6 inside {[90:100]};
		var7 inside {[90:100]};
		var8 inside {[90:100]};
		var9 inside {[90:100]};
		var10 inside {[90:100]};
	}
endclass

module A4_Q9;
	class_random h_cr;
	initial begin
		h_cr = new;
		for(int i=0;i<20;i++) begin
			#1;
			if(i<10) begin
				h_cr.random_next10.constraint_mode(0);
			end
			else begin
				h_cr.random_next10.constraint_mode(1);
			end
			h_cr.randomize();
			$display($time,"\t%0p",h_cr);
		end
	end
endmodule
