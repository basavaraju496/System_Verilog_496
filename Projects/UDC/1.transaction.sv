class transaction;

randc bit ncs,nrd,nwr,start_in,reset;
randc bit A0,A1;
rand bit [7:0]din;

bit err,ec,dir;
bit [7:0]cout;


endclass


/*`define WIDTH 7
module up_down_counter2556 (inout [`WIDTH:0]Din,input clk,ncs,nrd,nwr,start_in,reset,A0,A1 ,output reg [`WIDTH:0]cout,output reg err,ec,dir);*/
