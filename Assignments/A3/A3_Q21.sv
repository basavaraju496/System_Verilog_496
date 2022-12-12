/*
	21. Write a class, having two properties of any data_type. Take two handles.(Ex. pkt1, pkt2)
	Change pkt1 properites data_type with respect to pkt2 properties data_type.
	(pkt1,pkt2 properties should have different data_types)
	Note:override the datatype from handle declaration.*/
//=================================================//
//=================== CLASS =======================//
//=================================================//
class class1#(type dt=int);
	 dt data;
	 function void display();
			$display("\tData = %b",data);
	 endfunction
endclass

//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q21;
	class1 #(int)pkt1;// = new();
	class1 #(byte)pkt2;// = new();
	initial begin
		pkt1 = new();
		pkt1.data = $random();
		pkt2 = new();
		pkt2.data = $random();
		$display("============== Before Assignment ==================");
		pkt1.display();
		pkt2.display();
		$display("%p %p",pkt1,pkt2);
		#1 pkt1 = pkt2;
		$display("=============== After Assignment ==================");
		pkt1.display();
		pkt2.display();

	end
endmodule

/* ERROR
 ============== Before Assignment ==================
# 	Data = 00010010000101010011010100100100
# 	Data = 10000001
# '{data:303379748} '{data:-127}
# ** Fatal: Illegal assignment to class work.A3_Q21_sv_unit::class1 #(int) from class work.A3_Q21_sv_unit::class1 #(byte)
#
#    Time: 1 ns  Iteration: 0  Process: /A3_Q21/#INITIAL#22 File: A3_Q21.sv
# Fatal error in Module A3_Q21 at A3_Q21.sv line 31
#
# HDL call sequence:
# Stopped at A3_Q21.sv 31 Module A3_Q21
*/
