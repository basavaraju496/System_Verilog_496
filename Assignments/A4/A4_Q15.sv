/*
	15.
		class a;
			rand int addr;
			rand int data;
		endclass
	a. Do not write constraints and inline constraints.
		But while randomizing every time “addr” should get 10 as value.(use other randomize methods)
	b. If addr is 10 then data should be 50.
*/

class a;
	rand int addr;
	rand int data;
	function void pre_randomize();
		begin
			addr=10;
			data=50;
		end
	endfunction
	function void post_randomize();
		begin
			addr=10;
			data=50;
		end
	endfunction
endclass


module A4_Q15;
	a handle;
	initial begin
		handle = new;
		repeat(10) begin
			handle.randomize();
			$display("\t %0p ",handle);
		end
	end
endmodule
