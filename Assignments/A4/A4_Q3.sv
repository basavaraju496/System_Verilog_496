/*
	3. Write a program to get the random values for variable “data”:
		“data” can have these values:10,30,50,100.
		“data” can have any values >=50.
		“data” can have any values <100.
		Write the constraints for the all the above conditions. Randomize for 10 times. Check the output.
*/

class class_random;
	rand int data;
	constraint random_data{
		data inside {10,30,50,100};
		data>=50;
		data<100;
	}
endclass

module A4_Q3;
	class_random h_cr;
	initial begin
		h_cr = new;
		repeat(10) begin
			h_cr.randomize();
			$display("\t%0p",h_cr);
		end
	end
endmodule
