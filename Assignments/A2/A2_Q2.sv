/*module name;
reg[7:0] var1[1:10];
initial
begin
var1[0] = ’d10;
var1[1][4:0] = ’d31;
var1[2:10] = ‘d42;
end
endmodule
Write the above program and simulate it.*/

module A2_Q2;
	reg [7:0] var1[1:10];
	/*initial begin
		var1[0] = 'd10;
		var1[1][4:0] = 'd31;
		var1[2:10] = 'd42; //error--invalid type casting
		$display("%b",var1[1]);
	end*/
	initial begin
		var1[0] = 'd10;
		var1[1][4:0] = 'd31;
		var1[2:10] = '{'d42,1,2,3,4,5,6,7,8};
		foreach(var1[i]) begin
			$display("var[%0d] = %b",i,var1[i]);
		end
	end
endmodule
