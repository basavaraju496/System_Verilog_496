module A1_Q10;
	byte num;
	initial begin
		num=0;
		forever begin
			$display("Number is %d",num);
			if(num==50) begin
				$display("If number is %0d, the forever loop need to be terminated.",num);
				break;
			end
			num=num+1;
		end
		$display("-------------Loop is TERMINATED-------------");
	end
endmodule
