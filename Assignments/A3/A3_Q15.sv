/*
	15.
	a. Write a class with 10 properties.
	b. Take two handles pkt1 and pkt2.
	c. Create the object for pkt1.
	d. Initialize the values to pkt1 properties.
	e.Copy the content of pkt1 to pkt2
	f. Change the pkt1 properties values and display pkt1, pkt2 conten
 */
//=================================================//
//=================== CLASS =======================//
//=================================================//
class class1;
	string processor;
	string camera;
	string battery;
	int ram;
	int storage;
	string charging_type;
	string expandable;
	string screen;
	string network;
	string sim_slots;

	//================== CONSTRUCTION ================//
	function new(string processor,string camera,	string battery,int ram,int storage,	string charging_type,string expandable,string screen,	string network,string sim_slots);
		begin
			this.processor = processor;
			this.camera = camera;
			this.battery = battery;
			this.ram = ram;
			this.storage = storage;
			this.charging_type = charging_type;
			this.expandable = expandable;
			this.screen = screen;
			this.network = network;
			this.sim_slots = sim_slots;
		end
	endfunction;


	//================= METHODS ======================//
	//================= Display ======================//
	function void display();
		begin
		$display("=====================================");
		$display(" Processor = %s \n Camera = %s \n Battery = %s \n RAM = %0dGB \n Storage = %0dGB \n Charging Type = %s \n Expandable = %s \n Screen = %s \n Network = %0d \n Sim Slots = %s",processor,camera,battery,ram,storage,charging_type,expandable,screen,network,sim_slots);
		end
	endfunction
endclass:class1


//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q15;
	class1 Nokia ;
	class1 Samsung ;
	initial begin
		Samsung = new("Mediatek 6","48 mp","4500 mah",8,128,"Type - C","YES upto 512GB","LED","4G","one");
		$display("=============== SAMSUNG ===========");
		Samsung.display();
		Nokia = Samsung;
		$display("==== NOKIA with SAMSUNG features===========");
		Nokia.display();
		Samsung = new("Snapdragon 788","64 mp","5000 mah",16,256,"Type - C","YES upto 1TB","AMOLED","5G","Two");
		$display("=========== SAMSUNG v2 ===========");
		Samsung.display();
	end
endmodule
