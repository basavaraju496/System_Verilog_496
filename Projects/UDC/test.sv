class test;

	environment h_env;
	virtual dff_intf h_vintf; 
	function new(virtual dff_intf h_vintf);
		this.h_vintf = h_vintf;  
		h_env = new(h_vintf);
	endfunction

	task run();
		h_env.run();  
	endtask

endclass
