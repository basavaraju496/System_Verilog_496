/*module name;
reg[31:0] mem [7:0][0:3];
initial
begin
mem[0][0]=’d40;
mem[1][0:2]=’d52;
mem[1][3][5:0]=’d110;
end
endmodule
Write the above program and simulate it.*/

module A2_Q3;
	reg[31:0] mem [7:0][0:3];
	/*initial begin
		mem[0][0]='d40;
		mem[1][0:2]='d52;
		mem[1][3][5:0]='d110;
		$display("%p",mem);
	end//*/
	initial begin
		mem[0][0]='d40;
		mem[1][0:2]='{'d52,1,2};
		mem[1][3][5:0]='d110;
		foreach(mem[i]) begin
			foreach(mem[i][j]) begin
				$write("%d ",mem[i][j]);
			end
			$display("");
		end
	end

endmodule
