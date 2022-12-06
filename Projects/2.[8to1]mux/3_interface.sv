interface mux_intf(input clk);

logic [7:0]data_in;

logic [2:0]selection_in;

logic mux_out;

always@(posedge clk)
		begin
			   
$display($time,"inside the interface cb driver mux_out=%0d data_in=%b selection_in=%b  ",mux_out,data_in,selection_in);
	
		end


//----------------------------------------------------------------------//
clocking cb_driver@(posedge clk);   // for driver    // not kept :
			input    mux_out;    // #1 delay 
			output   data_in,selection_in;   // #0 delay 
			//display1;
//$display("inside the interface cb driver mux_out=%0d data_in=%b selection_in=%b  ",mux_out,data_in,selection_in);
			
		endclocking
		
//----------------------------------------------------------------------//
clocking cb_monitor@(posedge clk);   // for ip monitor  , op monitor not kept ;  

			input    #0 mux_out;  
			input    #0 data_in,selection_in;  
			//	display2;
		endclocking
/*task display1;
$display("inside the interface cb driver mux_out=%0d data_in=%b selection_in=%b  ",mux_out,data_in,selection_in);
endtask

//task display2;
//$display("inside the interface cb monitor mux_out=%0d data_in=%b selection_in=%b  ",mux_out,data_in,selection_in);
//endtask*/
endinterface
