class transaction;
	rand byte unsigned in1,in2;
	rand bit reset;
	bit [8:0] sum;
	constraint addrand{
		in1 inside {[50:150]};
	}
endclass
