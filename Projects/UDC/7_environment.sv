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

task run();
	fork
		h_gen.run(); 
		h_driv.run();  
		h_ipmo.run();
		h_opmo.run();
		h_scrbd.run();
	join
endtask

endclass
