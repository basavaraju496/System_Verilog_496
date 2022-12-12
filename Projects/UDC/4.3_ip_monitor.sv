
class input_monitor;
	mailbox h_mbox;
	transaction h_trans;
	virtual UDC_intf h_vintf;

static bit [7:0] PLR,LLR,ULR,CCR,checker_read,temp_count;
static bit start_flag,temp_dir;

static int on_flag;
static real ontime,offtime;

static bit llr_flag,ulr_flag,ccr_flag,plr_flag;

static int q1[$];  // for storing count
static int q2[$];  // for storing direction





  function new(virtual UDC_intf h_vintf,mailbox h_mbox);
		this.h_mbox = h_mbox;
		this.h_vintf = h_vintf;
	endfunction



	task run();
				
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

				task_checker;   // calling checker task
				h_trans.din = (h_trans.nwr==1)?((h_trans.nrd==1)? 8'bz:checker_read):h_trans.din;
				h_mbox.put(h_trans);
		//		$display("after procseccing the ip monitor  %p",h_trans);

			end
	endtask







task task_checker;
					 task_ncs;
endtask

// =============================chip select =================//

task task_ncs;
					if(h_trans.ncs==0)
										begin   
												task_reset;
										end
endtask
//=======================RESET BLOCK ======================//
task task_reset;
					if(h_trans.reset==1)
									begin//{
														PLR=0;
														LLR=0;
														CCR=0;
														ULR=8'd255;  
														plr_flag=0;
														llr_flag=0;
														ulr_flag=0;
														ccr_flag=0;
														start_flag=0;
														$display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
														$display("\t \t \t\t\t\t RESET   \t\t\t\t\t\t\t\t\t\t");
														$display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
									end//}
					else
					begin   //    ncs=0 and reset=1 case
				               task_write;   // writing 
	 							task_read;  //reading 
								task_start;  // start pulse detection
					end
endtask
//============================================ WRITE ==========================//
task task_write;
				if(h_trans.nwr==0)
							begin//{
									if(h_trans.A1==0 && h_trans.A0==0)
													begin
																if(plr_flag==0)
																		begin
																			PLR=h_trans.din;// plr is loaded here
																			plr_flag=1;  // making plr_flag==1 inorder to prevent overriding of data 
																		end
													end
									else if(h_trans.A1==0 && h_trans.A0==1)
													begin
																if(ulr_flag==0)
																		begin
																			ULR=h_trans.din;
																			ulr_flag=1;
																		end
									end
									else if(h_trans.A1==1 && h_trans.A0==0)
													begin
																if(llr_flag==0)
																		begin
																			LLR=h_trans.din;
																			llr_flag=1;
																		end
													end
									else if(h_trans.A1==1 && h_trans.A0==1)
											begin
																if(ccr_flag==0)
																		begin
																			CCR=h_trans.din;
																			ccr_flag=1;
																		end
									end
							end//}
endtask

//====================== for reading ===========================//
task task_read;
				if(h_trans.nrd==0)
									begin//{
											if(h_trans.A1==0 && h_trans.A0==0)
											begin
												checker_read=PLR;
											end		
											else if(h_trans.A1==0 && h_trans.A0==1)
											begin
												checker_read=ULR;
											end
											else if(h_trans.A1==1 && h_trans.A0==0)
											begin
												checker_read=LLR;
											end		
											else if(h_trans.A1==1 && h_trans.A0==1)
											begin
												checker_read=CCR;
											end			
											else begin
											checker_read=8'bz;
											end
				end//}
endtask

//=================================START=================================//

task task_start;
				if({plr_flag,llr_flag,ccr_flag,ulr_flag}==4'b1111 && start_flag!=1)
					begin//{
							  if(h_trans.start_in==1 && on_flag==0)
								begin//{
									ontime=$realtime; // it will store the on time
									on_flag=on_flag+1;
								end//}
							 else if (h_trans.start_in==0 && on_flag==1)
												begin//{
													offtime=$realtime;
													$display($time,"offtime=%f",offtime);
													on_flag=0;
														if(offtime-ontime==`CLK_PERIOD)
								     										begin//{
																			start_flag=1;
																			$display("________________________________________________________________________________________________________________________\n");
																			$display($time,"----------------------------------off-on=%f start flag==1-----------------------------------------",offtime-ontime);
																			$display($time,"----------------------------------PLR=%0d ULR=%0d LLR=%0d CCR=%0d---------------------------------",PLR,ULR,LLR,CCR);  
																			$display("________________________________________________________________________________________________________________________");
																			ontime=0;
																	     	offtime=0;
																			task_error;      // calling error block after start flag==1
																			end//}
														else 
																		begin //{
																					start_flag=0;
																					ontime=0;
																	     			offtime=0;

																	   	end//}
																		end//}
					end//}
			else begin//{
							task_starter;
				 end//}
endtask
//===============================ERROR =======================================//					
task task_error;
if({plr_flag,llr_flag,ccr_flag,ulr_flag}==4'b1111)
	   	begin 
				if((PLR<LLR || PLR>ULR))
						begin
								h_trans.err=1;
								{plr_flag,llr_flag,ccr_flag,ulr_flag}=h_trans.err?0:{plr_flag,llr_flag,ccr_flag,ulr_flag}; // can able to write data once again whenn the error came
								start_flag=0;
						end
				else
			   			begin
								task_counter;
								task_starter;  // not started unitil start flag is 1

						end
		end
endtask


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~COUNTER1 ~~~~~~~~~~~~~~~~~~~~~~~``//

task task_counter;
							repeat(1)  
								begin
																			temp_count=PLR;
																			$display("temp count=%0d",temp_count);
																		   	temp_dir=(temp_count<ULR)?1:temp_dir; 
										   									q1.push_back(temp_count);
																			q2.push_back(temp_dir);

								 end
		repeat(CCR)  
						begin//{ 

								repeat(ULR-PLR) 
												begin
																				temp_count=temp_count+1;
																			   	temp_dir=(temp_count<ULR)?1:0; 
																	   			q1.push_back(temp_count);
																				q2.push_back(temp_dir);
												end
								repeat(ULR-LLR) 
												begin
																			temp_count=temp_count-1;
																			temp_dir=(temp_count>LLR)?0:1; 
										   									q1.push_back(temp_count);
																			q2.push_back(temp_dir);
												end
								repeat(PLR-LLR) 
	   											begin
														   	temp_count=temp_count+1;
														   	temp_dir=(temp_count<PLR)?1:1'BZ; 
													   		q1.push_back(temp_count);
															q2.push_back(temp_dir);
												 end
								end//}
$display("q1=%p\nq1.size=%0d",q1,q1.size);
$display("q2=%p\nq2.size=%0d",q2,q2.size);

endtask
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~COUNTER2 ~~~~~~~~~~~~~~~~~~~~~~~``//
/*
task task_counter;
		repeat(CCR) begin  //{
							repeat(1)  
								begin//{
																			temp_count=PLR;
																		   	temp_dir=(temp_count<ULR)?1:temp_dir; 
										   									q1.push_back(temp_count);
																			q2.push_back(temp_dir);

								 end//}
								repeat(ULR-PLR) 
												begin//{
																				temp_count=temp_count+1;
																			   	temp_dir=(temp_count<ULR)?1:0; 
																	   			q1.push_back(temp_count);
																				q2.push_back(temp_dir);
												end//}
								repeat(ULR-LLR) 
												begin//{
																			temp_count=temp_count-1;
																			temp_dir=(temp_count>LLR)?0:1; 
										   									q1.push_back(temp_count);
																			q2.push_back(temp_dir);
												end//}
								repeat(PLR-LLR) 
	   											begin//{
														   	temp_count=temp_count+1;
														   	temp_dir=(temp_count<PLR)?1:1'BZ; 
													   		q1.push_back(temp_count);
															q2.push_back(temp_dir);
												 end//}
								end//}
//$display("q1=%p\nq1.size=%0d",q1,q1.size);
//$display("q2=%p\nq2.size=%0d",q2,q2.size);

endtask
*/
//===================================starter===================================//
task task_starter;
				if(start_flag==1)
						begin
								h_trans.cout=q1.pop_front;
								h_trans.dir=q2.pop_front;
//$display("q1=%p\nq1.size=%0d",q1,q1.size);
//$display("q2=%p\nq2.size=%0d",q2,q2.size);
								if(q1.size()==0 &&  q2.size()==0)  
	 																 begin 
															  				 task_ec_maker;
																			 $display("_--_--_--_--_--_--_--_----_------_-----_---_--END COUNT----_--_----_----_---_----_---_---_---_---_--_---");
																			 $display("_--_--_--_--_--_--_--_----_------_-----_---_--END COUNT----_--_----_----_---_----_---_---_---_---_--_---");
																			 $display("_--_--_--_--_--_--_--_----_------_-----_---_--END COUNT----_--_----_----_---_----_---_---_---_---_--_---");
																	  end	
						end
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~EC MAKER ~~~~~~~~~~~~~~~~~~~~//
task task_ec_maker;
				h_trans.ec=1;
				{plr_flag,llr_flag,ulr_flag,ccr_flag}=0;
				start_flag=0;
endtask







endclass
