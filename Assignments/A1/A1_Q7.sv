module A1_Q7;
	enum {IDLE,START,STOP='bx}state;
	initial begin
		state = state.first();
		forever begin
			$display("enum name = %s value = %d",state,state);
			if(state==state.last()) break;
			else state=state.next();
		end
	end
endmodule

//** Error: A1_Q7.sv(2): (vlog-13000) Enum member 'STOP' with X or Z assignment is only possible when enum declaration is of 4 state type
