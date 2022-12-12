/*9.
a. Take an array which should store the student names with respect to total marks
STUDENT_NAME
MARKS
Sai 90
Paul 70
Rao 79
Krish 75
Raone 95
b. After 10 time units check the name Krish is existed or not. If not then only store it as an element
in the arrray otherwise modify the exisited element value by +10.
c. In the above array, find out the student name who got marks below 80.*/


module A2_Q9;
/*	typedef struct{
			  string names;
			  int marks;
	} student;
	student array[5];
	initial begin
		array[0] = '{"Sai",90};
		array[1] = '{"Paul",70};
		array[2] = '{"Rao",79};
		array[3] = '{"Krish",75};
		array[4] = '{"Raone",95};
		$display("%p",array);
	end//*/

	int students[string];
	string name;
	initial begin
		students["Sai"] = 90;
		students["Paul"] = 70;
		students["Rao"] = 79;
		students["Krish"] = 75;
		students["Raone"] = 95;
		$display("\n\nOriginal data\n\t%p",students);
		name = "Basava";
		if(students.exists(name)) begin
			$display("%s: Name exists",name);
			students[name]+=10;
			$display("\t%s:%0d",name,students[name]);
		end
		else begin
			$display("%s: Name not exists",name);
			students[name] = 0;
		end
		$display("Updated data\n\t%p",students);
		$display("The students who got marks less than 80:");
		foreach(students[i]) begin
			if(students[i]<80) $display("\t%s",i);
		end
	end
endmodule
