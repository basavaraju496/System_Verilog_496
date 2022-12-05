class scoreboard;
//---------------------properties-------------------------//

mailbox  h_mbx_2,h_mbx_3;

transaction h_t1,h_t2;
//---------------------constructor-------------------------//

function new(mailbox mbx2,mbx3)
		h_mbx_2=mbx2;
		h_mbx_3=mbx3;
		endfunction
//-----------------------method--------------------------//

task comparator;
				forever@(cb_monitor)
				begin
				h_t1=new();
				h_t2=new();
				h_mbx_2.get(h_t1);
				h_mbx_3.get(h_t2);
					if(h_t1.mux_out == h_t2.mux_out)
			$display($time,"PASS \t TB  data_in=%b selection_in=%0d mux_out=%b \n DUT  data_in=%b selection_in=%0d mux_out=%b ",h_t1.data_in,h_t1.selection_in,h_t1.mux_out, h_t2.data_in,h_t2.selection_in,h_t2.mux_out );
			else
			$display($time,"FAIL \t TB  data_in=%b selection_in=%0d mux_out=%b \n DUT  data_in=%b selection_in=%0d mux_out=%b ",h_t1.data_in,h_t1.selection_in,h_t1.mux_out, h_t2.data_in,h_t2.selection_in,h_t2.mux_out );

				end

endtask

endclass
