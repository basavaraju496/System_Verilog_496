module D_FF(output reg  q_out, input d_in,input clear, preset, enable, clk);

	always@(posedge clk,negedge clear,negedge preset) 
		begin
		if(enable) begin
				case({preset,clear})
				2'b00:q_out<=1'bz;
				2'b01:q_out<=1'b1;
				2'b10:q_out<=1'b0;
				2'b11:begin  q_out<=d_in;
				$display("din=%b",d_in);
				end
				default:q_out<=q_out;
				endcase
					$display("inside dut preset=%b din=%b q_out=%b",preset,d_in,q_out );

				end
		else
				q_out<=q_out;
	end

endmodule






