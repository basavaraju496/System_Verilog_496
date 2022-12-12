//Using TASK in verilog
module A1_Q22;
	typedef enum {IDLE,START,STOP} state;
	parameter WAIT = 'd3;
	state s1;
	always_comb begin
		case(s1)
		  IDLE: s1 = START;
		  START: s1 = STOP;
		  STOP: s1 = WAIT;
		  //WAIT: $display("state = %d", s1);
		endcase
	end
	initial $monitor("state = %s",s1);
endmodule
//---------------OUTPUT-------------
// Error is generated.
// # ** Warning: A1_Q22.sv(7): (vopt-2182) 's1' might be read before written in always_comb or always @* block.
// # ** Error (suppressible): A1_Q22.sv(10): (vopt-8386) Illegal assignment to type 'enum int ' from type 'reg[31:0]': An enum variable may only be assigned the same enum typed variable or one of its values.
// # ** Error: (vopt-2064) Compiler back-end code generation process terminated with code 12.
