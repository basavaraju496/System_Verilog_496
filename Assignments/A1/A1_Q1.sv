module A1_Q1;
	
	//two state variables
	bit bit_var;
	byte byte_var;
	int int_var;
	shortint shortint_var;
	longint longint_var

	initial begin
		#1
		bit_var=$random;byte_var=$random;int_var=$random;shortint_var=$random;longint_var=$random;
		#1
		bit_var=1'bx;byte_var=8'b1101xxxx;int_var=32'b101110111xxxxxx;shortint_var=16'b101110111xxxxxx;longint_var=64'b101110111xxxxxx;
		#1
		bit_var=1'bz;byte_var=8'b1101zzz0;int_var=32'b101110111zzzzz;shortint_var=16'b101110111zzzzz;longint_var=64'b101110111zzzzzz;
		#1
		bit_var=$random;byte_var=$random;int_var=$random;shortint_var=$random;longint_var=$random;
	end

	initial $monitor("bit = %0b,byte = %0b,int = %0b,shortint = %0b,longint = %0b",bit_var,byte_var,int_var,shortint_var,longint_var);



endmodule
