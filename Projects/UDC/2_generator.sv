
class generator;
	transaction h_trans;    
	mailbox h_mbx;           

		static bit[7:0] temp1_PLR=0,temp_ULR=255,temp_LLR=0,temp_CCR=1;
		static bit [7:0] temp2_PLR;





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
//============================================================================================================//
	task task_write_start_count(input [7:0] plr,ulr,llr,ccr,input [7:0] start);
		begin
			task_write(plr,ulr,llr,ccr);      // calling task to write data

		h_trans = new();
		if(h_trans.randomize());   //gap1
		h_mbx.put(h_trans);	
		h_trans = new();
		if(h_trans.randomize());      // gap2
		h_mbx.put(h_trans);

			task_start_pulse_generator(start);          // task to generate the start pulse

		h_trans = new();
		if(h_trans.randomize());        //gappp1
		h_mbx.put(h_trans);

		end
	endtask

//============================================================================================================//

task task_start_pulse_generator(input [7:0]start);

			for(int i=0;i<start;i++) begin  // START PULSE
				h_trans = new();
				if(h_trans.randomize() with {nwr==1;nrd==1;start_in == 1;});
				h_mbx.put(h_trans);
			end
endtask


//============================================================================================================//

task task_reset;
		h_trans = new();
		if(h_trans.randomize()with {reset==1;});   // RESET once
		h_mbx.put(h_trans);
		

endtask



//============================================================================================================//
task task_read;

		h_trans = new();
		if(h_trans.randomize() with {nrd==0;A1==0;A0==0;});// reading PLR
		h_mbx.put(h_trans);

		h_trans = new();
		if(h_trans.randomize() with {nrd==0;A1==0;A0==1;});// reading  ULR
		h_mbx.put(h_trans);

		h_trans = new();
		if(h_trans.randomize() with {nrd==0;A1==1;A0==0;});// reading LLR
		h_mbx.put(h_trans);



		h_trans = new();
		if(h_trans.randomize() with {nrd==0;A1==1;A0==1;});// reading CCR
		h_mbx.put(h_trans);

endtask

//============================================================================================================//
	task task_write(input [7:0] plrw,ulrw,llrw,ccrw);

		h_trans = new();
		if(h_trans.randomize() with {reset==1;});
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

//============================================================================================================//
task task_basic(input new_ncs,new_nwr,new_nrd,new_reset);
			
		h_trans = new();
		if(h_trans.randomize() with {ncs==new_ncs; nrd==new_nrd; nwr==new_nwr; reset==new_reset;});// reading CCR
		h_mbx.put(h_trans);


		endtask



//============================================================================================================//
	task task_write_random();

		h_trans = new();
		if(h_trans.randomize());//RANDOMISING
		h_mbx.put(h_trans);
		h_trans = new();


		if(h_trans.randomize() with {nwr==0;nrd==1;A1==0;A0==0; din>temp1_PLR; });// LOADING PLR
		h_mbx.put(h_trans);
		temp2_PLR=h_trans.din;   // taking data into temp plr


		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==0;A0==1; din>=temp2_PLR; });  // LOADING ULR
		h_mbx.put(h_trans);
	//	temp_ULR=h_trans.din;   // taking data into temp ulr


		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==1;A0==0; din<=temp2_PLR;});// LOADING LLR
		h_mbx.put(h_trans);
	//	temp_LLR=h_trans.din;   // taking data into temp llr

		h_trans = new();
		if(h_trans.randomize() with {nwr==0;nrd==1;A1==1;A0==1;});// LOADING CCR
		h_mbx.put(h_trans);
		//temp_CCR=h_trans.din;   // taking data into temp ccr



		h_trans = new();
		if(h_trans.randomize());   //gap1
		h_mbx.put(h_trans);	
		h_trans = new();
		if(h_trans.randomize());      // gap2
		h_mbx.put(h_trans);

			task_start_pulse_generator(1);          // task to generate the start pulse

		h_trans = new();
		if(h_trans.randomize());        //gappp1
		h_mbx.put(h_trans);



		
	endtask



endclass


   //   pkt.randomize() with { addr == 8;};
