/*
	Write a class with name “packet” contaning 10 properties.
  	Write another class with name “small_packet” containing 5 properties.
	While writing the “packet” class, declare a handle for the “small_packet” class(Eg. sp).
	Declare two handles for “packet” class (Eg.pkt1,pkt2). Create object for the handle pkt1.
	Now copy the content of pkt1 to pkt2. (Check whether the pkt1 object’s small packet handle(sp)
	properties are copied to pkt2 object’s small packet handle(sp) or not).

	17.For the above code,
	a. Modify the data of pkt1 and the sp(small packet handle). Display the contents of pkt1 and pkt2.
	b. Modify the data of pkt2 and the sp(small packet handle). Display the contents of pkt1 and pkt2.
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

	//================= COPY ========================//
	function smallpacket copy();
		begin
			smallpacket copy;
			copy = new(this.tx_addr,this.rx_addr);
			return copy;
		end
	endfunction

	//================= Modify =======================//
	function void modify(int tx_add,int rx_add);
		begin
			this.tx_addr = tx_add;
			this.rx_addr = rx_add;
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
		$display("\tData = %0d \n\tPacket address = %0d\n\tError = %b\n\tStatus = %b",data,pkt_address,error,status);
		$display("\tTransmission Address = %0d\n\tReceiving Address = %0d",sp.tx_addr,sp.rx_addr);
		$display("\tSmall Packet Address = %0d",sp);
		end
	endfunction

	//================= COPY ========================//
	function packet copy();
		begin
			packet copy;
			copy =  new(this.data,this.pkt_address,this.error,this.status,this.sp.tx_addr,this.sp.rx_addr);
			return copy;
		end
	endfunction

	//================= Modify =======================//
	function void modify(int value,int tx_add,int rx_add);
		begin
			this.data = this.data+value;
			this.sp.modify(tx_add,rx_add);
		end
	endfunction
endclass:packet


//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q17;
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

		pkt2 = pkt1.copy();
		$display("\n\n=============== UPDATED PACKETS =================");
		$display("================= Pkt 1 Details =================");
		pkt1.display();
		$display("================= Pkt 2 Details =================");
		pkt2.display();
		$display("=============== Address's of objects=============");
		$display("pkt1 address %d",pkt1);
		$display("pkt2 address %d",pkt2);

		$display("\n================= MODIFYING DATA ================");
		pkt1.modify(120,150,1555);
		pkt2.modify(20,201,1033);
		$display("================= Pkt 1 Details =================");
		pkt1.display();
		$display("================= Pkt 2 Details =================");
		pkt2.display();

	end

endmodule
