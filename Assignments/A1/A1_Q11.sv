module A1_Q11;
	int i;
	initial begin
		for(i=9;i>=-7;i--) begin
			if(i<0)
		  		continue;
			$write("%0d ",i);
		end
		$display("");
	end
endmodule
