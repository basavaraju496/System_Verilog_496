class dut_monitor;
//---------------------properties-------------------------//

mailbox h_mbx3; 

transaction ht;  // handler for transaction class

virtual mux_intf h_vintf;
//---------------------constructor-------------------------//

function new(virtual mux_intf h_vintf,mailbox incoming_mbx)
				this.h_vintf=h_vintf;
				h_mbx3=mb3;
		endfunction
//-----------------------method--------------------------//

task take_from_dut;

forever@(h_vintf.cb_monitor)
		begin

				ht=new():
				ht.data_in=h_vintf.cb_monitor.data_in;
				ht.selection_in=h_vintf.cb_monitor.selection_in;
				ht.mux_out=h_vintf.cb_monitor.mux_out;
				h_mbx3.put(ht);
		end
endtask

endclass
