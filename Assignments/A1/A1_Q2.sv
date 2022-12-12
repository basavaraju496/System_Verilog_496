module A1_Q2;
	logic logic_var;

	assign logic_var=1;
	always@(*) logic_var=0;

	initial $monitor("logic=%b",logic_var);
endmodule

//when logic is given to both assign and always it throws an error.
//** Error (suppressible): A1_Q2.sv(5): (vlog-12003) Variable 'logic_var' written by continuous and procedural assignments. See A1_Q2.sv(4).
