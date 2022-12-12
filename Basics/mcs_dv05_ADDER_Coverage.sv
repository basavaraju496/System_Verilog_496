class coverageClass;
	virtual adder_intf h_intf;
	covergroup coverGroup;
		in_1: coverpoint h_intf.in1{
				bins binBasava = {[0:100]};
				bins binArjun = {[100:200]};
			}
		in_2: coverpoint h_intf.in2;
		rst: coverpoint h_intf.reset;
	endgroup

	function new(virtual adder_intf h_intf);
		this.h_intf = h_intf;
		coverGroup = new();
	endfunction

endclass
