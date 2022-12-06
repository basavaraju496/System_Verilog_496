
class input_monitor;    

static bit[7:0]PLR,ULR,CCR,LLR;

static int pulse_counter;

static bit plr_flag,llr_flag,ccr_flag,ulr_flag;

static bit [7:0]previous_cout;


virtual dff_intf h_vintf;    
mailbox h_mbx;                
transaction h_trans;          
function new(virtual dff_intf h_vintf,mailbox h_mbx);
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
			checker;    //calling chceker task
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
						 	 task_start2;
						 	 task_start3;
					join
endtask


//=================================NCS BLOCK======================//
task task_ncs;
				case(h_trans.ncs_in)
				1'b1:	begin //{    ncs==1 case retain previous
									h_trans_cout=previous_cout;
				                 //   PLR=PLR;
				                 //   LLR=LLR;
				                 //   CCR=CCR;
				                //    ULR=ULR;
				                    h_trans.err=previous_err;
				                    dir_checker_out=previous_dir;
				                    ec_checker_out=previous_ec;
				                    h_trans_cout=previous_cout;
					end//}
					default: begin  // save previous
				        h_trans_cout=previous_cout;
				               //     PLR=PLR;
				                 //   LLR=LLR;
				                   // CCR=CCR;
				                   // ULR=ULR;
						//			pulse_counter=pulse_counter;
				          //          h_trans.err=err_checker_out;
				            //        dir_checker_out=dir_checker_out;
				              //      ec_checker_out=ec_checker_out;
				                //    h_trans_cout=previous_cout;
					   	end
										endcase
endtask
//=======================RESET BLOCK ======================//
task task_reset;
begin
forever@(posedge clk)
begin//{
					case(h_trans.reset)
						1'b0:
								begin//{
									case(h_trans.ncs_in)
										1'b0: begin//{
														PLR=0;
														LLR=0;
														CCR=0;
														ULR=8'd255;  
														ec_checker_out=1'b0;  // initiallly zero
														h_trans.err=1'b0;
                                    			        dir_checker_out=1'bz;      
														pulse_counter=0;
														h_trans_cout=8'bz;
														plr_flag=0;
														llr_flag=0;
														ulr_flag=0;
														ccr_flag=0;
												end//}
										default: begin//{
										pulse_counter=pulse_counter;
												end//}
										endcase
									end//}
						default: begin//{  // save 
						pulse_counter=pulse_counter;
									end//}
						endcase
					end//} 1st forever end
end
endtask
//============================================ WRITE ==========================//
task task_write;
begin//{
forever@(posedge clk) begin//{

case({h_trans.ncs_in,h_trans.reset,h_trans.nwr})

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
end//}
endtask

//====================== for reading ===========================//
task task_read;
begin
forever@(posedge clk)
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

end
endtask



					
//===============================ERROR =======================================//					
task task_error;
begin
forever@(posedge clk)
					begin//{

h_trans.err=(PLR<LLR || PLR>ULR)?1:0;
{plr_flag,llr_flag,ccr_flag,ulr_flag}=h_trans.err?0:{plr_flag,llr_flag,ccr_flag,ulr_flag};
					end//}
					end
endtask


//=================================START=================================//

task task_start1;
begin//{
forever@(posedge clk)
begin//{

		case({h_trans.ncs_in,h_trans.reset,h_trans.err})
		4'b010: begin
						if(h_trans.start_in==1)
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
forever@(negedge clk)
begin//{

case({h_trans.ncs_in,h_trans.reset,h_trans.err})
		4'b010: begin

		//$display("inside start 3 pulse =%0d",pulse_counter);
						if(h_trans.start_in==1) begin
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
forever@(negedge h_trans.start_in)
		begin
case({h_trans.ncs_in,h_trans.reset,h_trans.err})
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
								if(h_trans.ncs_in==0  && h_trans.reset==1 &&  h_trans.err==0 && ec_checker_out==0)
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
						
						case({h_trans.ncs_in,h_trans.reset,h_trans.err,ec_checker_out}) 4'b0100: begin//{
							repeat(1)   // to get initial value
								begin
								if(h_trans.ncs_in==0  && h_trans.reset==1 &&  h_trans.err==0 && ec_checker_out==0)
                                  @(posedge clk) begin h_trans_cout=PLR; dir_checker_out=(h_trans_cout<ULR)?1:dir_checker_out; 



end							//	end
end
								repeat(ULR-PLR)  // to count upper limit
									begin
								if(h_trans.ncs_in==0  && h_trans.reset==1 &&  err_checker_out==0 && ec_checker_out==0)

									begin
									@(posedge clk) begin	h_trans_cout=h_trans_cout+1; dir_checker_out=(h_trans_cout<ULR)?1:0; end
									
									end
									end
								repeat(ULR-LLR) // to count upto lower limit
										begin
								if(h_trans.ncs_in==0  && h_trans.reset==1 &&  err_checker_out==0 && ec_checker_out==0)
begin
										
										@(posedge clk) begin h_trans_cout=h_trans_cout-1;	dir_checker_out=(h_trans_cout>LLR)?0:1; end end
										end
								repeat(PLR-LLR) // to count upto preload
										begin 
								if(h_trans.ncs_in==0  && h_trans.reset==1 &&  err_checker_out==0 && ec_checker_out==0)
begin
										
										@(posedge clk) begin h_trans_cout=h_trans_cout+1; dir_checker_out=(h_trans_cout<PLR)?1:1'BZ; end end
										
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


endclass
