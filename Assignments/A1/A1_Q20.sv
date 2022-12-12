//System Verilog
module A1_Q20;
	enum logic [3:0] {IDLE=14,START,STOP='bx} state;
	initial begin
		state = state.first();
		forever begin
			$display("%s\t%d",state,state);
			if(state.name == state.last().name) break;
			state = state.next();
		end
	end
endmodule
