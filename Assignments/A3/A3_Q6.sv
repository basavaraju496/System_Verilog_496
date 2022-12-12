/*
	6.
	class variable_decl;
		static byte var_sta;
		int var_int;
		endclass
	a. Declare a handle for variable_decl and initialize the properties with some values
	 without constructing the object for the declared handle.
	b. Display the content of the variables.*/
//=================================================//
//=================== CLASS =======================//
//=================================================//
class variable_decl;
	static byte var_sta;
	int var_int;
endclass
//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q6;
	variable_decl v,v1;
	initial begin
		v = new();
		v1 = new();
		v.var_int = 500;
		v.var_sta = 33;
		v1.var_int = 1001;
		v1.var_sta = 45;
		$display("%p",v);
		$display("%p",v1);
	end
endmodule
