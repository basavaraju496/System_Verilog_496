//========================================TRANSACTION==========================//

class transaction;

//-----------------------INPUTS-------------------------------------------------------//
rand bit [7:0]data_in;      // 8 bit data
rand bit [2:0]selection_in;   // 3 bit selection line
bit clk;

//-----------------------OUTPUTS------------------------------------------------------//
bit mux_out;   // 1 bit op

//-----------------------constraint for randomizing the ips---------------------------//

constraint ip_range{ 
		data_in inside {[0:120]};
		selection_in inside{[1:15]};
}

endclass

/*	constraint random_next10{
		var1 inside {[1:100]};
		var2 inside {[30:400]};
declare all ips and categorize the normal ips and random ips	}*/

//declare all ips and ops (same as in dut) and categorize the normal ips and random ips	
