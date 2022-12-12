/*
	6.Write a program without fixed arrays.
		a. Array1 elements should be 10 or between 30 to 40.
		b. Array2, Sum of all elements should be <80.
		c. Array3, should have only 10 elements and the sum of those 10 elements should be >100.
		d. Array4, can have any values but the Array3 and Array4 size should be same.
		e. Array5, can have any values but the n.o of elements of Array5
			 should be equal to n.o of elements in Array1 or Array4.
*/

class class_random;
	randc int Array1[];
	rand int unsigned Array2[];
	rand int unsigned Array3[];
	rand int Array4[];
	rand int Array5[];
	constraint random_data{
			foreach(Array1[i]){
				 Array1[i] inside {10,[30:40]};
			}
			Array1.size()==11;
			Array2.sum() < 80;
			Array2.size() == 10;//*/
			Array3.sum() > 100;
			Array3.size() == 10;//*/
			Array4.size() == 10;
			Array5.size() inside {Array4.size(),Array1.size()};
	}
endclass

module A4_Q6;
	class_random h_cr;
	initial begin
		h_cr = new;
		h_cr.randomize();
		$display("\n==========Array1=========");
		$display("%0p",h_cr.Array1);
		$display("\n==========Array2=========");
		$display("%0p",h_cr.Array2);
		$display("\n==========Array3=========");
		$display("%0p",h_cr.Array3);
		$display("\n==========Array4=========");
		$display("%0p",h_cr.Array4);
		$display("\n==========Array5=========");
		$display("%0p",h_cr.Array5);

		//$display("\t%p",);
	end
endmodule
