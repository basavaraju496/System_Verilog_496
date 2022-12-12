/*
	12.
	a. Write a class with name “class1” containing 10 properties and mention a display method(function)
	which displays all the properties.
	b.Write another class with name “class2” which should have above 10 properties and extra 2 other properties.
	c. Create an object for above class “class2” and print the content.
 	For the above program,
	a. In “class1” use constructor to initialize the values to the properties.
	b. In “class2” use constructor to initialize the values to the properties.
	For the above program,
	a.In “class2” define a method name “modify”.
		This “modify” method modifies all the properties with some decremented values.
	b. Display the content of the properties. (Reuse the content to reduce the effort of repeated work.)
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
//=================== CLASS =======================//
//=================================================//
class class2 extends class1;
	string model;
	string resolution;


	//================= CONSTRUCTOR ======================//
	function new(string model,string resolution,string processor,string camera,string battery,int ram,int storage,	string charging_type,string expandable,string screen,	string network,string sim_slots);
		begin
			super.new(processor,camera,battery,ram,storage,charging_type,expandable,screen,network,sim_slots);
			this.model = model;
			this.resolution = resolution;
		end
	endfunction

	//================= METHODS ======================//
	//================= DISPLAY ======================//
	function void display();
		begin
		$display("=====================================");
		$display(" MODEL = %s \n Resolution = %s \n Processor = %s \n Camera = %s \n Battery = %s \n RAM = %0dGB \n Storage = %0dGB \n Charging Type = %s \n Expandable = %s \n Screen = %s \n Network = %0d \n Sim Slots = %s",model,resolution,processor,camera,battery,ram,storage,charging_type,expandable,screen,network,sim_slots);
		end
	endfunction

	//================= Modify ======================//
	function void modify(string battery,int ram,int storage,string expandable);
		begin
			super.battery = battery;
			super.ram = ram;
			super.storage = storage;
			super.expandable=expandable;
		end
	endfunction;
endclass:class2


//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q12;
	class1 Android;
	class2 Samsung;

	initial begin
		//Android = new("Snapdragon 788","64 mp","5000 mah",16,256,"Type - C","YES upto 1TB","AMOLED","5G","Two");
		//Android.display();
		Samsung = new("Z25","4K","Mediatek 6","48 mp","4500 mah",8,128,"Type - C","YES upto 512GB","LED","4G","one");
		Samsung.display();
		$display("===========MODIFIED DEVICE===========");
		Samsung.modify("6000 mah",16,512,"NO");
		Samsung.display();
	end

endmodule
