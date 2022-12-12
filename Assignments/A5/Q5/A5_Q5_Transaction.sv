class transaction;
	rand int unsigned data_in;
	rand byte unsigned address;
	rand bit wr_enable;
	bit reset;
	int unsigned data_out;

	constraint random{
		data_in inside {[0:10000]};
	}
endclass
