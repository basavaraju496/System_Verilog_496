module A1_Q9;
	reg [7:0] num;
	initial begin
  		begin:for_loop
			num=0;
			forever begin
				$display("Number is %d",num);
				if(num==50) begin
					disable for_loop;
				end
				num=num+1;
			end
		end
		$display("Terminated");
	end
endmodule
