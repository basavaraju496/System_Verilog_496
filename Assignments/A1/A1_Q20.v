//Verilog
module A1_Q20;
	parameter IDLE = 2'd0,START = 2'd1, STOP = 2'd2;
	reg [1:0] state=0, state_next=0;
	reg clock=0;
	always #1 clock = ~clock;
	initial #8 $finish;
	always@(posedge clock) state<=state_next;
	always@(*) begin
		case(state)
		  IDLE:begin $display("\nIDLE\n"); state_next = START; end
		  START:begin $display("START\n"); state_next = STOP; end
		  STOP:begin $display("STOP\n");$finish; end
		endcase
	end
endmodule

