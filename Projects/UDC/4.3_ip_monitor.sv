
class input_monitor;
	mailbox h_mbox;
	transaction h_trans;
	virtual UDC_intf h_vintf;

static reg [7:0] PLR,LLR,ULR,CCR;


  function new(virtual UDC_intf h_vintf,mailbox h_mbox);
		this.h_mbox = h_mbox;
		this.h_vintf = h_vintf;
	endfunction



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

				task_checker;

				h_mbox.put(h_trans);
				$display("inside the ip monitor  %p",h_trans);

			end
		end
	endtask







task task_checker;
	begin//{
	fork
	 task_ncs;
	// task_reset;
//	 task_write;
//	 task_read;
//	 task_error;
//	 task_ec;
//	 task_start1;
//	 task_start2;
//	 task_start3;
	join
		end//}
		endtask

// =============================chip select =================//

task task_ncs;
if(ncs==0)
begin //{    ncs==1 case retain previous

			task_reset;
		//	task_write;
	 		task_read;
			task_error;
			task_ec;
end
endtask
//=======================RESET BLOCK ======================//
task task_reset;
					if(reset==0)
									begin//{
														PLR=0;
														LLR=0;
														CCR=0;
														ULR=8'd255;  
														plr_flag=0;
														llr_flag=0;
														ulr_flag=0;
														ccr_flag=0;
									end//}
					else
					begin   // reset==1
				               task_write;	
							   task_read;
							   task_error;

					end
end
endtask
//============================================ WRITE ==========================//
task task_write;
if(nwr==0)
			begin//{

					if(a1==0 && a0==0)
									begin
												{plr_flag,PLR}=(plr_flag)? {plr_flag,PLR} : {1'b1,reg_design_din} ; 
									end
					else if(a1==0 && a0==1)
									begin
												{ulr_flag,ULR}=(ulr_flag)? {ulr_flag,ULR} : {1'b1,reg_design_din} ; 
					end
					else if(a1==1 && a0==0)
									begin
												{llr_flag,LLR}=(llr_flag)? {llr_flag,LLR} : {1'b1,reg_design_din} ; 
									end
					else if(a1==1 && a0==1)
							begin
												{ccr_flag,CCR}=(ccr_flag)? {ccr_flag,CCR} : {1'b1,reg_design_din} ; 
					end

			end//}
			else
			begin 
			      
				  
			end

endtask

//====================== for reading ===========================//
task task_read;
begin
		if(a1==0 && a0==0)
		begin
			checker_read=PLR;
		end		
		else if(a1==0 && a0==1)
		begin
			checker_read=ULR;
		end
		else if(a1==1 && a0==0)
		begin
			checker_read=LLR;
		end		
		else if(a1==1 && a0==1)
		begin
			checker_read=CCR;
		end			
		end
		default: begin
		checker_read=8'bz;

		end

end
endtask



					
//===============================ERROR =======================================//					
task task_error;
begin
								if({plr_flag,llr_flag,ccr_flag,ulr_flag}=4'b1111) begin 
																						err_checker_out=(PLR<LLR || PLR>ULR)?1:0;
																						{plr_flag,llr_flag,ccr_flag,ulr_flag}=err_checker_out?0:{plr_flag,llr_flag,ccr_flag,ulr_flag};
																					end
endtask


//=================================START=================================//

task task_start1;
begin//{
begin//{

		case({ncs_in,reset_in,err_checker_out})
		4'b010: begin
						if(start_in==1)
		begin
                        pulse_counter=pulse_counter+1;  // counts the m=number of pulses
		end
		end
		default:begin pulse_counter=pulse_counter;	end
			endcase

end//}
end//}
endtask


task task_start3;
begin//{
begin//{

case({ncs_in,reset_in,err_checker_out})
		4'b010: begin

		//$display("inside start 3 pulse =%0d",pulse_counter);
						if(start_in==1) begin
                        pulse_counter=pulse_counter+1;  // counts the m=number of pulses
						end
		end
		default :begin pulse_counter=pulse_counter;
		end
endcase

end//}
end
endtask

task task_start2;
begin//{
		begin
case({ncs_in,reset_in,err_checker_out})
4'b010: begin
//$display("inside neg of strat pulse count=%0d",pulse_counter);
  if((pulse_counter==1 || pulse_counter==3 || pulse_counter==2 ))
    begin
	if(CCR==0)
begin			
					{plr_flag,ulr_flag,llr_flag,ccr_flag}=0;  // WE CAN WRITE NEW DATA AFTER ENDCYCLE 

end
else
begin
	dir_checker_out=1;
						task_repeat;    // calling counter task to start counting
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)
						task_ec_maker;	// task_ec;						
	end						
end
else
begin
    pulse_counter=0;
end
end

default: begin end

		endcase
		end

end//}
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~EC MAKER ~~~~~~~~~~~~~~~~~~~~`//
task task_ec_maker;
begin
if(ULR==PLR && PLR==LLR) begin
		 ec_checker_out=1; task_ec; end
		else begin
		ec_checker_out=1;
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
repeat(1)
begin//{
if(ec_checker_out==1) begin
{plr_flag,llr_flag,ulr_flag,ccr_flag}=0;
pulse_counter=0;

dir_checker_out=1'bz;

@(posedge clk) ec_checker_out=0;

end

end//}
end//}
endtask

