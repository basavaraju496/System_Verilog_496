/*
	6. Write a program with two classes(Generator, Driver).
		Generator – Generate random values to an array and give this to driver.
		Driver – Take the array and display the content of an array(queue type).
		Generator has to send an array to the driver for four times.
		a. Achieve this without using any inbuilt concepts.
		b. Achieve this using inbuilt concepts.*/



//===============WITH IN-BUILT==================//
/*class transaction;
	rand int array[10];
	constraint array_c{
		foreach(array[i]){
			array[i] inside {[0:100]};
		}
	}
endclass

class generator;
	transaction h_trans;
	mailbox h_mbx;
	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;
	endfunction

	task run();
		repeat(4)
		begin
			h_trans = new;
			if(h_trans.randomize());
			h_mbx.put(h_trans);
			$display($time,"\t GENERATOR %p",h_trans);
		end
	endtask
endclass

class driver;
	transaction h_trans;
	mailbox h_mbx;

	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;
	endfunction

	task run();
		forever begin
		h_trans = new();
		h_mbx.get(h_trans);
		$display($time,"\t DRIVER %p",h_trans);
		#1;
		end
	endtask
endclass

module A5_Q6;
	driver h_dir;
	generator h_gen;
	mailbox h_genm;

	initial begin
		h_genm = new();
		h_gen = new(h_genm);
		h_dir = new(h_genm);
		fork
			h_gen.run();
			h_dir.run();
		join
	end

//	initial begin
//		$monitor("%p",h_dir.h_trans);
//	end//
	initial #10 $finish;
endmodule//*/


//===============WITHOUT IN-BUILT==================//
class transaction;
	rand int array[10];
	constraint array_c{
		foreach(array[i]){
			array[i] inside {[0:100]};
		}
	}
endclass

class generator;
	transaction h_trans;
	static transaction h_trans_queue[$];
	int i;

	task run();
		repeat(4)
		begin
			h_trans = new;
			if(h_trans.randomize());
			h_trans_queue.push_back(h_trans);
			$display($time,"\t GENERATOR %p",h_trans_queue[i]);
			i++;
		end
	endtask
endclass

class driver;
	transaction h_trans;
	generator h_gen;

	task run();
		forever begin
		h_trans = new();
		h_gen = new;
		h_trans = h_gen.h_trans_queue.pop_front();
		if(h_trans==null) begin
			$finish;end
		else
			$display($time,"\t DRIVER %p",h_trans);
		#1;
		end
	endtask
endclass

module A5_Q6;
	driver h_dir;
	generator h_gen;

	initial begin
		h_gen = new;
		h_dir = new;
		fork
			h_gen.run();
			h_dir.run();
		join
	end

	/*initial begin
		$monitor("%p",h_dir.h_trans);
	end//*/
	initial #10 $finish;
endmodule//*/
