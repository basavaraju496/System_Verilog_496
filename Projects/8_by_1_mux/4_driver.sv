
//============================DRIVER======================//
class driver;

virtual mux_intf h_vintf;   //  virtual??

//---------------------properties-------------------------//
mailbox h_mbx_1;

transaction ht2;
//---------------------constructor-------------------------//
function new(virtual mux_intf  h_vintf,mailbox mb1)
		h_mbx_1=mb1;
		this.h_vintf=h_vintf;
		endfunction
//-----------------------method--------------------------//
task drive_to_interface;

forever @(h_vintf.cb_driver) // getting at every posedge  clk 
			ht2=new();
			h_mbx_1.get(ht2);
			h_vintf.cb_driver.data_in<=ht2.data_in;  // sending data to intf 
			h_vintf.cb_driver.selection_in<=ht2.selection_in;    // sending data to intf  
			$display($time,"\t sending data to intf ");

endtask

endclass
