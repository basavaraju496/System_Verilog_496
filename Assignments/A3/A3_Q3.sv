/*
	3. Write a class and initialize the class properties at constructor itself*/

class student;
	string student_name;
	int unsigned roll_no;
	byte unsigned marks;
	string course_name;
	string Pass_Fail;

	function new(string student_name, int unsigned roll_no, byte unsigned marks, string course_name);
		begin
			this.student_name = student_name;
			this.roll_no = roll_no;
			this.marks = marks;
			this.course_name = course_name;
			this.Pass_Fail = (marks<=35) ? "FAIL":"PASS";
		end
	endfunction

	task display();
		begin
			$display("--------------------------------------");
			$display("Name - %s  Roll no - %0d : Marks - %0d : Course - %s : Status - %s",student_name,roll_no,marks,course_name,Pass_Fail);
		end
	endtask
endclass


module A3_Q3;
	student h_students[10];
	string student_names[$];
	string courses[$];
	initial begin
		student_names = {"Krishna","Paul","Ravi","Bachi","Naveen","Keerthana","Keerthi","Jyothsna","Sanjana","Sai Lahari"};
		courses = {"ECE","CSE","EEE","ME","CE"};
		foreach(student_names[i]) begin
			h_students[i] = new(student_names[i],i+1,$urandom_range(0,100),courses[$urandom_range(0,4)]);
		end
		$display("===========STUDENT DETAILS==============");
		foreach(h_students[i]) begin
			h_students[i].display();
		end
	end

endmodule
