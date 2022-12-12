/*
	5. Write a class with 3 properties:
		int waddr;
		int wdata;
		int rdata;
		When randomized, these three values should not be same.(waddr!=wdata!=rdata).
*/

class class_random;
	randc int waddr;
	randc int wdata;
	randc int rdata;
	constraint random_data{
		waddr!=wdata;
		wdata!=rdata;
		rdata!=waddr;
	}
endclass

module A4_Q5;
	class_random h_cr;
	initial begin
		h_cr = new;
		repeat(15) begin
			h_cr.randomize();
			$display("\t%0p",h_cr);
		end
	end
endmodule
