/*
	4. Write a class. Declare two handles. Initialize different values to the properites,
	while constructing the object itself.*/
//=================================================//
//=================== CLASS =======================//
//=================================================//
class employee;
	//================== Declaration ===============//
	string name;
	byte unsigned age;
	shortint unsigned salary;
	string designation;

	//=============== Constructor ==================//
	function new(string name, byte unsigned age,	string designation);
		begin
			this.name = name;
			this.age = age;
			this.designation = designation;
			//deciding salary based on Designation of employee.
			this.salary = (designation === "Manager")? 50000 : (designation === "Employee")? 35000:0;
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
endclass

//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q4;
	//class objects; Manager and employee
	employee Managers[],Employees[];
	string Manager_names[],Employee_names[];//names of Managers and Employees


	initial begin
		Manager_names = '{"DP","Rajender","Murthi"};//Intializing managers
		Employee_names = '{"Rajesh","Anvesh","Amrutha","Sreenidhi","Shilpa"};//Initilizing Employees

		//Creating manager Objects
		foreach(Manager_names[i]) begin
			Managers = new[i+1](Managers);
			Managers[i] = new(Manager_names[i],$urandom_range(40,50),"Manager");
		end

		//Creating Employeee Objects
		foreach(Employee_names[i]) begin
			Employees = new[i+1](Employees);
			Employees[i] = new(Employee_names[i],$urandom_range(20,35),"Employee");
		end

		$display("=================== MANAGERS ====================");
		foreach(Managers[i]) begin
			Managers[i].display();
		end
		$display("=================== EMPLOYEES ===================");
		foreach(Employees[i]) begin
			Employees[i].display();
		end
	end
endmodule
