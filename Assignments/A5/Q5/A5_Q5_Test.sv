class test;

	environment h_envi;
	virtual memoryInterface h_mem_intf;

	function new(virtual memoryInterface h_mem_intf);
		this.h_mem_intf = h_mem_intf;
		h_envi = new(h_mem_intf);
	endfunction
	task run();
		h_envi.run();
	endtask

endclass
