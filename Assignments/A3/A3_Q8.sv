/*
	8.
		Return the class handle from the function
		Note: Take an handle as an input to the function,
		then modify the values of class properties and then return it*/
//=================================================//
//=================== CLASS =======================//
//=================================================//
class parent;
	 int signed data;
	 byte signed address;
endclass

//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q8;
	parent P1=new();
	parent P2=new();
	initial begin
		$display("%p",P1);
		$display("%p",P2);
		P1.data = 100;
		P1.address = 10;
		$display("%p",P1);
		$display("%p",P2);
		P2 = modify(P1,1001,20);
		$display("%p",P1);
		$display("%p",P2);
	end

	function automatic parent modify(parent p,int i,byte j);
		begin
			parent q = new();
			q.data = p.data+i;
			q.address = p.address+j;
			return q;
		end
	endfunction
endmodule
