//---------------------TEST-------------------------//
class test;
//---------------------properties-------------------------//

	environment h_env; 
	virtual adder_intf h_vintf; 
//---------------------constructor-------------------------//
 
	function new(virtual adder_intf h_vintf);
		this.h_vintf = h_vintf;   
		h_env = new(h_vintf);
	endfunction
//-----------------------method--------------------------//

	task run();
		h_env.run();  
	endtask

endclass