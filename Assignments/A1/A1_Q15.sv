module A1_Q15;
	integer state;
	initial begin
		int count='d10;
		#10 state='d20;
	end
	initial begin
		#10 $display("count=%d",count);
		#15 $display("state=%d",state);
	end
endmodule
//** Error (suppressible): A1_Q15.sv(8): (vopt-7063) Failed to find 'count' in hierarchical name 'count'.
