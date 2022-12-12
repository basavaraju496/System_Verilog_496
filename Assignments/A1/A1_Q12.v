//2-Dimensional array
module A1_Q12;
	reg [3:0] array_2D [0:2][0:2];//array declaration.
	integer i,j;
	initial begin
		for(i=0;i<3;i=i+1) begin//row iteration
			for(j=0;j<3;j=j+1)begin//coloumn iteration
		  		array_2D[i][j]=i+j;//inserting values
			end
		end
		$display("%p",array_2D);
	end
endmodule
