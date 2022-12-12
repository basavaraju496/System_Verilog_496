/*
	16. Write a class with name “packet” contaning 10 properties.
  	Write another class with name “small_packet” containing 5 properties.
	While writing the “packet” class, declare a handle for the “small_packet” class(Eg. sp).
	Declare two handles for “packet” class (Eg.pkt1,pkt2). Create object for the handle pkt1.
	Now copy the content of pkt1 to pkt2. (Check whether the pkt1 object’s small packet handle(sp)
	properties are copied to pkt2 object’s small packet handle(sp) or not).
 */

//=================================================//
//=================== CLASS =======================//
//=================================================//
class smallpacket ;
	int tx_addr;
	int rx_addr;

	//================= CONSTRUCTOR ======================//
	function new(int tx_addr,int rx_addr);
		begin
			this.tx_addr = tx_addr;
			this.rx_addr = rx_addr;
		end
	endfunction;//*/

	//================= METHODS ======================//
	//================= DISPLAY ======================//
	function void display();
		begin
		$display("=====================================");
		$display("\tTransmission Address = %d\n\tReceiving Address = %d",tx_addr,rx_addr);
		end
	endfunction

endclass:smallpacket




//=================================================//
//=================== CLASS =======================//
//=================================================//
class packet;
	shortint unsigned data;
	byte unsigned pkt_address;
	bit error;
	bit status;
	smallpacket sp;
	//================== CONSTRUCTION ================//
	function new(int data,int pkt_address,bit error,bit status,int tx_add,int rx_add);
		begin
			this.data=data;
			this.pkt_address=pkt_address;
			this.error=error;
			this.status=status;
			this.sp = new(tx_add,rx_add);
		end
	endfunction;//


	//================= METHODS ======================//
	//================= Display ======================//
	function void display();
		begin
		$display("=================================================");
		$display("\tData = %0b \n\tPacket address = %0d\n\tError = %b\n\tStatus = %b",data,pkt_address,error,status);
		$display("\tTransmission Address = %0d\n\tReceiving Address = %0d",sp.tx_addr,sp.rx_addr);
		end
	endfunction
endclass:packet


//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q16;
	packet pkt1,pkt2;

	initial begin
		pkt1 = new($random(),$random(),$random(),$random(),100,1001);
		pkt2 = new($random(),$random(),$random(),$random(),200,2002);
		$display("================= Pkt 1 Details =================");
		pkt1.display();
		$display("================= Pkt 2 Details =================");
		pkt2.display();
		$display("=============== Address's of objects=============");
		$display("pkt1 address %d",pkt1);
		$display("pkt2 address %d",pkt2);

		pkt2 = new pkt1;
		$display("\n\n================ UPDATED PACKETS ===============");
		$display("================= Pkt 1 Details =================");
		pkt1.display();
		$display("================= Pkt 2 Details =================");
		pkt2.display();
		$display("=============== Address's of objects=============");
		$display("pkt1 address %d",pkt1);
		$display("pkt2 address %d",pkt2);
	end

endmodule

