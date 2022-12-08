
class input_monitor;    

static bit[7:0]PLR,ULR,CCR,LLR;

static bit plr_flag,llr_flag,ccr_flag,ulr_flag;   // to prevent overloading of adata

static reg downflag,upflag,preloadflag;
static bit [7:0]previous_cout;

static bit start_flag;

bit [7:0]checker_read;


virtual dff_intf h_vintf;    
mailbox h_mbx;                
transaction h_trans;          
function new(virtual UDC_intf h_vintf,mailbox h_mbx);
	this.h_vintf = h_vintf;
	this.h_mbx = h_mbx;
endfunction

task run();
	begin
		forever
		begin
			@(h_vintf.cb_monitor)        // @ posedge clk  
			h_trans = new();                   
			//======taking ips from vintf===================//
			h_trans.ncs = h_vintf.cb_monitor.ncs; 
			h_trans.nrd = h_vintf.cb_monitor.nrd; 
			h_trans.nwr = h_vintf.cb_monitor.nwr; 
			h_trans.A0 = h_vintf.cb_monitor.A0; 
			h_trans.A1 = h_vintf.cb_monitor.A1; 
			h_trans.start_in = h_vintf.cb_monitor.start_in; 
			h_trans.reset = h_vintf.cb_monitor.reset; 
			h_trans.din = h_vintf.cb_monitor.din;
//===========giving to checker for getting ops==============//
			task_checker;    //calling chceker task
//===========keep op in the mbx2 ==========================//
			h_mbx.put(h_trans);                         // putting data into the mailbox

			previous_cout=h_trans.cout;                     // storing cout
			previous_ec=h_trans.ec;                     // storing cout
			previous_err=h_trans.err;                     // storing cout
			previous_dir=h_trans.dir;                     // storing cout

			$display("inside ip monitor(CHECKER) trans= %p",h_trans);
		end
	end	
endtask


		
task task_checker;
					fork
						 	 task_ncs;
						 	 task_reset;
						 	 task_write;
						 	 task_read;
						 	 task_error;
						 	 task_ec;
						 	 task_start1;
					join
endtask


//=================================NCS BLOCK======================//
task task_ncs;
begin//{
				case(h_trans.ncs_in)
				1'b1:	
						begin //{    ncs==1 case retain previous
									h_trans_cout=previous_cout;
				       		         h_trans.err=previous_err;
				                    h_trans.dir=previous_dir;
				                    h_trans.ec=previous_ec;
					end//}

					default: begin  //  do sth in other tasks
					end
										endcase
end	//}									
endtask
//=======================RESET BLOCK ======================//
task task_reset;
begin//{
					case(h_trans.reset)
						1'b0:
								begin//{
									case(h_trans.ncs_in)
									1'b0: begin//{   // ncs=0 rst=0
														PLR=0;
														LLR=0;
														CCR=0;
														ULR=8'd255;  
														h_trans.ec=1'b0;  // initiallly zero
														h_trans.err=1'b0;
                                    			        h_trans.dir=1'bz;      
														pulse_counter=0;
														h_trans_cout=8'bz;
														plr_flag=0;
														llr_flag=0;
														ulr_flag=0;
														ccr_flag=0;
												end//}
										default: begin//{

												end//}
										endcase
									end//}
						default: begin//{  // save 
									end//}
						endcase
					end//} 1st forever end
endtask
//============================================ WRITE ==========================//
task task_write;
begin//{
			case({h_trans.ncs_in,h_trans.reset,h_trans.nwr}
							3'b010:begin
															if(h_trans.A1==0 && h_trans.A2==0)
																	begin
																				{plr_flag,PLR}=(plr_flag)? {plr_flag,PLR} : {1'b1,h_trans.din} ; 
																	end
															else if(h_trans.A1==0 && h_trans.A2==1)
																	begin
																				{ulr_flag,ULR}=(ulr_flag)? {ulr_flag,ULR} : {1'b1,h_trans.din} ; 
															end
															else if(h_trans.A1==1 && h_trans.A2==0)
																	begin
																				{llr_flag,LLR}=(llr_flag)? {llr_flag,LLR} : {1'b1,h_trans.din} ; 
															end
															else if(h_trans.A1==1 && h_trans.A2==1)
																	begin
																				{ccr_flag,CCR}=(ccr_flag)? {ccr_flag,CCR} : {1'b1,h_trans.din} ; 
															end
													end
											default: begin end

						endcase
end//}

endtask

//====================== for reading ===========================//
task task_read;
		begin//{
				case({h_trans.ncs_in,h_trans.reset,h_trans.nwr,h_trans.nrd_in})
						4'b0110 : begin
										if(h_trans.A1==0 && h_trans.A2==0)
										begin
											checker_read=PLR;
										end		
										else if(h_trans.A1==0 && h_trans.A2==1)
										begin
											checker_read=ULR;
										end
										else if(h_trans.A1==1 && h_trans.A2==0)
										begin
											checker_read=LLR;
										end		
										else if(h_trans.A1==1 && h_trans.A2==1)
										begin
											checker_read=CCR;
										end			
										end
										default: begin
										checker_read=8'bz;

										end
				endcase
					end//}

endtask



					
//===============================ERROR =======================================//					
task task_error;
begin
					begin//{

								h_trans.err=(PLR<LLR || PLR>ULR)?1:0;
								{plr_flag,llr_flag,ccr_flag,ulr_flag}=h_trans.err?0:{plr_flag,llr_flag,ccr_flag,ulr_flag}; //giving option to give new data
					end//}
//					end
endtask
										


//=======================START BLOCK=======================//

task start_block();
static real ontime,offtime;
begin
  if(h_vintf.cb_monitor.start_i==1 )
	begin



		ontime=$realtime;
		//	$display("on--%t",ontime);

		on_flag=on_flag+1;
	end
  if (h_vintf.cb_monitor.start_i==0 && on_flag==1)
	begin
		offtime=$realtime;
	//	$display("off--%t",offtime);

		on_flag=0;
	end
	if(offtime-ontime==2)
	begin
		start_flag=1;
$display("start detector--%t",start_flag);

	end
	if(offtime-ontime>2 || offtime-ontime<2 || (h_trans.ec==1 && start_flag==1))
		begin 
		start_flag=0; 
		cout=PLR;
		end

	if(h_trans.rst==1 || (h_trans.ec==1 && h_trans.start_i==0 ))
		begin
		ontime=0;offtime=0;
		end

end
endtask
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~EC MAKER ~~~~~~~~~~~~~~~~~~~~`//
task task_ec_maker;
begin
				if(ULR==PLR && PLR==LLR) 
						begin
						 			h_trans.ec=1; task_ec;
						end
						else
					   	begin
									h_trans.ec=1;
									task_ec;
						end
end
endtask
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~COUNTER ~~~~~~~~~~~~~~~~~~~~~~~``//



task task_repeat;
begin//{
		repeat(CCR)    // to repeat CCR times
						begin//{ 
						
						case({ncs_in,reset_in,err_checker_out,ec_checker_out}) 4'b0100: begin//{
							repeat(1)   // to get initial value
								begin
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)
                                  @(posedge clk) begin cout_checker_out=PLR; dir_checker_out=(cout_checker_out<ULR)?1:dir_checker_out; 



end							//	end
end
								repeat(ULR-PLR)  // to count upper limit
									begin
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)

									begin
									@(posedge clk) begin	cout_checker_out=cout_checker_out+1; dir_checker_out=(cout_checker_out<ULR)?1:0; end
									
									end
									end
								repeat(ULR-LLR) // to count upto lower limit
										begin
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)
begin
										
										@(posedge clk) begin cout_checker_out=cout_checker_out-1;	dir_checker_out=(cout_checker_out>LLR)?0:1; end end
										end
								repeat(PLR-LLR) // to count upto preload
										begin 
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)
begin
										
										@(posedge clk) begin cout_checker_out=cout_checker_out+1; dir_checker_out=(cout_checker_out<PLR)?1:1'BZ; end end
										
										end
										
								end//}
								default: begin end
								endcase
								end//}
								
end//}


endtask

















//~~~~~~~~~~~~~~~~~~~~~~~~~~end cycle block ~~~~~~~~~~`//
task task_ec;
begin//{
		//repeat(1)
			//	begin//{
								if(h_trans.ec==1) 
									begin

										{plr_flag,llr_flag,ulr_flag,ccr_flag}=0;
										h_trans.dir=1'bz;	
										h_trans.ec=0;						
									end
				
			//	end//}
end//}
endtask


endclass
