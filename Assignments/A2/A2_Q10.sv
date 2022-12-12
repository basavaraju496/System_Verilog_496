/*Declare an array with the below indexes and values can be random.
a.indexes 1stloc, 2ndloc, 3rdloc. Print the size of array.
b.indexes 100,200,5,40. Print the size of array*/

module A2_Q10;
	int data[string];//declaring Associate array
	int data_a[string];//declaring Associate array
	int data_b[*];
	initial begin
		data["1stloc"] = $urandom_range(10,100);//addign data into array
		data["2ndloc"] = $urandom_range(10,100);
		data["3rdloc"] = $urandom_range(10,100);
		$display("\nData Available:-\n\t%p",data);
		$display("Total data available = %0d",data.num());
		// inserting new data.
		data[100] = $urandom_range(10,100);
		data[200] = $urandom_range(10,100);
		data[5] = $urandom_range(10,100);
		data[40] = $urandom_range(10,100);
		$display("\nUpdated Data :-\n\t%p",data);
		$display("Total data available = %0d",data.num());

		$display("\nConsidering Two different array's");
		data_a["1stloc"] = $urandom_range(10,100);//addign data into array
		data_a["2ndloc"] = $urandom_range(10,100);
		data_a["3rdloc"] = $urandom_range(10,100);
		$display("Data Available in array a:-\n\t%p",data_a);
		$display("Total data available = %0d",data_a.num());
		// inserting new data.
		data_b[100] = $urandom_range(90,100);
		data_b[200] = $urandom_range(90,100);
		data_b[5] = $urandom_range(90,100);
		data_b[40] = $urandom_range(90,100);
		$display("\nData Available in array b:-\n\t%p",data_b);
		$display("Total data available = %0d",data_b.num());
	end
endmodule
