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
		input  #0 cout,dir,err,ec;
		input  #0 din,A0,A1,reset,ncs,nwr,nrd,start_in;
	endclocking


/*always@(clk)
			begin
					$display($time,"ncs=%b nrd=%b nwr=%b start_in=%b A0=%b A1=%b din=%0d  cout=%0d ",ncs,nrd,nwr,start_in,A0,A1,din,cout);  
			end
			*/
endinterface
