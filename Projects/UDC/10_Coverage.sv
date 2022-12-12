class coverage;

	virtual UDC_intf h_intf;

	covergroup coverGroup;
		data_in: coverpoint h_intf.din;
		start: coverpoint h_intf.start_in;
		a0: coverpoint h_intf.A0;
		a1: coverpoint h_intf.A1;
		nrd: coverpoint h_intf.nrd;
		nwr: coverpoint h_intf.nwr;
		ncs: coverpoint h_intf.ncs;
		reset: coverpoint h_intf.reset;
		count: coverpoint h_intf.cout;
	endgroup

	function new(virtual UDC_intf h_intf);
		this.h_intf = h_intf;
		coverGroup = new();
	endfunction
endclass
