/*
	12.
		class base;
			rand int addr;
			constraint cst1(..........)
		endclass
		Write a constriant to addr with some conditions.
		Class derived extends base;
			constraint cst1(..........)
		endclass
		a. Write a constraint in derived class with the same name used in base class.
			Declare handles for base and derived classes.
			Create object for derived class handle.
			Randomize the derived class object and check the output.
		b. Assign base class handle to derived class object.
			Randomize the derived class object.
			What is the output?
*/

class base;
	rand int addr;
	constraint cst1{
		addr inside {[10:30]};
	}
endclass

class derived extends base;
	constraint cst1{
		addr inside {[50:70]};
	}
endclass


module A4_Q12;
	derived handle_d = new;
	base handle_b = new;
	derived h_d;// = new;
	initial begin
		handle_d.randomize();
		$display("\nDERIVED CLASS random value  %p\n",handle_d);
		handle_b.randomize();
		$display("BASE CLASS random value %p\n",handle_b);
		handle_b=handle_d;
		$cast(h_d,handle_b);
		h_d.randomize();
		$display("After assignment DERIVED CLASS random value %p\n",h_d);
	end
endmodule
