/*bit[3:0][7:0] var1;
bit[7:0]var2[1:0];
Initialize the above arrays var1 and var2 with any values.
Increment the values of var1 and var2 by 10 and display the result.*/

module A2_Q4;
	bit[3:0][7:0] var1;	//array of 4 locations with size 8 bit;PACKED array
	bit[7:0]var2[1:0];	//array of 2 locations with size 8 bit;UNPACKED array

	initial begin
		var1 = '{'d12,'d49,'d15,'d95};//intialisation
		var2 = '{123,81};
		$display("BEFORE INCREMENT\nvar1 = %p\nvar2 = %p",var1,var2);
		foreach(var1[i])
		  var1[i] = var1[i]+10;
		foreach(var2[i])
		  var2[i] = var2[i]+10;
		$display("AFTER INCREMENT by 10\nvar1 = %p\nvar2 = %p",var1,var2);
	end
endmodule
