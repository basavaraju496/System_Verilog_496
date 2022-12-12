class test;

	environment h_envi;
	virtual adder_intf h_intf;

	function new(virtual adder_intf h_intf);
		this.h_intf = h_intf;
	endfunction

	task run();
		h_envi = new(h_intf);
		h_envi.run();
	endtask
endclass
