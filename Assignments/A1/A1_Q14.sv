module A1_Q14;
	byte number;
	initial begin
		number=5;
		$display("Original number = %d",number);
		#1 $display("post-increment    num++ ---->%d",number++);
		#1 $display("post-incremented        ---->%d",number);
		#1 $display("pre-increment     ++num ---->%d",++number);
		#1 $display("pre-incremented         ---->%d",number);
	end
endmodule
