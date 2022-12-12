/*
	5. Write a program to count how many objects got created for a particular class.*/
//=================================================//
//=================== CLASS =======================//
//=================================================//
class employee;
	//================== Declaration ===============//
	string name;
	byte unsigned age;
	shortint unsigned salary;
	string designation;
	static int count=0;

	//=============== Constructor ==================//
	function new(string name, byte unsigned age,	string designation);
		begin
			this.name = name;
			this.age = age;
			this.designation = designation;
			//deciding salary based on Designation of employee.
			this.salary = 35000;
			this.count = count+1;
		end
	endfunction

	//================== Methods ===================//
	//display() method to display the object details
	function void display();
		begin
			$display(" Name %s : Age %d : Designation %s : Salary : Rs %5d.00",name,age,designation,salary);
			$display("----------------------------------------------------------------");
		end
	endfunction

	//======================= getCount()============//
	function int getCount();
		begin
		//	count = 100;
			return this.count;
		end
	endfunction
endclass

//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q5;
	//class objects; employee
	employee Employees[];
	string Employee_names[];//names of Employees


	initial begin
		Employee_names = '{"Rajesh","Anvesh","Amrutha","Sreenidhi","Shilpa"};//Initilizing Employees

		//Creating Employeee Objects
		foreach(Employee_names[i]) begin
			Employees = new[i+1](Employees);
			Employees[i] = new(Employee_names[i],$urandom_range(20,35),"Employee");
		end

		$display("=================== EMPLOYEES ===================");
		foreach(Employees[i]) begin
			Employees[i].display();
			//$display("%p address %d\n\n",Employees[i],Employees[i]);
		end

		$display("The Objects Created are %0d",Employees[1].getCount());

		/*Employees[1] = new("Vinod",$urandom_range(20,35),"Employee");

		foreach(Employees[i]) begin
			Employees[i].display();
			$display("%p  address %d\n\n",Employees[i],Employees[i]);
		end*/

	end
endmodule
