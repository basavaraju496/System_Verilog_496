module A1_Q4;
	bit [3:0] value_a,value_b;
	byte unsigned conc_value;
	initial begin
		value_a=$random;
		value_b=$random;
		conc_value = {value_a,value_b};
		$display("----->    value_a = 4'b%b(%0d), value_b = 4'b%b(%0d) \n----->    Concatinated value {value_a,value_b} is = {4'b%b,4'b%b} ===> %b(%0d)",value_a,value_a,value_b,value_b,value_a,value_b,conc_value,conc_value);
	end
endmodule


