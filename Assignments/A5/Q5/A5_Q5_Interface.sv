interface memoryInterface(input clock);

	logic [31:0] data_in,data_out;
	logic [7:0] addr;
	logic reset,wr_en;

	clocking cb_driver@(posedge clock);
			input data_out;
			output data_in,reset,wr_en,addr;
	endclocking

	clocking cb_monitor@(posedge clock);
			input#0 data_in,reset,wr_en,addr;
			input#0 data_out;
	endclocking

endinterface
