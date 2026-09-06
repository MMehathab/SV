


/****** Find maximum and minimum element in a fixed array ********/

/*module test();
	int arr[6]={1,4,7,8,10,5};
	int max;
	int min;
	
	initial
		begin
		max=arr[0];
		min=arr[0];
			foreach(arr[i])
				begin	
					if(arr[i]>max)
						max=arr[i];
					if(arr[i]<min)
						min=arr[i];
				end
		
			$display("max value=%0d",max);
			$display("min value=%0d",min);
		end
endmodule*/

/**** Create a fixed array of 10 integers and print only even numbers ******/

/*module test();
	int arr[10]={1,2,3,4,5,6,7,8,9,10};
	initial	
		begin	
			foreach(arr[i])
				begin
					if(arr[i]%2==0)
						$display("even numbers=%0d",arr[i]);
				end
		end
endmodule*/



/***** Product of elements of dynamic array without array methods *****/

/*module prod();
int da[];
initial
  begin
	da=new[$urandom_range(4,10)];
	foreach(da[i])
	da[i]={$random}%20;
	$display("elements of array=%0p",da);
	da=da.unique();
	$display("unique elements of array=%0p",da);
	for(int i=0;i<$size(da);i++)
		begin
			da[i+1]=da[i]*da[i+1];
			$display("product of each element=%0d",da[i]);
		end
	$display("product of all the elements=%0p",da);

  end
endmodule*/

/****** Resize a dynamic array ******/

/*module resize();
	int da1[];
	int da2[];
	inti da3[];
	
	initial	
		begin	
			da1=new[5];
			foreach(da1[i])
				begin
					da1[i]= $urandom_range(1,15);
				end
			//da1=da1.unique();
			$display("values of dynamic array 1 =[%0p]",da1);
			
			da2=da1;
			$display("values of dynamic array 2 =[%0p]",da2);
			da2=new[10](da1);
			$display("values of dynamic array 2 =[%0p]",da2);

			foreach(da2[i])
				da2[i+5]=$urandom_range(5,30);
			$display("values of dynamic array 2 =[%0p]",da2);
		
			da3=new[15](da2);
			$display("values of dynamic array 3 =[%0p]",da3);

			da3.delete();  			
		end
endmodule*/

/********* dynamic and queue array methods ********/

module test();
	int da1[];
	int da2[];
	int q1[$];
	int q2[$];
	int q3[$];
	int q4[$];
	int result,k;
	
	initial	
		begin	
			da1=new[$urandom_range(5,10)];
			foreach(da1[i])
			da1[i]=$urandom_range(10,60);
			$display("size of da1 array=%0d, value of array da1 =[%0p]",$size(da1),da1);
			da1.unique();
			$display("unique value array da1 =[%0p]",da1);
			da1.sort();
			$display("ascending value of array da1 =[%0p]",da1);
			da1.rsort();
			$display("descending value of array da1 =[%0p]",da1);
			da1.shuffle();
			$display("shuffled  value of array da1 =[%0p]",da1);
			da1.reverse();
			$display("reverse value of array da1 =[%0p]",da1);
			da2=da1;
			$display("values of array da2=[%0p]",da2);

			q1=da1;
			$display("queue array q1=[%0p]",q1);
			q1.insert(6,30);
			$display("queue array size=[%0d],queue array q1=[%0p]",q1.size(),q1);
			q1.sort();
			$display("queue array size=[%0d],queue array q1=[%0p]",q1.size(),q1);
			q1.rsort();
			$display("queue array size=[%0d],queue array q1=[%0p]",q1.size(),q1);
			q2={q1,17};
			$display("queue array size=[%0d],queue array q2=[%0p]",q2.size(),q2);

			q2.push_front(33);
			$display("queue array size=[%0d],queue array q2=[%0p]",q2.size(),q2);
			q2.push_back(55);
			$display("queue array size=[%0d],queue array q2=[%0p]",q2.size(),q2);
			k=q2.pop_front();
			$display("queue array size=[%0d],queue array q2=[%0p],k value=[%0d]",q2.size(),q2,k);
			q3=da1.min();
			$display("queue array size=[%0d],min value of da1=[%0p]",q3.size(),q3);
			q3=da1.max();
			$display("queue array size=[%0d],max value of da1=[%0p]",q3.size(),q3);
			q3=q2.max();
			$display("queue array size=[%0d],max value of q2=[%0p]",q3.size(),q3);

			result=q2.product with((item>30) ? item:1);
			$display("product of q2 value of =[%0p]",result);

			result=da1.sum();
			$display("sum of da1 value of =[%0p]",result);

			result=da1.sum with((item>7)*item);
			$display("sum of da1 value of =[%0p]",result);

			q3=da1.find_first with (item>30);
			$display("queue array size=[%0d],first value greater than 30 of da1=[%0p]",q3.size(),q3);

			q3=da1.find_first_index with (item>55);
			$display("queue array size=[%0d],first index greater than 55 of da1=[%0p]",q3.size(),q3);
		
			q3=da1.find_last with (item>45);
			$display("queue array size=[%0d],last value greater than 45 of da1=[%0p]",q3.size(),q3);

			q3=da1.find_last_index with (item>45);
			$display("queue array size=[%0d],last index greater than 45 of da1=[%0p]",q3.size(),q3);

			for(int i=0;i<9;i++)
				q4[i]=q2.pop_back();
				$display("size of q2=[%0d],values of q4=[%0p]",$size(q2),q4);

			q4={q1,q3};
			$display("elememts of q4=[%0p]",q4);

			q4.delete();
			$display("values in q4=%0p",q4);

			da2.delete();
			$display("values in da2=[%0p]",da2);
			
			
		end
endmodule


/*Write a System Verilog to calculate the difference between the average of all the even 
numbers and average of all odd numbers in a dynamic array which contains some even 
and odd numbers at random locations (Do it with & without using array methods) */

// without array methods//

/*module test;
	 int arr[];
	 int temp=0;int temp2=0;
	 int even_num=0; int even_count=0;real even_avg=0;
	int odd_num=0;int odd_count=0; real odd_avg=0;
	 real diff=0;
	
	initial
		begin	
			arr=new[10];
			foreach(arr[i])
				arr[i]=$urandom_range(1,30);
			$display("elements of arr=%0p",arr);
			
			foreach(arr[i])
				begin
					if(arr[i]%2==0)
						begin	
							even_num=temp+arr[i];
							temp=even_num;
							even_count++;
						end
					else if(arr[i]%2==1)
					begin	
						odd_num=temp2+arr[i];
						temp2=odd_num;
						odd_count++;
					end
				end
				
				$display("even sum=%0d",even_num);
				$display("even count=%0d",even_count);
				
				$display("odd sum=%0d",odd_num);
				$display("odd count=%0d",odd_count);
				
			even_avg=real'(even_num)/even_count;
			odd_avg=real'(odd_num)/odd_count;
		
			$display("even average=%0.2f",even_avg);
			$display("odd average=%0.2f",odd_avg);

			diff=odd_avg-even_avg;
			$display("difference=%0.2f",diff);
		end
endmodule*/


// with array methods//

/*module test;
	 int arr[];
	 int temp=0;int temp2=0;
	 real even_num=0; int even_count=0;real even_avg=0;
	real odd_num=0;int odd_count=0; real odd_avg=0;
	 real diff=0;

	initial
		begin	
			arr=new[10];
			foreach(arr[i])
				arr[i]=$urandom_range(1,30);
			$display("elements of arr=%0p",arr);
			
			even_num=arr.sum with(int'(item%2==0)*item);
			even_count=arr.sum with(int'(item%2==0));
			
			odd_num=arr.sum with(int'(item%2==1)*item);
			odd_count=arr.sum with(int'(item%2==1));
			
			$display("even sum=%0d",even_num);
			$display("even count=%0d",even_count);
				
			$display("odd sum=%0d",odd_num);
			$display("odd sum=%0d",odd_count);
				
			even_avg=even_num/even_count;
			odd_avg=odd_num/odd_count;
			
			$display("even average=%0.2f",even_avg);
			$display("odd average=%0.2f",odd_avg);
			 
			diff= odd_avg-even_avg;
			$display("difference=%0.2f",diff);
		end
endmodule*/

