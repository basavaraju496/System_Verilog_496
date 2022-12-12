module A1_Q8;
	enum integer {IDLE,START='bx,STOP}state;
	initial begin
		state = state.first();
		forever begin
			$display("enum name = %s value = %d",state,state);
			if(state==state.last()) break;
			else state=state.next();
		end
	end
endmodule

//**Error: A1_Q8.sv(2): (vlog-13001) An unassigned enumerated name 'STOP' cannot follow the enum member with X or Z assignments.
//** Error: A1_Q8.sv(2): (vlog-13002) Enum member 'STOP' does not have unique value.
