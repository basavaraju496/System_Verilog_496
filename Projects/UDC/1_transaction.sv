class transaction;

rand bit ncs,nrd,nwr,start_in,reset;
randc bit A0,A1;
//randc	bit  A1;
rand bit [7:0]din;

bit err,ec,dir;
bit [7:0]cout;

constraint din_range1{
		if({A0,A1}==2'B11)
				din inside {[1:5]}; //ccr
}




constraint din_range4{
		if({A0,A1}==2'B00)
				din inside {[10:12]};  }  //plr

constraint din_range2{
		if({A0,A1}==2'B01)
				din inside {[15:17]}; }    //ulr

constraint din_range3{
		if({A0,A1}==2'B10)       
				din inside {[5:7]};   //llr
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
