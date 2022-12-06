
interface dff_intf(input clk);
//recieve clk from top
	logic din;
	logic clear_in,preset,enable;
	logic q_out;

	clocking cb_driver@(posedge clk);
		output din,preset,clear_in,enable;     // default #0 delay
		input q_out;    // default #1 delay
	endclocking

	clocking cb_monitor@(posedge clk);
		input #0 din,preset,clear_in,enable;    
		input #0 q_out;   
	endclocking
always@(posedge clk)
		begin 
		
		$display("INSIDE INTERFACE \ndin=%b q_out=%b preset=%b clear=%b enable=%b \n",din,q_out,preset,clear_in,enable);
		end



endinterface
