/*
	19. Write a base class with 4 properties and also have a derived class. In the base class,
	a. restrict one property to access only inside that class.
	b. other property to acess inside base and derived classes
	c. other property should be accessible inside base classs, derived class and initial block.
	d. Display the content of class.
 */



//=================================================//
//=================== CLASS =======================//
//=================================================//
class packet;
	shortint unsigned data;
	local byte unsigned pkt_address=123;
	bit error;
	protected bit status = 1;

	//================== CONSTRUCTION ================//
	function new(int data,bit error);
		begin
			this.data=data;
			this.error=error;
		end
	endfunction;//


	//================= METHODS ======================//
	//================= Display ======================//
	function void display();
		begin
		$display("=================================================");
		$display("\tData = %0b \n\tPacket address = %0d\n\tError = %b\n\tStatus = %b",data,pkt_address,error,status);
		end
	endfunction
endclass:packet


//=================================================//
//=================== CLASS =======================//
//=================================================//
class smallpacket extends packet ;
	int tx_addr;
	int rx_addr;

	//================= CONSTRUCTOR ======================//
	function new(int data,bit error,int tx_addr,int rx_addr);
		begin
			super.new(data,error);
			super.status = 1;
			this.tx_addr = tx_addr;
			this.rx_addr = rx_addr;
		end
	endfunction;//*/

	//================= METHODS ======================//
	//================= DISPLAY ======================//
	function void display();
		begin
		$display("=====================================");
		$display("\tData = %0b \n\t\n\tError = %b\n\tStatus =%b",data/*,pkt_address*/,error,status);
		$display("\tTransmission Address = %0d\n\tReceiving Address = %0d",tx_addr,rx_addr);
		end
	endfunction

endclass:smallpacket

//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q19;
	smallpacket pkt1,pkt2;
	packet p1;
	initial begin
		p1 = new($random,0);
		p1.display();
		pkt1 = new($random(),0,101,1001);
		pkt2 = new($random(),1,102,2001);
		$display("================= Pkt 1 Details =================");
		pkt1.display();
		$display("================= Pkt 2 Details =================");
		pkt2.display();

		//$display("%d",pkt2.pkt_address);
		//$display("%d",pkt2.status);
		//$display("%d",p1.pkt_address);
		//$display("%d",p1.status);
		//$display("%0d",pkt2.tx_addr);
		//$display("%0d",pkt2.rx_addr);
		//$display("%d",pkt2.data);
		//$display("%d",pkt2.error);
	end

endmodule

