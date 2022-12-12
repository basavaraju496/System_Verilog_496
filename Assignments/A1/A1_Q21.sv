//Using TASK in verilog
module A1_Q21;
	typedef enum {IDLE,START,STOP,WAIT} state;
	state s1;
	always_comb begin
		case(s1)
		  IDLE: $display("state = %d", s1);
		  START: $display("state = %d", s1);
		  STOP: $display("state = %d", s1);
		  WAIT: $display("state = %d", s1);
		endcase
	end
endmodule
//---------------OUTPUT-------------
//		state =           0
//since s1 is not updating in the whole design, by default s1 will be IDLE state with value 0
