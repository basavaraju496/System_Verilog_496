// Code your testbench here
// or browse Examples
class input_monitor;

	//=================== Declaration ===================//
	mailbox h_mbox;
	transaction h_trx;
	virtual updown h_vintf;
	static reg [7:0] im_PLR,im_LLR,im_ULR,im_CCR,im_din,im_cout;
	static bit [2:0] im_start;
	static reg im_start_flag,im_dir,im_ec,im_err;
	static bit [8:0] im_cycles;
	static bit [1:0] im_dir_conditions = {im_PLR==im_ULR,im_PLR==im_LLR};

	//=================== Constructor ===================//
  function new(virtual updown h_vintf,mailbox h_mbox);
		this.h_mbox = h_mbox;
		this.h_vintf = h_vintf;
	endfunction

	//=================== Method ========================//
	task im_WRITE;
		begin
			if(h_trx.nwr==0) begin
				if(h_trx.A1_i == 0) begin
					if(h_trx.A0_i==0) im_PLR=h_trx.d_in;
					else im_ULR=h_trx.d_in;
				end
				else begin
					if(h_trx.A0_i==0) im_LLR=h_trx.d_in;
					else im_CCR=h_trx.d_in;
				end
			end
			if(im_PLR>im_ULR) im_err=1;
			else if(im_PLR<im_LLR) im_err=1;
			else im_err=0;
		end
	endtask

	task im_READ;
		begin
			if(h_trx.nrd==0) begin
				if(h_trx.A1_i == 0) begin
					if(h_trx.A0_i==0) im_din=im_PLR;
					else im_din=im_ULR;
				end
				else begin
					if(h_trx.A0_i==0) im_din=im_LLR;
					else im_din=im_CCR;
				end
			end
			else im_din = 0;
		end
	endtask

	task im_START;
		begin
			im_start = {im_start[1],im_start[0],h_trx.start_i};
			if(im_start==3'b010 && im_CCR!=0 && h_trx.err_o==0) begin
				im_start_flag=1;
				im_DIRECTION;
				im_COUNT;
			end
		end
	endtask

	task im_COUNT;
		begin
			if(im_start==2 && im_start_flag==1) begin
				im_cout = im_PLR;
			end
			else begin
              //$display("dir_con = %d,dir = %d",im_dir_conditions,im_dir);
				case({im_dir_conditions[1:0]==3,im_dir})
					2'b00: im_cout = im_cout-1;
					2'b01: im_cout = im_cout+1;
					2'b10: im_cout = im_cout;
					2'b11: im_cout = im_cout;
					default: im_cout = im_cout;
				endcase
			end
			if(im_cout==im_PLR) im_cycles=im_cycles-1;
			if(im_cycles==0 && im_start_flag==1) begin
				im_ec = 1;
				im_start_flag=0;
			end
			else im_ec=0;
		end
	endtask

	task im_DIRECTION;
		begin
			if(im_ec==1) begin im_dir=1'bz; end
			else if(im_start==2 && im_start_flag ==1) begin
				im_dir = im_dir_conditions[1]?(im_dir_conditions[0]?1'bz:0):1;
				end
			else begin
				case(im_dir)
					1'b0: begin
						if(im_cout == im_LLR)
							if(im_cout == im_ULR) im_dir=0;
							else im_dir=1;
						else im_dir=0;
					end
					1'b1:begin
						if(im_cout == im_ULR)
							if(im_cout == im_LLR) im_dir=0;
							else im_dir=0;
						else im_dir=1;
					end
				endcase
			end
		end
	endtask

	task im_CYCLES_COUNT;
		begin
			if(im_CCR==0) im_cycles = 0;
			else if(im_dir_conditions[1]==1)
				if(im_dir_conditions[0]==1) im_cycles = im_CCR;
				else im_cycles = im_CCR+1;
			else
				if(im_dir_conditions[0]==1) im_cycles = im_CCR+1;
				else im_cycles = 2*im_CCR+1;
		end
	endtask


	task run();
		begin
          forever@(h_vintf.cd_monitor) begin
				h_trx = new();
				h_trx.A0_i = h_vintf.cd_monitor.A0_i;
				h_trx.A1_i = h_vintf.cd_monitor.A1_i;
				h_trx.nwr = h_vintf.cd_monitor.nwr;
				h_trx.nrd = h_vintf.cd_monitor.nrd;
				h_trx.start_i = h_vintf.cd_monitor.start_i;
				h_trx.reset_i = h_vintf.cd_monitor.reset_i;
				h_trx.ncs = h_vintf.cd_monitor.ncs;
				h_trx.d_in = h_vintf.cd_monitor.d_in;

				if(h_trx.ncs==0) begin
					if(h_trx.reset_i==0) begin
						fork
							if(im_start_flag == 0) begin
								im_ec =0;
								im_cout=0;
								im_START;
								if(im_start_flag==0)im_WRITE;
								if(im_start_flag==0)im_CYCLES_COUNT;
							end
							else begin
								fork
									im_start=0;
									im_COUNT;
									im_DIRECTION;
								join
							end
							im_READ;
						join
					end
					else begin
						im_PLR = 0;im_ULR =8'hff;im_LLR=0;im_CCR=0;
						im_start = {im_start[1],im_start[0],1'b0};
						im_start_flag =0;
						h_trx.c_out = 0;
						h_trx.dir_o = 1'bz;
						h_trx.err_o = 0;
						h_trx.ec_o = 0;
						im_cycles =0;
					end
				end
				else begin
					im_start = {im_start[1],im_start[0],1'b0};
					im_start_flag =0;
					h_trx.c_out = 0;
					h_trx.dir_o = 1'bz;
					h_trx.err_o = 0;
					h_trx.ec_o = 0;
				end

				h_trx.c_out = im_cout;
				h_trx.dir_o = im_dir;
				h_trx.ec_o = im_ec;
				h_trx.err_o = im_err;

				h_mbox.put(h_trx);
			end
		end
	endtask

endclass
