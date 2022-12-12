interface adder_intf(input clock);
	logic [7:0]in1,in2;
	logic reset;
	logic [8:0]sum;

	clocking cb_driver@(posedge clock);
		input sum;
		output in1,in2,reset;
	endclocking

	clocking cb_monitor@(posedge clock);
		input #0 in1,in2,reset;
		input #0 sum;
	endclocking

endinterface
