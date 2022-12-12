/*
	8.
		Write a program with three classes(Transaction, Generator, Driver).
		Transaction Class ---> 	addr – 8 bit
										data – 16 bit
		Generator – Generate one transaction
		Driver – After the generation of one transaction, the driver has to take that transaction and display it.
			Repeat the above generation and driving of transaction for four times.
		a. Driver should take 4 transactions without deleting the content in the mailbox.
			Also display the mailbox contents and its size.
		b. Driver should take 4 transactions by erasing the content in mailbox.
			(once content get accessed then that content is erased)*/


class transaction;
	rand byte unsigned addr;
	rand shortint unsigned data;
	constraint array_c{
		addr inside {[0:200]};
		data inside {[0:1000]};
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
			$display($time,"\t GENERATOR mailbox--%0p  size--%0d",h_mbx,h_mbx.num());
			$display($time,"\t transaction %p",h_trans);
			#1;
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
		repeat(4) begin
		h_trans = new();
		h_mbx.get(h_trans);
		h_mbx.put(h_trans);
		$display($time,"\t DRIVER mailbox--%0p  size--%0d",h_mbx,h_mbx.num());
		$display($time,"\t transaction %p",h_trans);
		#1;
		end
	endtask
endclass

module A5_Q8;
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
endmodule
