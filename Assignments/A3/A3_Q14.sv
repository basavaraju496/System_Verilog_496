/*
	14.
	Write a program containing base and derived classes and then mask the base class methods
  	 and only have the visibility of child methods only.
 */
//=================================================//
//=================== CLASS =======================//
//=================================================//
class parent;

	//================= METHODS ======================//
	//================= Display ======================//
	virtual function void display();
		$display("\tParent class");
	endfunction

endclass:parent

class child extends parent;

	//================= METHODS ======================//
	//================= Display ======================//
	function void display();
		$display("\tChild class");
	endfunction

endclass:child



//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q14;
	parent hp=new();
	child hc=new();
	initial begin
		$display("Parent methods are not masked");
		hp.display();
		hc.display();
		$display("Masking the parent class");
		hp=hc;
		hp.display();
		hc.display();
	end
endmodule
