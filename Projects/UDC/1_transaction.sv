class transaction;

rand reg ncs,nrd,nwr,start_in,reset;
rand bit A0,A1;
randc reg [7:0]din;

//static byte temp;

bit err,ec,dir;
bit [7:0]cout;

	constraint random{
		soft start_in==0; // it can be overridden by the inline constraints
		soft nwr==1;
		soft nrd==1;
		soft reset==0;
		soft ncs==0;
	}
	constraint random_din{
		din inside {[0:255]};
if(A0==1 && A1==1)
		din inside {[1:3]};
/*	if(A0==0 && A1==0)
		din inside {10};
if(A0==0 && A1==1)
		din inside {15};
if(A0==1 && A1==0)
		din inside {5};*/
	}
endclass


/*`define WIDTH 7
module up_down_counter2556 (inout [`WIDTH:0]Din,input clk,ncs,nrd,nwr,start_in,reset,A0,A1 ,output reg [`WIDTH:0]cout,output reg err,ec,dir);
 
 
 
	constraint randCCR{
		d_in inside {[0:60]};
		if(A0_i==1 && A1_i==1) d_in inside {[1:5]};
		if(A0_i==0 && A1_i==0) d_in inside {[10:20]};
		if(A0_i==1 && A1_i==0) d_in inside {[21:35]};
		if(A0_i==0 && A1_i==1) d_in inside {[1:10]};
	}
 

 
 
 */
