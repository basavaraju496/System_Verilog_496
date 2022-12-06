class scoreboard;
//---------------------properties-------------------------//

mailbox  h_mbx_2,h_mbx_3;
//virtual mux_intf h_vintf;

transaction h_t1,h_t2;
//virtual mux_intf h_vintf;
//---------------------constructor-------------------------//

function new(mailbox mbx2,mbx3);
		h_mbx_2=mbx2;
		h_mbx_3=mbx3;
		endfunction
//-----------------------method--------------------------//

task comparator;
			//	forever@(h_vintf.cb_monitor)
forever
				begin
				h_t1=new();
				h_t2=new();
			//	$display("----------------------------------5---------------------------- ");
				h_mbx_2.get(h_t1);
				h_mbx_3.get(h_t2);
				$display($time,"mb2=%p",h_t1);
				$display($time,"mb3=%p",h_t2);
				
					if(h_t1.mux_out == h_t2.mux_out)
			$display($time,"\nPASS \t TB  data_in=%b selection_in=%0d mux_out=%b \n DUT  data_in=%b selection_in=%0d mux_out=%b ",h_t1.data_in,h_t1.selection_in,h_t1.mux_out, h_t2.data_in,h_t2.selection_in,h_t2.mux_out );
			else
			$display($time,"\nFAIL \t TB  data_in=%b selection_in=%0d mux_out=%b \n DUT  data_in=%b selection_in=%0d mux_out=%b ",h_t1.data_in,h_t1.selection_in,h_t1.mux_out, h_t2.data_in,h_t2.selection_in,h_t2.mux_out );

				end

endtask

endclass
