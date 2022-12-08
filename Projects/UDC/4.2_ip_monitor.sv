class input_monitor;
	mailbox h_mbox;
	transaction h_trans;
	virtual UDC_intf h_vintf;
	reg [7:0] plr,llr,ulr,ccr,din_temp,cout1;
	bit [2:0] start;
	reg start_F,dir1,ec1,err1;
	bit [8:0] flag_EC;
	//static bit [1:0] dir_cond = {plr==ulr,plr==llr};

  function new(virtual UDC_intf h_vintf,mailbox h_mbox);
		this.h_mbox = h_mbox;
		this.h_vintf = h_vintf;
	endfunction

	task write_tx;
		begin
			if(h_trans.nwr==0) begin
				case({h_trans.A1,h_trans.A0})
					2'b00 : plr = h_trans.din;
					2'b01 :	ulr = h_trans.din;
					2'b10 : llr = h_trans.din;
					2'b11 :	ccr = h_trans.din;
				endcase
			end
			if(plr>ulr || plr < llr ) err1=1;
			else err1=0;
		end
	endtask

	task read_tx;
		begin
			if(h_trans.nrd==0) begin
				case({h_trans.A1,h_trans.A0})
					2'b00 : din_temp = plr;
					2'b01 :	din_temp = ulr;
					2'b10 : din_temp = llr;
					2'b11 :	din_temp = ccr;
				endcase
				
			end
			else din_temp = 0;
		end
	endtask

	task start_block;
		begin
			start = {start[1],start[0],h_trans.start_in};
          if(start==3'b010 && ccr!=0 && err1 == 0) 
		  begin
		  		$dispaly("inside start");
				start_F=1;
				dir_block;
				count_block;
			end
		end
	endtask

	//static bit [1:0] dir_cond = {plr==ulr,plr==llr};
	task count_block;
		begin
			if(start==2 && start_F==1) begin
				cout1 = plr;
			end
			else begin
              //$display("dir_con = %d,dir1 = %d",dir_cond,dir1);
				//case({dir_cond[1:0]==3,dir1})
				case({plr == ulr , plr == llr ,dir1})
					3'b000 , 3'b010 ,	3'b100: cout1 = cout1-1;
					3'b001 , 3'b011 , 3'b101: cout1 = cout1+1;
					default: cout1 = cout1;
				endcase
			end
			if(cout1==plr) flag_EC=flag_EC-1;
			if(flag_EC==0 && start_F==1) 
				begin
						ec1 = 1;
						start_F=0;
				end
			else ec1=0;
		end
	endtask

	//static bit [1:0] dir_cond = {plr==ulr,plr==llr};
	task dir_block;
		begin
			if(ec1==1) begin dir1=1'bz; end
			else if(start==2 && start_F ==1) begin
				dir1 = (plr == ulr)?((plr == llr)?1'bz:0):1;
				end
			else begin
				case(dir1)
					1'b0: begin
						if(cout1 == llr)
							if(cout1 == ulr) dir1=0;
							else dir1=1;
						else dir1=0;
					end
					1'b1:begin
						if(cout1 == ulr)
							if(cout1 == llr) dir1=0;
							else dir1=0;
						else dir1=1;
					end
				endcase
			end
		end
	endtask

	//static bit [1:0] dir_cond = {plr==ulr,plr==llr};
	task CC;
		begin
			if(ccr==0) flag_EC = 0;
			else if(plr == ulr)
				if(plr == llr) flag_EC = ccr;
				else flag_EC = ccr+1;
			else
				if(plr == llr) flag_EC = ccr+1;
				else flag_EC = 2*ccr+1;
		end
	endtask


	task run();
		begin
          forever@(h_vintf.cd_monitor) begin
				h_trans = new();
				h_trans.A0 = h_vintf.cd_monitor.A0;
				h_trans.A1 = h_vintf.cd_monitor.A1;
				h_trans.nwr = h_vintf.cd_monitor.nwr;
				h_trans.nrd = h_vintf.cd_monitor.nrd;
				h_trans.start_in = h_vintf.cd_monitor.start_in;
				h_trans.reset = h_vintf.cd_monitor.reset;
				h_trans.ncs = h_vintf.cd_monitor.ncs;
				h_trans.din = h_vintf.cd_monitor.din;

				if(h_trans.ncs==0) begin
					if(h_trans.reset==0) begin
						fork
							if(start_F == 0) begin
							$display("start");
								ec1 =0;
								cout1=0;
								start_block;
                              if(start_F==0)write_tx;
                              if(start_F==0)CC;
							end
							else begin
								fork
									start=0;
									count_block;
									dir_block;
								join
							end
							read_tx;
						join
					end
					else begin
						plr = 0;ulr =8'hff;llr=0;ccr=0;
						start = {start[1],start[0],1'b0};
						start_F =0;
						h_trans.cout = 0;
						h_trans.dir = 1'bz;
						h_trans.err = 0;
						h_trans.ec = 0;
						flag_EC =0;
					end
				end
				else begin
					start = {start[1],start[0],1'b0};
					start_F =0;
					h_trans.cout = 0;
					h_trans.dir = 1'bz;
					h_trans.err = 0;
					h_trans.ec = 0;
				end

				h_trans.cout = cout1;
				h_trans.dir = dir1;
				h_trans.ec = ec1;
				h_trans.err = err1;

				h_mbox.put(h_trans);
			end
		end
	endtask

endclass



