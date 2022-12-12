module memory(output reg [31:0]data_out,input [31:0]data_in, input[7:0] addr, input w_r,reset,clock);

	reg [31:0] mem [0:255];
	reg [31:0] data;

	integer i;

	always@(posedge clock) begin
		if(reset==1) begin
			data_out<=1'bz;
		end
		else begin
			data_out<=data;
		end
	end

	always@(*)begin
		if(w_r==0) begin
			mem[addr] = data_in;
			data = 1'bz;
		end
		else begin
			data = mem[addr];
		end
	end
	always@(*) begin
		if(reset==1)begin
			for(i=0;i<259;i=i+1) begin
				mem[i]=0;
			end
		end
	end
endmodule
