module mux8to1(input [7:0]data_in,input [2:0]dut_selection_in,output reg dut_mux_out,input clk);

// ------------------------ input is 8bit data  ----------------------------//
// ------------------------selection is for selecting which data to transmit ---------------------------------//
always@(posedge clk)
		  begin
				//	mux_out<=data_in[selection_in];
					dut_mux_out<=data_in[dut_selection_in];
					$display($time,"inside dut data_in=%b selection_in=%0d mux_out=%b clk=%b ",data_in,dut_selection_in,dut_mux_out,clk);

		  end
endmodule


