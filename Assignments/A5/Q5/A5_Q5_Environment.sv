class environment;

	virtual memoryInterface h_memintf;
	mailbox h_mbx_gen,h_mbx_tbm,h_mbx_dutm;
	generator h_gen;
	driver h_dvr;
	tbmonitor h_tbm;
	dutmonitor h_dutm;
	scoreboard h_score;

	function new(virtual memoryInterface h_memintf);
		this.h_memintf = h_memintf;
		h_mbx_gen = new();
		h_mbx_tbm = new();
		h_mbx_dutm = new();
		h_gen = new(h_mbx_gen);
		h_dvr = new(h_memintf,h_mbx_gen);
		h_tbm = new(h_memintf,h_mbx_tbm);
		h_dutm = new(h_memintf,h_mbx_dutm);
		h_score = new(h_mbx_tbm,h_mbx_dutm);
	endfunction

	task run();
		fork
			h_gen.run();
			h_dvr.run();
			h_tbm.run();
			h_dutm.run();
			h_score.run();
		join
	endtask
endclass
