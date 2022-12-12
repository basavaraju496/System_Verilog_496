/*reg[1:0] array_s[0:10][0:256];
Using foreach
a. Initialize the above array with positive random values
b. Display all the locations contents*/

module A2_Q1;
	reg [1:0] array [0:10][0:256];//2-dimensional array
	initial begin
		foreach(array[i]) begin			//row iteration
			foreach(array[i][j]) begin	//column iteration
				array[i][j] = $random;	//randomisation
			end
		end
		foreach(array[i]) begin
			$display("%p",array[i]);
		end
	end
endmodule
