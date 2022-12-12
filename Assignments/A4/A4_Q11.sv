/*
	11.
	Declare a class with name “Flat” with one property var_h and one class handle “kitchen”.
	“kitchen” class has two properties var_k1, var_k2. Declare var_h and var_k1 as random variables.
		a. Randomize 2 times with some conditions to properties.
		b. Randomize without any conditions. Check the output.
*/
class Kitchen;
	rand int var_k1;
	int var_k2=10;
	constraint kitchen_random{
		var_k1 inside {[10:100]};
	}
endclass

class Flat;
	randc int var_h;
	Kitchen k = new;
	constraint random{
		var_h inside {11,111,121,1111,1221,11111,12321};
	}
endclass


module A4_Q11;
	Flat handle;
	initial begin
		handle = new;
		for(int i = 0; i<10;i++) begin
			if(i>1) begin
				handle.random.constraint_mode(0);
				handle.k.kitchen_random.constraint_mode(0);
			end
			handle.randomize();
			handle.k.randomize();
			$display("\t %0p %0p",handle,handle.k);
		end
	end
endmodule
