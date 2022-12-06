//===================================ip monitor ====================//
class input_monitor;
//---------------------properties-------------------------//

mailbox h_mbx_2;

transaction ht;

static int count;

virtual mux_intf h_vintf;

// get data from intf
//---------------------constructor-------------------------//

function new(virtual mux_intf h_vintf,mailbox incoming_mbx);
				this.h_vintf=h_vintf;
					h_mbx_2=incoming_mbx;
endfunction

//-----------------------method--------------------------//

task take_ip_do_checker;
				forever begin 
						@(h_vintf.cb_monitor) // take ips @ pos edge clk
							ht=new();
							// take ips from intf and then give it to trans
							
							ht.data_in=h_vintf.cb_monitor.data_in;   // takin data_in
							ht.selection_in=h_vintf.cb_monitor.selection_in;   // taking the selection_in
							count++;
						//	$display("----------------------------------3---------------------------- ");
						//	$display("%0d time got data in checker ",count);
							task_checker;
							h_mbx_2.put(ht);
						//	$display($time,"inside ip monitor = %p  ",ht);
				end

endtask
//-----------------------checker method--------------------------//

task task_checker;
//begin
//forever@(posedge clk)

//begin
	//check_mux_out=data_in_tb[selection_in_tb];    // mux virtual op in check 
	case(ht.selection_in)
	3'b000: begin ht.mux_out=ht.data_in[0]; end 
	3'b001: begin ht.mux_out=ht.data_in[1]; end 
	3'b010: begin ht.mux_out=ht.data_in[2]; end 
	3'b011: begin ht.mux_out=ht.data_in[3]; end 
	3'b100: begin ht.mux_out=ht.data_in[4]; end 
	3'b101: begin ht.mux_out=ht.data_in[5]; end 
	3'b110: begin ht.mux_out=ht.data_in[6]; end 
	3'b111: begin ht.mux_out=ht.data_in[7]; end 
	default : begin ht.mux_out=8'bz; end

	endcase
//end
//end
endtask



endclass



