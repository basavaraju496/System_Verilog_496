/*
	7.
	class variable_decl;
		static byte var_sta;
		int var_int;
		function void display();
			$display(var_sta, vara_int);
		endfunction
		static function void print();
			$display(var_sta, vara_int);
		endfunction
		static function void disp_var_sta();
			$display(var_sta);
		endfunction
	endclass
	a. Declare a handle for the above class.
		Without constructing object for the handle call the 3 methods mentioned above.
	b. Declare a handle for the above class.
		Create object for that handle. Call the 3 methods(display,print,disp_var_sta).*/

//=================================================//
//=================== CLASS =======================//
//=================================================//
class variable_decl;
	static byte var_sta;
	int var_int;

	function void display();
		$display(var_sta, var_int);
	endfunction

/*	static function void print();
		$display(var_sta,var_int);//-->ERROR: Illegal to access non-static property 'var_int' from a static method
	endfunction//*/

	static function void disp_var_sta();
		$display(var_sta);
	endfunction//*/
endclass
//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q7;
	variable_decl	v,v1;
	initial begin
		v = new();
		$display("=========== handle with out object ==========");
		$display("=========== method display ==========");
		v.display();
		/*$display("=========== method print ==========");
		v.print();//*/
		$display("=========== method disp_var_sta ==========");
		v.disp_var_sta();

		v1 = new();
		v1.var_int = 1001;
		v1.var_sta = 45;
		$display("=========== handle with object ==========");
		$display("=========== method display ==========");
		v1.display();
	/*	$display("=========== method print ==========");
		v1.print();//*/
		$display("=========== method disp_var_sta ==========");
		v1.disp_var_sta();
	end
endmodule
