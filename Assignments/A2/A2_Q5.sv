/*bit[2:0][7:0] var1,var2;
bit[2:0][7:0] sum;
a.Initialize var1, var2. Add var1,var2 and store the result into sum array.
bit[7:0] var1[3:0],var2[3:0];
bit[7:0]sum[3:0];
b.Initialize var1, var2. Add var1,var2 and store the result into sum array.*/


module A2_Q5_a;
	bit[2:0][7:0] var1,var2;	//array of 3 locations with size 8 bit;PACKED array
	bit[2:0][7:0] sum;			//array of 3 locations with size 8 bit;PACKED array

	initial begin
		//Initilization
		foreach(var1[i]) begin
		  var1[i]=$random;
		  var2[i]=$random;
		end
		foreach(sum[i])
		  sum[i] = var1[i]+var2[i];
		foreach(sum[i])
		  $display("%d + %d = %d",var1[i],var2[i],sum[i]);
		$display("%p + %p = %p",var1,var2,sum);
	end
endmodule

module A2_Q5_b;
	bit[7:0] var1[3:0],var2[3:0];	//array of 4 locations with size 8 bit;UNPACKED array
	bit[7:0] sum[3:0];				//array of 4 locations with size 8 bit;UNPACKED array

	initial begin
		//Initilization
		foreach(var1[i]) begin
		  var1[i]=$random;
		  var2[i]=$random;
		end
		foreach(sum[i])
		  sum[i] = var1[i]+var2[i];
		foreach(sum[i])
		  $display("%d + %d = %d",var1[i],var2[i],sum[i]);
		$display("%p + %p = %p",var1,var2,sum);
	end
endmodule
