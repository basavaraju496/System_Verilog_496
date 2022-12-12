module A1_Q3;
	reg [3:0] sub,bin,dec;
	initial begin
		bin=4'b1000;
		dec=4'd1000;
		sub=bin-dec;
		$display("4'b1000 - 4'd1000 = 4'b%b",sub);
	end
endmodule

//The 4'b1000 subtraction of 4'b1000 and 4'd1000 gives result 0
//because the binary of 'd1000 is 1111101000, but it is restricted to 4 bits hence all the MSB bits are truncated ony last 4 LSB bits are considered.
//Therefore 4'b1000-4'd1000 = 0
