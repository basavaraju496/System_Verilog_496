/*
	9.
		Write a program with three classes(Transaction, Generator, Driver).
		Transaction class --> int arr_que[$]; (Write a constraint for queue size.)
		Generator – For every 10 time units generate a transaction. Repeat for 2 times.
		Driver – In driver the valid data will be available only after 10 timeunits
			(i.e.which wiil be given by the generator), so before 10 times units itself
			the array value to be initialized with some default values in the driver.
			And after 10 timeunits take the content which is generated by the Generator.*/


class transaction;
	rand int arr_que[$];
	constraint random{
		foreach(arr_que[i]) {
			arr_que[i] inside {[15:40]};
		}
		arr_que.size()<11;
	}
endclass

class generator;
	transaction h_trans;
	mailbox h_mbx;
	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;
	endfunction

	task run();
		repeat(2)
		begin
			#10;
			h_trans = new;
			if(h_trans.randomize());
			h_mbx.put(h_trans);
			$display($stime,"\t GENERATOR mailbox--%0p  size--%0d",h_mbx,h_mbx.num());
			$display($stime,"\t transaction %p",h_trans);
		end
	endtask
endclass

class driver;
	transaction h_trans;
	mailbox h_mbx;
	int i=0;

	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;
	endfunction

	task run();
		forever begin
		h_trans = new();
		h_mbx.try_get(h_trans);
		$display($time,"\t DRIVER mailbox--%0p  size--%0d",h_mbx,h_mbx.num());
		$display($time,"\t transaction %p",h_trans);
		#10;
		end
	endtask
endclass

module A5_Q9;
	driver h_dir;
	generator h_gen;
	mailbox h_genm;

	initial begin
		h_genm = new(1);
		h_gen = new(h_genm);
		h_dir = new(h_genm);
		fork
			h_gen.run();
			h_dir.run();
		join
	end

	initial #40 $finish;
endmodule