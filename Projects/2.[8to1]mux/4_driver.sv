
//============================DRIVER======================//
class driver;

virtual mux_intf h_vintf;   //  virtual??

//---------------------properties-------------------------//
mailbox h_mbx_1;

transaction ht2;
//---------------------constructor-------------------------//
function new(virtual mux_intf  h_vintf,mailbox mb1);
		h_mbx_1=mb1;
		this.h_vintf=h_vintf;
		endfunction
//-----------------------method--------------------------//
task drive_to_interface;

forever begin @(h_vintf.cb_driver) // getting at every posedge  clk  
			ht2=new();
			h_mbx_1.get(ht2);
			h_vintf.cb_driver.data_in<=ht2.data_in;  // sending data to intf 
			h_vintf.cb_driver.selection_in<=ht2.selection_in;    // sending data to intf  
							//	$display("-------------------2-------------------------");
			//$display($realtime,"\t sending data to interface data_in=%b selection_in=%0d mux_out=%b",h_vintf.cb_driver.data_in,h_vintf.cb_driver.selection_in,h_vintf.cb_driver.mux_out);
		//	$display("h_vintf=%p",h_vintf);
								//h_vintf.display1;
			end
endtask

endclass

/*

15	 sending data to interface data_in=01000100 selection_in=3 mux_out=x
# 25	 sending data to interface data_in=00011010 selection_in=1 mux_out=x
# 35	 sending data to interface data_in=00100111 selection_in=1 mux_out=x
# 45	 sending data to interface data_in=01101110 selection_in=1 mux_out=x
# 55	 sending data to interface data_in=01110111 selection_in=2 mux_out=x
# 65	 sending data to interface data_in=00001011 selection_in=1 mux_out=x
# 75	 sending data to interface data_in=01001101 selection_in=3 mux_out=x
# 85	 sending data to interface data_in=01001101 selection_in=2 mux_out=x
# 95	 sending data to interface data_in=00111110 selection_in=1 mux_out=x
*/
