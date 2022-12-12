/*
	10.
		Write a program with three classes(Generator, Driver, Monitor).
		In these three classes, declare three different events and trigger them at different time units.
		Once the events are detected in sequence manner then end the simulation.*/


class transaction;
	event trx;
	task run();
	begin
		#10;
		->>trx;
	end
	endtask
endclass

class generator;
	event gen;
	task run();
	begin
		#2;
		->>gen;
	end
	endtask
endclass

class driver;
	event dri;
	task run();
	begin
		#5;
		->>dri;
	end
	endtask
endclass

module A5_Q10;
	driver h_dir;
	generator h_gen;
	transaction h_trx;

	event a,b,c;

/*	initial begin
		h_trx = new();
		h_gen = new();
		h_dir = new();
		fork
		h_trx.run();
		h_dir.run();
		h_gen.run();
		join
	end//*/

	initial begin
		#1 ->a;
		#1 ->b;
		#1 ->c;
	end
	initial begin
		forever begin
		wait_order(a,b,c)
			$display($stime,"\t Wait is OVER");
		//else $display($stime,"\t waiting...");
		$finish;
		end
	end

	initial #40 $finish;
endmodule
