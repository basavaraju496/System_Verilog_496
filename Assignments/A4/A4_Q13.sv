/*
	13. Write a base class with 4 properties. Write constraints.
		Derive a class from base class and add one property to it. Write constraints.
		Create an object for derived class and randomize for 2 times.
*/

class base;
	rand int addr;
	rand int data1;
	rand int data2;
	rand int data3;
	constraint cst1{
		addr inside {[10:30]};
		data1 inside {[30:40]};
		data2 inside {[40:50]};
		data3 inside {[50:60]};
	}
endclass

class derived extends base;
	rand int d_data;
	constraint cst1{
		d_data inside {[100:200]};
		addr inside {[110:130]};
		data1 inside {[130:140]};
		data2 inside {[140:150]};
		data3 inside {[150:160]};//*/
	}
endclass


module A4_Q13;
	derived handle_d = new();
	base handle_b = new();
	initial begin
		repeat(2) begin
			handle_d.randomize();
			$display("%p",handle_d);
		end
	end
endmodule
