/*
	14.
		class a;
			rand string student_name;
			rand real var_real;
			rand int var_int;
		endclass
		Randomize above class. Check the output.
*/

class a;
	//rand string student_name; //ERROR--> Invalid data type for rand variable 'student_name'
	//rand real var_real; //ERROR --> (vlog-13335) Non-LRM compliant 'real' type for rand variable 'var_real' may require 'svrnm' license feature during simulation.
	rand int var_int;
endclass


module A4_Q14;
	a handle;
	initial begin
		handle = new;
		repeat(10) begin
			handle.randomize();
			$display("\t %0p ",handle);
		end
	end
endmodule
