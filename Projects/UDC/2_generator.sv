
class generator;
	transaction h_trans;    
	mailbox h_mbx;           
	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;   
	endfunction
/*	task run();
		repeat(500)   // it tells number of times to randomize
		begin
			h_trans = new();         
			if(h_trans.randomize() with { nrd==1 && ncs==0 && reset==0 ;} );  
			h_mbx.put(h_trans);      
			$display($time,"generator data is %p",h_trans);  
		end
	endtask*/

	task run(input [7:0] plr,ulr,llr,ccr,input [7:0] start);
		begin
			hg_write(plr,ulr,llr,ccr);
			
			h_trans = new();
			if(h_trans.randomize());//RANDOMIZE 1
			h_mbx.put(h_trans);
			h_trans = new();
			if(h_trans.randomize());    // RANDOMIZE 2
			h_mbx.put(h_trans);
		
			task_start_pulse_generator(start);

			h_trans = new();
			if(h_trans.randomize());// RANDOMIZE AFTER START PULSE
			h_mbx.put(h_trans);
		end
	endtask

	task hg_write(input [7:0] plrw,ulrw,llrw,ccrw);
		h_trans = new();
		if(h_trans.randomize());   // RESETTING 
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize());//RANDOMISING
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==0;A0==0;din==plrw;});// LOAADING PLR
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==0;A0==1;din==ulrw;});  // LOADING ULR
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==1;A0==0;din==llrw;});// LOADING LLR
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==1;A0==1;din==ccrw;});// LOADING CCR
		h_mbx.put(h_trans);
	endtask

task task_start_pulse_generator(input [7:0]start);
			for(int i=0;i<start;i++) begin  // START PULSE
				h_trans = new();
				if(h_trans.randomize() with {nwr==1;nrd==1;start_in == 1;});
				h_mbx.put(h_trans);
			end
endtask



endclass


   //   pkt.randomize() with { addr == 8;};
