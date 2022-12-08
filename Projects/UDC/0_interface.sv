interface UDC_intf(input clk);

	logic [7:0] cout;
	logic dir,err,ec;
	wire [7:0] din;
	logic A0,A1;
	logic reset,ncs,nwr,nrd,start_in;

	clocking cb_driver @(posedge clk);
		input cout,dir,err,ec;
		output din;
		output A0,A1,reset,ncs,nwr,nrd,start_in;
	endclocking

	clocking cd_monitor @(posedge clk);
		input cout,dir,err,ec;
		input din,A0,A1,reset,ncs,nwr,nrd,start_in;
	endclocking

endinterface
