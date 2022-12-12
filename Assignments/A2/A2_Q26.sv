//25
//		enum{ORANCE,WHITE,GREEN}Flag;
//		Write a function that returns above enum type variable.
//		-Take one enum variable as input to the function and then modify the value of enumvarible with
//		enumvarible.next() value in that function and return that enumvariable.


module A2_Q26;
	typedef enum {ORANGE,WHITE,GREEN} enum_ref;
	enum_ref Flag,ref_flag;
	initial begin
		ref_flag = enum_updation(Flag);
		$display("%s %s",Flag,ref_flag);
		ref_flag = enum_updation(ref_flag);
		$display("%s %s",Flag,ref_flag);
	end

	function automatic enum_ref enum_updation(input enum_ref flag);
		begin
			//flag = 10;
			return flag.next();
		end
	endfunction
endmodule
