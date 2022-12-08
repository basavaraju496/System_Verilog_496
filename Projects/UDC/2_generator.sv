
class generator;
	transaction h_trans;    
	mailbox h_mbx;           
	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;   
	endfunction
	task run();
		repeat(1000)   // it tells number of times to randomize
		begin
			h_trans = new();         
			if(h_trans.randomize() with {nwr==0 && nrd==1 && ncs==0 && reset==0 ;} );  
			h_mbx.put(h_trans);      
			$display($time,"generator data is %p",h_trans);  
		end
	endtask
endclass


   //   pkt.randomize() with { addr == 8;};
