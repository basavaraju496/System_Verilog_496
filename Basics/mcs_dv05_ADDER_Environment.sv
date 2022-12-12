class environment;

	virtual adder_intf h_intf;
	mailbox h_mbx_rand,h_mbx_tbm,h_mbx_dutm;
	generator h_gen;
	driver h_dvr;
	dutMonitor h_dutm;
	tbMonitor h_tbm;
	scoreboard h_scrb;
//	coverageClass h_cov;

	function new(virtual adder_intf h_intf);
		this.h_intf = h_intf;
		h_mbx_rand = new(1);
		h_mbx_tbm = new();
		h_mbx_dutm = new();
		h_gen = new(h_mbx_rand);
		h_dvr = new(h_intf,h_mbx_rand);
		h_dutm = new(h_intf,h_mbx_dutm);
		h_tbm = new(h_intf,h_mbx_tbm);
		h_scrb = new(h_mbx_dutm,h_mbx_tbm);
	//	h_cov = new(h_intf);
	endfunction

	task run();
		fork
		h_gen.run();
		h_dvr.run();
		h_dutm.run();
		h_tbm.run();
		h_scrb.run();
		//h_cov.run();
		join
	endtask
endclass
