/*
	20. Write a class. Inside that declare a variable as a bit[max_width-1:0]var1;
	Declare max_width as parameter and load some value.
	Take two handles for the class as pkt1,pkt2.
	Change the pkt1’s “max_width” to 16 and pkt2’s “max_width” to 60.
	Display the content of pkt1 and pkt2. (use %b as format specifier)
	Check the bitwidth of the var1.( Make sure pkt1’s width is 16 and pkt’2 width is 60)*/
//=================================================//
//=================== CLASS =======================//
//=================================================//
class class1#(int MAX_WIDTH=8);
	 bit [MAX_WIDTH-1:0] data;
	 function void display();
			$display("%b",data);
	 endfunction
endclass

//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q20;
	class1 #(16)pkt1;// = new();
	class1 #(60)pkt2;// = new();
	initial begin
		pkt1 = new();
		pkt1.data = $random();
		pkt2 = new();
		pkt2.data = $random();
		pkt1.display();
		pkt2.display();
	end

endmodule
