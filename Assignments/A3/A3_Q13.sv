/*
	13
	Write a function code to complete the below program.
	Class packet;
	bit write;
	bit[2:0] address;
	int w_data;
	int r_data;
	function new(......................)
	.
	.
	endfunction
	endclass
	initial
	begin
	pakcet p1;
	p1=new(1’b1, 3’b000, ‘d100, ‘d100);
	//display the properties values also
	end
	a. The function(new) arguments should have different names with respect to the property names.
	b. The function(new) arguments should have same names as the property names.*/


//=================================================//
//=================== CLASS =======================//
//=================================================//
class packet;
	bit write;
	bit[2:0] address;
	int w_data;
	int r_data;

	function new(bit write_arg,bit[2:0] address_arg,int w_data_arg,int r_data_arg);
		write = write_arg;
		address = address_arg;
		w_data = w_data_arg;
		r_data = r_data_arg;
	endfunction

	function new_this(bit write,bit[2:0] address,int w_data,int r_data);
		this.write = write;
		this.address = address;
		this.w_data = w_data;
		this.r_data = r_data;
	endfunction


endclass
class packet_1;
	bit write;
	bit[2:0] address;
	int w_data;
	int r_data;

	function new(bit write,bit[2:0] address,int w_data,int r_data);
		this.write = write;
		this.address = address;
		this.w_data = w_data;
		this.r_data = r_data;
	endfunction


endclass


//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q13;
	packet p1;
	packet_1 packet1;
	initial begin
		p1=new(1'b1, 3'b000, 'd100, 'd100);
		packet1=new(1'b1, 3'b000, 'd100, 'd100);
		$display("========================================================================");
		$display("Packet with out this %p",p1);
		$display("Packet with this %p",packet1);
		$display("========================================================================");
	end
endmodule
