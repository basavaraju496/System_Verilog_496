
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
			if(h_trans.randomize());
			h_mbx.put(h_trans);
			h_trans = new();
			if(h_trans.randomize());
			h_mbx.put(h_trans);
			for(int i=0;i<start;i++) begin
				h_trans = new();
				if(h_trans.randomize() with {nwr==1;nrd==1;start_in == 1;});
				h_mbx.put(h_trans);
			end
			h_trans = new();
			if(h_trans.randomize());
			h_mbx.put(h_trans);
		end
	endtask

	task hg_write(input [7:0] plrw,ulrw,llrw,ccrw);
		h_trans = new();
		if(h_trans.randomize() with {reset==1;});
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize());
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==0;A0==0;din==plrw;});
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==0;A0==1;din==ulrw;});
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==1;A0==0;din==llrw;});
		h_mbx.put(h_trans);
		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==1;A0==1;din==ccrw;});
		h_mbx.put(h_trans);
	endtask


endclass


   //   pkt.randomize() with { addr == 8;};
