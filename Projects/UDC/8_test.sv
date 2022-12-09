class test;

	environment h_env;
	virtual UDC_intf h_vintf; 
	
	function new(virtual UDC_intf h_vintf);
		this.h_vintf = h_vintf;  
		h_env = new(h_vintf);
	endfunction

	task run();
		h_env.run();  
	endtask

endclass
