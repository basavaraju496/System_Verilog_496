/*`include "A5_Q5_Interface.sv"
`include "A5_Q5_Transaction.sv"
`include "A5_Q5_Generator.sv"
`include "A5_Q5_Driver.sv"
`include "A5_Q5_TB_monitor.sv"
`include "A5_Q5_DUT_monitor.sv"
`include "A5_Q5_Scoreboard.sv"
`include "A5_Q5_Environment.sv"
`include "A5_Q5_Test.sv"*/
module top;

	wire [31:0] data_out;
	reg [31:0] data_in;
	byte unsigned addr;
	bit clock,reset,wr_en;
	always #5 clock++;
//	int i;
	memoryInterface h_memintf(clock);
	test h_test;

	memory DUT(h_memintf.data_out,h_memintf.data_in,h_memintf.addr,h_memintf.wr_en,h_memintf.reset,clock);

	initial begin
		h_test = new(h_memintf);
		h_test.run();
	end

	/*initial begin
		begin
			@(negedge clock) reset = 0;
			@(negedge clock) reset = 1;
			@(negedge clock) reset = 0;
			//@(negedge clock) addr = 0;

		end
		fork
			stimulus;
		join
	end

	task stimulus;
		begin
			repeat(5) @(negedge clock) begin
				data_in = $urandom_range(0,10000);
				addr = i;
				i++;
			//	wr_en = $random;
			end
			i=0;
			repeat(5) @(negedge clock) begin
				data_in = $urandom_range(0,10000);
				addr = i;
				i++;
				wr_en = 1;
				end
		end
	endtask*/

	//initial $monitor("data_in = %d,addr=%d, en = %d, reset = %d, data_out = %d",data_in,addr,wr_en,reset,data_out);

	initial begin
		#1000 $finish;
	end
endmodule
