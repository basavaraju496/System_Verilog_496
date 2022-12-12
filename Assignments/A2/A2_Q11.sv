/*Take an array with 20 students names and marks.
a.Then delete the students who got marks >90.
b.Find out how many students got marks <=90. Print the students names who got marks
<=90.*/

module A2_Q11;
	int students [string];
	string student_names[$];
	initial begin
		student_names = {"Krishna","Paul","Ravi","Bachi","Naveen","Keerthana","Keerthi","Jyothsna","Sanjana","Nithish","J P","Sree Lekha","Sai","Shreya","Sai Lahari","Bhavani","Lokesh","Anchal","Ujwala","Dheeraj"};
		/*students["Krishna"] = $urandom_range(70,100);
		students["Paul"] = $urandom_range(70,100);
		students["Ravi"] = $urandom_range(70,100);
		students["Bachi"] = $urandom_range(70,100);
		students["Naveen"] = $urandom_range(70,100);
		students["Keerthana"] = $urandom_range(70,100);
		students["Keerthi"] = $urandom_range(70,100);
		students["Jyothsna"] = $urandom_range(70,100);
		students["Sanjana"] = $urandom_range(70,100);
		students["Nithish"] = $urandom_range(70,100);
		students["J P"] = $urandom_range(70,100);
		students["Sree Lekha"] = $urandom_range(70,100);
		students["Sai"] = $urandom_range(70,100);
		students["Shreya"] = $urandom_range(70,100);
		students["Sai Lahari"] = $urandom_range(70,100);
		students["Bhavani"] = $urandom_range(70,100);
		students["Lokesh"] = $urandom_range(70,100);
		students["Anchal"] = $urandom_range(70,100);
		students["Ujwala"] = $urandom_range(70,100);
		students["Dheeraj"] = $urandom_range(70,100);*/
		foreach(student_names[i]) begin
			students[student_names[i]] = $urandom_range(70,100);
		end
		$display("\nStudents ");
		disp;
		$display("Deleting students names who got marks >90");
		foreach(students[i]) begin
			if(students[i]>90) students.delete(i);
		end
		$display("The total number of students who got marks <=90 is %0d,\nand they are",students.num());
		disp;
	end
	task disp;
	begin
		$display("\tName : Marks");
		foreach(students[i]) begin
			$display("\t%s : %0d",i,students[i]);
		end
	end
	endtask

endmodule

