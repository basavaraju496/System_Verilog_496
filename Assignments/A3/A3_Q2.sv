/*
	2. Write a class with name “student”. Declare 10 “student” handles.
	Initialize the properties(student_name, roll_no, marks, course_name, Pass_Fail) with different values (except the course_name).
	b. Write one function and one task to do the manipulations on properties.
 	For above code declare 1000 student handles.*/

//=================================================//
//=================== CLASS =======================//
//=================================================//
class student;
	//================== Declaration ===============//
	string student_name;
	int unsigned roll_no;
	byte unsigned marks;
	string course_name;
	string Pass_Fail;

	//=============== Constructor ==================//
	function new(string student_name, int unsigned roll_no, byte unsigned marks, string course_name, bit Pass_Fail);
		begin
			this.student_name = student_name;
			this.roll_no = roll_no;
			this.marks = marks;
			this.course_name = course_name;
			this.Pass_Fail = Pass_Fail ? "FAIL":"PASS";
		end
	endfunction

	//================== Methods ===================//
	task display();
		begin
			$display("--------------------------------------");
			$display("Name - %s  Roll no - %0d : Marks - %0d : Course - %s : Status - %s",student_name,roll_no,marks,course_name,Pass_Fail);
		end
	endtask
endclass

//=================================================//
//=================== MODULE ======================//
//=================================================//
module A3_Q2;
	student h_students[];
	string student_names[$];
	string courses[$];
	string name;
	integer h_names_file;
	initial begin
		h_names_file = $fopen("names.txt","r");
		while(!$feof(h_names_file)) begin
			$fgets(name,h_names_file);
			student_names.push_back(name);
		end
		courses = {"ECE","CSE","EEE","ME","CE"};
		foreach(student_names[i]) begin
			h_students = new[i+1](h_students);
			h_students[i] = new(student_names[i],i+1,$urandom_range(50,100),courses[$urandom_range(0,4)],$urandom_range(0,1));
		end
		$display("===========STUDENT DETAILS==============");
		foreach(h_students[i]) begin
			h_students[i].display();
		end
	end

endmodule
