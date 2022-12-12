/*
	5.
	a. Write a class with name “class1” containing 10 properties and mention a display method(function)
	which displays all the properties.
	b.Write another class with name “class2” which should have above 10 properties and extra 2 other properties.
	c. Create an object for above class “class2” and print the content.*/
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

	function void display();
		begin
		$display("=====================================");
		$display(" Processor = %s \n Camera = %s \n Battery = %s \n RAM = %0dGB \n Storage = %0dGB \n Charging Type = %s \n Expandable = %s \n Screen = %s \n Network = %0d \n Sim Slots = %s",processor,camera,battery,ram,storage,charging_type,expandable,screen,network,sim_slots);
		end
	endfunction
endclass:class1

class class2 extends class1;
	string model;
	string resolution;
	function void display();
		begin
		$display("=====================================");
		$display(" MODEL = %s \n Resolution = %s \n Processor = %s \n Camera = %s \n Battery = %s \n RAM = %0dGB \n Storage = %0dGB \n Charging Type = %s \n Expandable = %s \n Screen = %s \n Network = %0d \n Sim Slots = %s",model,resolution,processor,camera,battery,ram,storage,charging_type,expandable,screen,network,sim_slots);
		end
	endfunction
endclass:class2
//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q9;
	class1 Android = new();
	class2 Samsung = new();

	initial begin
		Android.processor = "Snapdragon 788";
		Android.camera = "64 mp";
		Android.battery = "5000 mah";
		Android.ram = 16;
		Android.storage = 256;
		Android.charging_type = "Type - C";
		Android.expandable = "YES upto 1TB";
		Android.screen = "AMOLED";
		Android.network = "5G";
		Android.sim_slots = "Two";
		Android.display();
		Samsung.processor = "Mediatek 6";
		Samsung.camera = "14 mp";
		Samsung.battery = "6000 mah";
		Samsung.ram = 8;
		Samsung.storage = 256;
		Samsung.charging_type = "Type - C";
		Samsung.expandable = "YES upto 512GB";
		Samsung.screen = "LED";
		Samsung.network = "4G";
		Samsung.sim_slots = "One";
		Samsung.model = "Z25";
		Samsung.resolution = "4K";
		Samsung.display();
	end

endmodule
