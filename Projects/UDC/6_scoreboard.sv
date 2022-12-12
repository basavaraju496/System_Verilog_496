////////////////////////score_board/////////////////////
class scoreboard;

	mailbox h_mbx1,h_mbx2;   // created two h_mbx1,2 for storing the data from the dut and data from the ip monitor(checker)
	transaction h_trans1,h_trans2;   
	function new(mailbox h_mbx1,h_mbx2);
		this.h_mbx1 = h_mbx1;            // checker mbx
		this.h_mbx2 = h_mbx2;            // dut mbx
	endfunction

	task run();
	begin
		forever
		begin
			h_trans1 = new();    // to handle the checker data
			h_trans2 = new();    // to handle dut data
			h_mbx1.get(h_trans1);  // getting daata ffrom checker to trans1
			h_mbx2.get(h_trans2);  //getting data from dut to trans2
			if(h_trans2.nrd==0 && h_trans2.nwr==1) compare_read;
			if(h_trans1.cout === h_trans2.cout) 
			begin
					$display("________________________________________________________________________________________________________________________\n");
					$display($time,"\t\tPASS \n    DUT=%p \n checker=%p ",h_trans2,h_trans1);
					$display("________________________________________________________________________________________________________________________\n"); end
			else
			begin
					$display("________________________________________________________________________________________________________________________\n");
					$display($time,"\t\t\t\t\t\t\t\t\tFAIL \n DUT=%p \n checker=%p ",h_trans2,h_trans1);
					$display("________________________________________________________________________________________________________________________\n"); end
		end
	end
	endtask


task compare_read;
		if(h_trans1.din==h_trans2.din)
				begin
						$display("________________________________________________________________________________________________________________________\n");
						$display("\t \t \t\t\t\t READ PASS   \t\t\t\t\t\t\t\t\t\t");
						$display($time,"----------------------------------data read=%0d---------------------------------",h_trans2.din);  
																			$display("________________________________________________________________________________________________________________________\n");
				end
				else begin
						$display("________________________________________________________________________________________________________________________\n");
						$display("\t \t \t\t\t\t READ Fail   \t\t\t\t\t\t\t\t\t\t");
						$display($time,"----------------------------------data read=%0d---------------------------------",h_trans2.din);  
																			$display("________________________________________________________________________________________________________________________\n");
				end

endtask




endclass
