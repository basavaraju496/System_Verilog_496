//2-Dimensional array
module A1_Q12;
	reg [3:0] array_2D [3][3];//array declaration.
	initial begin
		foreach(array_2D[i]) begin//row iteration
			foreach(array_2D[i][j])begin//coloumn iteration
		  		array_2D[i][j]=i+j;//inserting values
			end
		end
		$display("%p",array_2D);
	end
endmodule
