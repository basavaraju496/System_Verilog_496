///////////////////////////.environment/////////////////////////////
class environment;

	virtual UDC_intf h_vintf;    
	mailbox h_mbx_gen,h_mbx_ipmo,h_mbx_opmo;
	generator h_gen;   
	driver h_driv;         
	input_monitor h_ipmo;  
	output_monitor h_opmo;  
	scoreboard h_scrbd;      

function new(virtual UDC_intf h_vintf);
	this.h_vintf = h_vintf;
	h_mbx_gen = new();  
	h_mbx_ipmo = new(); 
	h_mbx_opmo = new(); 
	h_gen = new(h_mbx_gen);           
	h_driv = new(h_vintf,h_mbx_gen); 
	h_ipmo = new(h_vintf,h_mbx_ipmo); 
	h_opmo = new(h_vintf,h_mbx_opmo);  
	h_scrbd = new(h_mbx_ipmo,h_mbx_opmo); 
endfunction

/*task run();
	fork
		h_gen.run(); 
		h_driv.run();  
		h_ipmo.run();
		h_opmo.run();
		h_scrbd.run();
	join
endtask*/

	task run();
		fork
			begin
				h_gen.run(2,2,2,5,1);//PLR=LLR=ULR
				wait(h_vintf.ec_out == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.run(5,10,2,1,1);//PLR!=LLR!=ULR
				wait(h_vintf.ec_out == 0);
				wait(h_vintf.ec_out == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.run(10,10,5,1,1);//PLR=ULR
				wait(h_vintf.ec_out == 0);
				wait(h_vintf.ec_out == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.run(5,10,5,1,1);//PLR=LLR
				wait(h_vintf.ec_out == 0);
				wait(h_vintf.ec_out == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.run(5,7,3,1,1);//PLR=ULR-2=LLR+2
				wait(h_vintf.ec_out == 0);
				wait(h_vintf.ec_out == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.run(5,6,4,1,1);//PLR=ULR-1=LLR+1
				wait(h_vintf.ec_out == 0);
				wait(h_vintf.ec_out == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.run(5,7,5,1,1);//PLR=LLR=ULR-2
				wait(h_vintf.ec_out == 0);
				wait(h_vintf.ec_out == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.run(7,7,5,1,1);//PLR=ULR=LLR+2
				wait(h_vintf.ec_out == 0);
				wait(h_vintf.ec_out == 1);
				repeat(2)@(h_vintf.cd_monitor);
				h_gen.run(0,255,0,1,2);
			end
		h_driv.run();  
		h_ipmo.run();
		h_opmo.run();
		h_scrbd.run();
		join
	endtask



endclass
