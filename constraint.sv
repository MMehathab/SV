//1) write constraint such that even locations in an array should contain odd numbers and odd locations in the array should contain even numbers,array size should
//be randomized to 10.
/*
class packet ;
	rand bit[3:0] arr[];
	
	constraint size{arr.size == 10;}
	constraint c1{foreach(arr[i])
						{
							if(i%2 == 0)
								arr[i] % 2 == 1;
							else 
								arr[i] % 2 != 1;}}
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize)
			$display("%0p",p_h.arr);
		end
endmodule 	
*/


/*Write a constraint without an inside function to generate random values 
within the range of 34 to 43? */
/*
class packet; 
	rand bit [8:0] val;  
	constraint c1_range { val > 34; }  
	constraint c2_range { val < 43; }  
endclass 
module constr_inside; 
initial  
	begin 
		packet pkt;  
		pkt = new();  
		repeat (10) 
			begin  
				pkt.randomize();   
				$display("\t VALUE = %0d", pkt.val);  
			end 
	end 
endmodule 
*/


/*There are two constraints applied to same variable ‘A’. One will generate 
the value within the range of [25:50] and another expression say variable 
value should be greater than 40. What should be the value generated, and 
what is the reason? */

/*
class packet; 
	rand bit [8:0] val; 
	constraint c1_range { val inside {[25:50]}; } 
	constraint c2 { val > 40;} 
endclass
 
module constr_inside; 
initial 
	begin 
		packet pkt; 
			pkt = new(); 
			repeat(3) 
				begin 
					pkt.randomize();  
					$display("\t VALUE = %0d",pkt.val); 
				end 
	end 
endmodule 
*/


//2 write a constraint such that arr of any size should contain number of "1" equal to the half size of the array
/*
class packet;
	rand bit[3:0] arr[];
	rand bit[3:0] n;
	
	constraint size{arr.size == n;}
	constraint c2{foreach(arr[i])
					arr[i] inside {0,1};
				(arr.sum with (int'(item == 1))) == n/2 ;}
	
	
	function void post_randomize();
		foreach(arr[i])
			$write("%0d ",arr[i]);
		$display("");
		$display("no of ones = %0d",arr.sum with (int'(item == 1)));
		$display("%0d",arr.size);
		endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 	
*/


// sum of row must be 15

/*class matrix;
	rand int mat[3][3];
	constraint c1{foreach (mat[i,j])
			mat[i][j] inside {[0:9]};}
	constraint c2{foreach (mat[i])
			mat[i].sum()==15;}

	//		or 
	//constraint c2{foreach (mat[i,j])
	//		mat[i][0]+mat[i][1]+mat[i][2]==15;}

			
endclass

module test;
  matrix m1;
  int i, j;

  initial 
  begin
    m1 = new();
    assert(m1.randomize())

    $display("Matrix and Row Sums:");

    for (i = 0; i < 3; i++) 
    	begin
      		for (j = 0; j < 3; j++)
        	$write("%0d ", m1.mat[i][j]);
      		$display(" \n Row sum = %0d", m1.mat[i].sum());
    	end
  end

endmodule*/


/*Generate a 5×5 matrix such that:
All rows have the same sum, All columns have the same sum, Both diagonals have the same sum*/
/*
class packet;

  rand int a[5][5];
  rand int S;

  constraint range_c {
    foreach(a[i,j])
      a[i][j] inside {[1:9]};}

  constraint row_c {
    foreach(a[i])
  //    a[i][0] + a[i][1] + a[i][2] + a[i][3] + a[i][4] == S;}
	a[i].sum()==S;}

  constraint col_c {
//    foreach(a[j])
    //  a[0][j] + a[1][j] + a[2][j] + a[3][j] + a[4][j] == S;}
//	a[j].sum()==S;}
	foreach(a[0][j])
     a.sum() with (int'(item[j])) == S;}

	constraint diagonal_c {
    	 a[0][0] + a[1][1] + a[2][2] + a[3][3] + a[4][4] == S;
	a[0][4] + a[1][3] + a[2][2] + a[3][1] + a[4][0] == S; }


  function void post_randomize();

    $display("\nGenerated Matrix\n");

    for(int i=0;i<5;i++) 
	begin
      	for(int j=0;j<5;j++)
        $write("%0p ", a[i][j]);
      	$display("");
    end

    $display("\nCommon Sum = %0d", S);

  endfunction

endclass

packet p;

module test;	
	initial
		begin
			p=new();
			assert(p.randomize());
		end
endmodule
*/


// generate values for the packet length greater than 200 using overriding
/*
class packet;
        rand int pktlen;
        constraint cp{soft pktlen inside{[100:200]};}
endclass

class chpacket extends packet;
        constraint ch{pktlen>200;}
endclass

module test;
chpacket c1;
initial
  begin
        c1=new;
        repeat(10)
        assert(c1.randomize());
        $display("packet length=%0p",c1.pktlen);
  end
endmodule
*/


//3)write a constraint to create a 5X5 matrix in that every element should be unique, do not use unique keyword
/*
class packet;
	rand bit[5:0] a[5][5];
	
	constraint c1{foreach (a[i,j])
					{
						foreach(a[m,n])
							{
								if(i != m && j != n)
									a[i][j] != a[m][n];
								}
								}}
	
	
	function void post_randomize();
			foreach(a[i])
			begin 
				foreach(a[j])
					begin 
						$write("%0d  ",a[i][j]);
					end
				$display("");
			end
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 
*/



/*Write a constraint with array size 5 to 10 values & the array values should be in ascending/descending order
 without using sort method & post randomization*/

/*class dyn;
	rand bit [7:0] arr[];
	int temp;
	int j;
	constraint c1 {arr.size inside {[5:10]};}
	constraint c2 {foreach(arr[i])
      			if(i < arr.size-1)
        			//arr[i] <= arr[i+1]; }   ascending order
			     	arr[i]>=arr[i+1];}   	// descending order
endclass

dyn d1;

module test;
	initial
		begin
			d1=new();
			assert(d1.randomize());
			$display("size of array=%0d",d1.arr.size);
			$display("elements=%0p",d1);
		end
endmodule
*/

/*write a constraint for the above rand variable such that  
it should have 12 number of 1's non consecutively*/ 

/*class trans;  
	rand bit[31:0]a; 
	constraint c1 {$countones(a)==12;}
	constraint c2 { foreach(a[i])
			if(i>1)
		//	(a[i]==0 || a[i-1]==0);}
			!(a[i]==1 && a[i-1]==1);}

endclass 

trans t1;

module test;
	initial
		begin
			t1=new;
			assert(t1.randomize());
			$display("values %0b",t1.a);
		end
endmodule
*/


/*ascending and descending order*/

/*class ad;
	rand bit [4:0] arr[];
	bit order;
	constraint c1 {arr.size==10;}
	constraint c2 {foreach(arr[i])
			{ if(i>0)
			{	if (order==1)
				arr[i]>arr[i-1];
				else
				arr[i]<arr[i-1];}}}

endclass

ad a1;

module test;
initial
	begin
		a1=new();
		a1.order=1;
		assert(a1.randomize());
		$display("1st randomization value=%0p",a1);
		a1.order=0;
		assert(a1.randomize());
		$display("2nd randomization value=%0p",a1);
	end
endmodule
*/

//4)write a constraint for 5X5 matrix in that diagonal elements should be in divisible of 5 other elements should be equal to 0
/*
class packet;
	rand bit[5:0] a[5][5];
	
    constraint c1 {
        foreach (a[i,j]) {

            if (i == j)
                a[i][j] % 5 == 0;

            else if (i + j == 4)
                a[i][j] % 5 == 0;
				
            else
                a[i][j] == 0;
        }
    }
	
	
	function void post_randomize();
			foreach(a[i])
			begin 
				foreach(a[j])
					begin 
						$write("%0d  ",a[i][j]);
					end
				$display("");
			end
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 
*/
/*
//5)write a constaint to print 9 99 999 9999 99999
class packet;
        rand int arr[5];
        constraint packet_c {arr[0]==9;
                                foreach(arr[i])
                                if(i>0)
                                arr[i]==arr[i-1]*10 +9;}
endclass

module review2;
packet p1;
initial
 begin
        p1=new;
        assert(p1.randomize());
        $display("pattern : %0p",p1);
 end
endmodule     
*/



// diagonal elements should be greater than non diagonal elements

/*class matrix;
  rand int mat[3][3];

  constraint c_non_diag {foreach (mat[i,j])
				
      			if (i != j)
        			mat[i][j] inside {[1:12]};
        		else
        			mat[i][j] inside {[13:20]};}
				

  endclass

matrix m1;

module test;
int i,j;
initial
  begin
  	m1=new;
  	assert(m1.randomize());
  	
  	for(i=0;i<3;i=i+1)
  	begin
  		for(j=0;j<3;j=j+1)
  		$write("%0d ",m1.mat[i][j]);
  		$display("\n");
  	end
  end
endmodule*/


// write a constraint to generate 3*3 matrix where the diagonals are equal


/*class diagonal;
	parameter N=3;	
	rand bit [3:0] mat[N][N];
	constraint c1 {foreach(mat[i,j])
				//	if(i>0 && j>0)
						if(i==j || i+j==2)
							mat[i][j]==mat[0][0];}
endclass
	
diagonal d1;
	
module test;
	initial
		begin
			d1=new;
			assert(d1.randomize());
		
		
		foreach(d1.mat[i])
			begin
				foreach(d1.mat[j])
					begin
						$write("%0d ",d1.mat[i][j]);
					end
				$display("");
			end
		end
endmodule*/

//array of 10 pairs ([A,B]), where  Aand B are integers between 1-50. each pair must be unique.
// A must be always greater than B . Atleast 3 values should have B as an odd number.
// The sum of all A values should be between 200 and 350.

/*class pairs;
	rand int A[10],B[10];
	constraint c1 {foreach(A[i])
			{	A[i] inside {[1:50]};
				B[i] inside {[1:50]};

				A[i]>B[i];
					}}

			

	constraint c3 { unique{A};
			unique{B};
			A.sum() inside {[200:350]};
			B.sum() with (int'(item%2==1)) >=3;}
		
function void post_randomize();
	$display("A value =%0p",A);
	$display("B value=%0p",B);
	$display("A sum=%0p",A.sum);
endfunction

endclass

pairs p1;

module test;
initial
	begin
		p1=new;
		assert(p1.randomize());
	end
endmodule*/


// Write a piece of code to declare three dynamic arrays to hold array1 and array 2 are of 6 bit value and array3 is of 16 bit value 
//& define the constraints for the following 
//a) The size of all the dynamic arrays should be same and between 10& 20 
//b) Each element in the third array should be the product of the corresponding elements of the 1st and 2nd array 
//c) The sum of all the even elements of the third array should be equal to 100 and
// sum of all the odd elements of the third array should be equal to 100.


/*class dyn ;
	rand bit[5:0] arr1[],arr2[];						
	rand bit [15:0] arr3[];
	constraint c1 {arr2.size == arr1.size ;
			arr3.size == arr1.size;}
	constraint c2 {arr1.size inside {[10:20]};}
			
	constraint c3 {foreach(arr3[i])
			arr3[i]==arr1[i] * arr2[i];}

	constraint c4 {	arr3.sum with ((item%2==0)*item)==100;
				arr3.sum with ((item%2==1)*item)==100;}

	constraint c5 {foreach(arr1[i])
			arr1[i]!=0;}

	constraint c6 {foreach(arr2[i])
			arr2[i]!=0;}
	
	constraint c7 {foreach(arr3[i])
			arr3[i]!=0;}


function void post_randomize();
	$display("size of arr1= [%0d]",arr1.size());
	$display("size of arr2=%0d",arr2.size());
	$display("size of arr3=%0d",arr3.size());

	$display("elements of arr1= {%0p}",arr1);	
	$display("elements of arr2= {%0p}",arr2);
	$display("elements of arr3= {%0p}",arr3);

	$display("sum of even numbers of arr3=%0d",arr3.sum with ((item%2==0)*item));
	
	$display("sum of odd numbers of arr3=%0d",arr3.sum with ((item%2==1) *item));

endfunction
endclass

dyn d1;

module test;
	initial
		begin
			d1=new;
			assert(d1.randomize());
	//	$display("d1=%0p",d1);
		end
endmodule*/
	

/*Randomize an array data[8] of structs, where each struct contains a[7:0], b[7:0], and c[7:0], such that: 
If a is a even number, then b must be a multiple of a.If a is divisible by 3, then c must be divisible by 5.
The sum of a + b + c for all structs must be between 800 and 1000, and the sum of a for all structs must be divisible by 7.
 If b is greater than 50, then c must be less than 50.*/

/*class abc;
	typedef struct {rand bit[7:0]a;rand bit[7:0]b;rand bit[7:0]c;} data;
	rand data s1[8];

	constraint c1 {foreach(s1[i])
			{  if(s1[i].a%2==0)
				{s1[i].b % s1[i].a==0;}
			   if(s1[i].a%3==0)
				{s1[i].c%5==0;}
			   if(s1[i].b>50)
				{s1[i].c<50;}  }}

	constraint c2 { (s1.sum with (int'(item.a)+int'(item.b)+int'(item.c))) inside {[800:1000]};
			(s1.sum with(int'(item.a)))%7==0;}
endclass

abc a1;

module test;
	initial
		begin
			a1=new;
			assert(a1.randomize());
			$display("values = [%0p]",a1);
		end
endmodule
*/	

// constraint for febonacci series

/*class febo;
	rand int a[10];
	constraint range{foreach(a[i]) a[i] inside{[0:100]};}
	constraint c1{a[0]==0;a[1]==1;}
	constraint c2{foreach(a[i])
			 if(i>1)
				a[i]==a[i-1]+a[i-2];}
				
endclass

febo f1;

module test;
initial
  begin
	 f1=new;
	 assert(f1.randomize);
	 $display("series=%0p",f1.a);
  end
  
 endmodule
			
*/


/*write a snippet of code to randomize an 8-bit dynamic array with the following 
constraints.           
The size of an array should be in between 10 to 20. 
The sum of any three consecutive elements of an array should be an even number*/


/*class dyn;
	rand bit [7:0] arr[];
	
	constraint c1 {arr.size inside {[10:20]};}
constraint c3 {foreach(arr[i])
			arr[i] inside {[0:20]};} 
	constraint c2 {foreach(arr[i])
				if(i>=2)
					(arr[i]+arr[i-1]+arr[i-2])%2==0;}
					
endclass

dyn d1;

module test;
initial
	begin
		d1=new;
		assert(d1.randomize());
		$display("values=%0p",d1);
	end	
//	endmodule
*/


/* Randomize an Array with Dependent Constraints ;Randomize an array data[8] of 8-bit values (bit [7:0]) such that:
a) If an element is a prime number, the next element must be even. 
b) The sum of all elements must be between 80 and 100.
c) The sum of elements at even indices must be divisible by 5.
d) No two adjacent elements can be the same.*/

/*
class array;
  rand bit [7:0] data[];
  constraint c0 { data.size==10;}
  constraint c1 { foreach (data[i])
      {
      data[i]!=0;
      if(i<9)
      {
      if( data[i]%2==1)

      (data[i+1]%2==0); }
      }
      }
  constraint c2 { foreach (data[i])
      (data.sum inside {[80:100]});}
  constraint c3 { foreach (data[i])    
      if(i %2==0)
      (data.sum() with ( (item.index % 2 == 0) ? item : 0 )) % 5 == 0;}
  constraint c4 { foreach (data[i])
      if(i<data.size-1)    
      data[i]!=data[i+1];}

endclass
array a;
module test;
initial
  begin
    a=new;
    a.randomize; 
    $display("value of elements %0p",a.data);
  end
endmodule
*/

/*
//6write a constraint to generate unique numbers in an array without using unique keyword,array size should be randomized to 10
class packet;
	rand bit[3:0] a[];
	
	constraint size{a.size == 10;}
	
	constraint c1{foreach (a[i])
					{
						foreach(a[j])
							{
								if(i != j)
									a[i] != a[j];
								}
								}}
	
	
	function void post_randomize();
			foreach(a[i])
				$write("%0d  ",a[i]);
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 
*/


/*
Randomize a 32-bit signal such that if the most significant byte is a multiple of 5, then the least significant byte must be a multiple of 3, and if MSB is divisible by 2, then the middle byte i.e, [15:8] must be a prime number greater than 10, while ensuring that the sum of x[23:16] and x[7:0] is equal to the sum of x[31:24] and x[15:8].*/


/*class test;
    rand bit [31:0] x;
constraint aa{if(x[31:24] % 5 ==0) x[7:0] % 3 ==0;}
constraint abc{if (x[31:24]%2==0)
        x[15:8]%2==1 && x[15:8] >10;
        x[15:8]+x[31:24] == x[23:16] + x[7:0];}

function void post_randomize();
    $display(" x[31:24] is %0d",x[31:24]);
    $display(" x[25:16] is %0d",x[25:16]);
    $display(" x[15:8] is %0d",x[15:8]);
    $display(" x[7:0] is %0d",x[7:0]);
    $display("sum of the each x[15:8]+x[31:24] & x[23:16] + x[7:0] is %0d %0d",x[15:8]+x[31:24],x[23:16] + x[7:0]);
endfunction
endclass

module top;
    test h1;
    initial
    begin
    h1=new;
    h1.randomize;
    end
endmodule*/


//7 write a constraint to print 1 0 1 0 1 0 1 0 1 0
/*
class packet;
	rand bit[3:0] a[];
	
	constraint size{a.size == 10;}
	
	constraint c1{foreach (a[i])
					{
						if(i%2 == 0)
							a[i] == 1;
						else 
							a[i] == 0;}}
	
	
	function void post_randomize();
			foreach(a[i])
				$write("%0d  ",a[i]);
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 
*/

//8 write a constraiant for creating an arr in that first half of the elements should  
//be in desending order and other half should be in asending order

/*class packet;
	rand bit[3:0] arr[];
	
	constraint size{arr.size == 10;}
	

    constraint c_order {

        foreach (arr[i]) {
            if (i <= arr.size/2)
                if (i > 0)
                    arr[i] < arr[i-1];
        }

        foreach (arr[i]) {
            if (i > arr.size/2)
                                   arr[i] > arr[i-1];
        }
    }
									
	function void post_randomize();
		$display("size of array=%0p",arr.size);
			foreach(arr[i])
				$write("%0d  ",arr[i]);
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule
*/


//write a constraint for a sq matrix and the rotate counter clock wise 90 digree;

/*class packet;
		parameter n = 5;
        rand bit [3:0] a[n][n];
		     bit [3:0] b[n][n];
			 
	constraint size{foreach (a[i,j])
				a[i][j] inside{[0:9]};}
	
				
				  
	function void post_randomize();
	$display("---------------------------original array---------------------------");
		foreach(a[i])
			begin 
				foreach(a[j])
					begin 
						$write("%0d ",a[i][j]);
					end
				$display("");
			end
	//	$display("");
		
		for(int i = 0 ; i <n ; i++)
			begin 
				for(int j = 0 ;j <n ; j++)
					begin 
						b[i][j] = a[j][(n-1)-i];  // for 90 degree anti clockwise
						//  b[i][j]=a[(n-1)-j][i];   // for 90 degree clockwise
					end
			end
		
	$display("---------------------------90 degree  rotated array---------------------------");
		foreach(a[i])
			begin 
				foreach(a[j])
					begin 


						$write("%0d ",b[i][j]);
					end
				$display("");
			end
	//	$display("");
			
	endfunction
endclass

packet q_h;

module top;
	initial 
		begin
			q_h = new();  
			assert(q_h.randomize);
		end
endmodule
*/

//9) write a constraint to find 20 unique numbers between 99 and 100; 
/*
class packet;
	rand real arr[20];
	
	constraint size{foreach(arr[i])
				arr[i] inside {[99.0:100.0]};}
	

									
	function void post_randomize();
			foreach(arr[i])	
				$display("%0f ",arr[i]);
			
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule
*/
//11)write a constraint for a 32bit variable in which the every 5th bit should only be 0 and rest of the bits should be 1 

/*class packet;
	rand bit [0:31] arr;
		
		constraint c1{foreach(arr[i])
						{
								if(i%5 == 0)
									arr[i] == 0;
								else 
									arr[i] == 1;
								}
							}
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize());
			$display("%0b",p_h.arr);
		end
endmodule */	

//12 write a constraint for sorting the elements in an array without using sorting method, array size should be randomized to 20
/*
class packet;
	rand bit [7:0] arr[];
		
		constraint size{arr.size == 20;}
		constraint c1  {foreach(arr[i])
							{
								if(i<19)
								arr[i]<arr[i+1];
							}
						}
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize());
			$display("%0p",p_h.arr);
		end
endmodule 
*/
//13)a sv code contains 4 variables namely a,b,c,d each 4bits , write a constraint 
//such that the in one randomization any 1 variable only should get randomized
/*
class packet;
	rand bit [3:0] a;
	rand bit [3:0] b;
	rand bit [3:0] c;
	rand bit [3:0] d;
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			p_h.a.rand_mode(0);
			p_h.b.rand_mode(0);
			p_h.c.rand_mode(0);
			p_h.d.rand_mode(0);
			
			randcase
				100 : p_h.a.rand_mode(1);
				200 : p_h.b.rand_mode(1);
				300 : p_h.c.rand_mode(1);
				400 : p_h.d.rand_mode(1);
			endcase
			
			assert(p_h.randomize());
			$display("a = %0d , b = %0d , c = %0d , d = %0d",p_h.a,p_h.b,p_h.c,p_h.d);
		end
endmodule 
*/

//14)write a constraint to print 5 -10 15 -20 25 -30 
/*
class packet;
	rand int a[];
	constraint size{a.size == 20;}
	constraint c1{foreach(a[i])
						{
							if(i<a.size)
								{
									if(i%2 == 0)
										a[i] == (i+1) * 5;
									else 
										a[i] == (i+1) * -5;
								}
						}
					}
							
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize());
			$display("a = %0p",p_h.a);
		end
endmodule 
*/

/*
//15)
//write a constraint to print 0 1 0 0 1 1 0 0 0 1 1 1 0 0 0 0 1 1 1 1
class packet;
	rand bit val;
	bit toggle = 0;
	int flag  = 0;
	int count  = 1;
	
	constraint c_val {val == toggle;}

				
	
	function void post_randomize;
		flag ++;
		if(flag == count)
			begin
				$display("before toggle - %0b",toggle);
				toggle = ~toggle;
				$display("after toggle - %0b",toggle);
				if(toggle == 0)
					count++;
				flag = 0;
			end
	endfunction
	
endclass

packet p_h;

module top;
	initial 
		begin
			p_h = new();
			for(int i = 0; i <3; i++)
				begin
					assert(p_h.randomize);
					$display("Iteration %0d - %0b ",i,p_h.val);
					$display("count -   %0d ",p_h.count);
					$display("flag  -   %0d ",p_h.flag);
				end


		end
endmodule 
*/
/* 01 0011 000111 00001111

/*class packet;
	rand bit arr[20];
	int z=0;
	
	function void post_randomize();
		for(int i=1;i<=4;i++)
			begin	
				for(int j=0;j<i;j++)
					begin
						arr[z]=0;
						z++;
					end
				for(int j=0;j<i;j++)
					begin	
						arr[z]=1;
						z++;
					end
			end
	endfunction
	
endclass

packet p1;

module test;
	initial
		begin	
			p1=new();
			assert(p1.randomize());
			$display("values=%0p",p1);
		end
endmodule*/


///*** OR****//

/*
class packet;
	rand bit arr[];
	int i,j,k=1;
	constraint c1 {arr.size==k;}
	
	function void post_randomize();
			j=0;
			for(i=1;i<=3;i++)
			begin
				repeat(i)
					begin
						arr[j]=0;
						j++;
					end
				repeat(i)
					begin	
						arr[j]=1;
						j++;
					end
			end
		k++;
	endfunction
endclass

packet p1;

module test;
	initial	
		begin
			p1=new();
			repeat(12)
				begin
					assert(p1.randomize());
					$display("values %0p ",p1.arr);
				end
		end
endmodule
*/


//16)
//write a constraint to create a 5X5 matrix in that diagonal elements should containt 1 and rest of the elements should contain 0
/*
class packet;
	rand bit[3:0] arr[5][5];
	constraint c1{foreach(arr[i,j])
					{
						if((i==j) || (i+j == 4))
							arr[i][j] == 1;
						else 
							arr[i][j] == 0;
							}
						}
							
	function void post_randomize;
		foreach(arr[i])
			begin 
				foreach(arr[j])
					$write("%0d ",arr[i][j]);
				$display("");
			end
	endfunction
	
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule
*/


//17) write a constraint for a 128 bit if 1 comes it should contain an adjecent 1 to it and one should not be consecutive more than 2 time 
//	neither i shouldnt be stay single 


/*
class packet;
	rand bit[0:127] arr;
	
    constraint c1 
	{
        foreach(arr[i]) 
			{
			if(i == 0)
				if(arr[i] == 1)
					arr[i+1] == 1;
			
			if(i == 127)
				if(arr[i] == 1)
					arr[i-1] == 1;
			
			
					
            if (i > 0 && i < 127)
				{
					arr[i-1] && arr[i] -> !arr[i+1];
               
					if (arr[i] == 1) 
						{
							(arr[i-1] == 1 || arr[i+1] == 1);
						}
				}
			}
    }
	     
							
	function void post_randomize;
		$display("%0b ",arr);
	endfunction
	
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule
*/

//18. 2 33 222 5555 22222 777777

/*class packet;
	rand int arr[];
	constraint c1{
					arr.size == 10;
				//	arr[0]   == 1;
					foreach(arr[i])
						{
						//	if(i>0)
							//	{
									if(i%2 == 1)
										arr[i] == i+2; //(((10**(i+1) - 1)/9)*2); 
									else	
										arr[i] == 2;  //(((10**(i+1) - 1)/9)*(2+i));
								}
										
						}
                                
				//	}

						
	function void post_randomize();

			//	$write("%0d ",arr[0]);
				foreach(arr[i])
				begin

			//	if(i>0)
				//begin
			//	if(i%2==0)
			//		begin
						repeat(i+1)
						$write("%0d ",arr[i]);
						$display("");
					end
			/*	else
					begin
						repeat(i+1)
						$write("%0d ",arr[i]);
						$display("");
					end
			end*/
	//	end
						
	/*endfunction
					
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule*/

/*
class packet;
	rand int arr;
	int count;
	constraint c1 { if(count%2 == 1)
						arr == 2;
					else if(count%2 == 0)
						arr == count + 1;
						} 
					
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			repeat(8)
				begin 
					p_h.count++;
					repeat(p_h.count)
						begin 
							assert(p_h.randomize());
							$write("%0d",p_h.arr);
						end
					$write(" ");
				end
		end
endmodule
*/

//19) 1 2 333 4 55555 6 7777777

/*class packet;
	rand int arr[];
	constraint c1{
					arr.size == 10;
					arr[0]   == 1;
					foreach(arr[i])
						{
							if(i>0)
								{
									arr[i] == i+1; //(arr[i-1]*10+1);
								}
						}
					}
/*	constraint c2{
					b.size == 10;
					foreach(b[i])
						{
							if(i%2 == 1)
								b[i] == i+1;
							else 
								b[i] == arr[i] * (i+1);
						}
					}*/
						
/*	function void post_randomize();

		$write("%0d ",arr[0]);

		foreach(arr[i])
			begin
				if(i>0)
					begin
						if(i%2==1)
						begin
						$write("%0d ",arr[i]);
					//	$display("");
						$write("\n");
						end
						else
						begin
							repeat(i+1)
							$write("%0d ",arr[i]);
						//	$display("");
							$write("\n");

						end
					end
			end
								
	endfunction
					
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule
*/

/*21) write a prameterized class which should contain an array of 10 values in which the differnce 
between the values should be equal but all the values in the array should be unique. array size should be randomized*/
/*
class packet #(int N = 10);
	randc bit[7:0] arr[];
	
	constraint size{arr.size == N;}
		
	constraint add{foreach(arr[i])
				{
					foreach(arr[j])
						{
							if((j>0) && (j<N-1) )
							arr[j]-arr[j+1] == arr[j-1] - arr[j];
						}
						}
					}
	function void post_randomize();
		$display(" %p",arr);
		$write("difference btw nums - ");
		foreach(arr[i])
			begin 
				if(i < N-1)
					$write(" %0d",arr[i]-arr[i+1]);
			end 
	endfunction
endclass*/

/*******************OR***********/

/*
class packet #(int N = 10);

  rand bit [7:0] arr[];
  rand int s;

  constraint size_c {arr.size() == N;
   // s inside {[5:15]};}

  constraint diff_c {foreach(arr[i])
      			if(i < N-1)
        		arr[i+1] - arr[i] == s;}


function void post_randomize();
		$display(" %p",arr);
		$write("difference btw nums - ");
		foreach(arr[i])
			begin 
				if(i < N-1)
					$write(" %0d",s);
			end 
	endfunction


endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize);
		end
endmodule 						
*/




/*
//Generate random values without using rand keyword...but if u give randomize it should work
class packet ;
	bit[7:0] arr[];
	
endclass

packet p_h;

module top;
	initial 
		begin 
			p_h = new();
			assert(p_h.randomize(arr) with {p_h.arr.size == 10;
											foreach(p_h.arr[i])
												arr[i] inside {[0:50]};})
			$display("%0d",p_h.arr);
		end
endmodule 	
*/


// print odd values in even index and even value in odd index without using any modulous or divide operator
/*class packet;
	rand bit[3:0] arr[];

	constraint c0{arr.size == 10;}
	
	constraint c1{foreach(arr[i])
					{
						if(i[0] == 1'b1)//odd
							{
								arr[i][0] == 1'b0;//even
							}
						else if(i[0] == 1'b0) //even
							{
								arr[i][0] == 1'b1; //odd
							}
						}
					}

						
	function void post_randomize();	
		$write("%0p ",arr);
	endfunction
					
endclass

packet p_h;

module top;
	initial
		begin
			p_h = new();
			assert(p_h.randomize());
		end
endmodule*/


/*Write constraints to generate a n-bit random value (n is even) such that the number of bits 
set is equal to number of bits that are zero.Should not use pre/post randomize methods, only constraints allowed.*/
/*class packet;
	parameter N = 15;
	randc reg [N:0] a;
	
	constraint count{$countones(a) == (N+1)/2;} 

endclass

packet p_h;

module top;
	initial 
		begin 
			int one,zero;
			p_h = new();
			p_h.randomize();
			
			foreach(p_h.a[i])
				begin 
					if(p_h.a[i] == 1'b1)
						one = one+1;
					else if(p_h.a[i] == 1'b0)
						zero = zero +1;
				end
			$display("%d, %b,one = %d,zero = %d",p_h.a,p_h.a,one,zero);
		end
endmodule 
*/


/*
/*write a constraint to generate 5 random numbers in an array 5 times such that each time we randomize
 the elements of the array they should be different from the previous randomized values and the sum of all the elements 
in the array should be double the sum of previous randomized values.*/
/* 
 class packet;

  rand bit [7:0] arr[5];

  bit [7:0] prev_arr[5];
  int prev_sum;

  constraint c {
    foreach(arr[i])
      arr[i] inside {[0:100]};
  }

  function void post_randomize();
    prev_arr = arr;
    prev_sum = arr.sum() with (int'(item));

    $display("Array = %p  Sum = %0d", arr, prev_sum);
  endfunction

endclass


module top;

  packet p;

  initial begin

    p = new();

    // First randomization
    assert(p.randomize() with {arr.sum() with (int'(item)) <= 30;});

    repeat(4) begin

      assert(p.randomize() with {arr.sum() with (int'(item))== p.prev_sum * 2;
						 foreach(arr[i])
        					arr[i] != p.prev_arr[i];});

    end

  end

endmodule
*/


/* Write a constraint to generate the random values 25,27,30,36,40,45 without using set membership*/

/*class cons;
	rand bit [5:0] arr1[];
	constraint c1 {arr1.size()==6;}
	constraint c2 {foreach(arr1[i])
					{	unique{arr1};
						arr1[i]>24 && arr1[i]<46;
						arr1[i]%5==0 || arr1[i]%9==0;
						arr1[i]!=35;}}

	constraint c3 {foreach(arr1[i])
			if(i>0)
				arr1[i]>arr1[i-1];}
	endclass
	
	cons c1;
	
module top;
	initial
		begin
			c1=new();
			assert(c1.randomize());
			$display("values %0p",c1);
		end
endmodule*/
	
	

// pattern 9753186420

/*class pattern;
	rand int arr[];
		constraint c1{arr.size()==10;}
		constraint c2 {foreach(arr[i])
						arr[i] inside {[0:9]};}
		/*constraint c3 {foreach(arr[i])
						{ 
						if(i<5)
							{ arr[i]%2==1;
								if(i<4)
								arr[i]>arr[i+1]	;}
						else {
							 arr[i]%2==0;
								if(i<9)
								arr[i]>arr[i+1];}}}
		constraint c3 {foreach(arr[i])
						{ arr[0]==9;
						arr[5]==8;

						if(i>0 && i<5)
							{ arr[i]==arr[i-1]-2;}
						else if(i>5 && i<9)
								arr[i]==arr[i-1]-2;}}
	
endclass

pattern p1;

module test;
	initial
		begin
			p1=new();
			assert(p1.randomize());
			$display("values=%0p",p1);
		end
		
endmodule*/



/*write constraint for an transistion of an 8 bit value . 
number of toggles should be exactly 5 and 8 bit variable should contain 5 number of 1's*/

/*class toggle;
	rand bit [7:0]a;
	constraint c1{ $countones(a)==5;}
	 constraint c2 {((a[0]^a[1]) + (a[1]^a[2]) +(a[2]^a[3]) +
      			 (a[3]^a[4]) +(a[4]^a[5]) +(a[5]^a[6])+(a[6]^a[7]));}
	
endclass

toggle t1;
module test;
	initial
		begin
			t1=new();
			assert(t1.randomize());
			$display("values %0b",t1.a);
		end
endmodule*/


/* print strings*/

/*class str;
	rand int a[];
	constraint c1{a.size()==5;}
	constraint c1{foreach(a[i])
			a[i] inside {[65:90]};}

endclass
str s1;
module test;
	initial
		begin
			s1=new();
			assert(s1.randomize());
			$display("words  %0c",s1.a);
		end
endmodule*/

/*
class sum;
	rand bit [3:0] a,b;
	rand int c;
	constraint c1 { a+b==5;
			c==10*(a+b);}

endclass

sum s1;

module test;
	initial
		begin
			s1=new();
			assert(s1.randomize());
			$display("values are %0p",s1);
		end
endmodule			
	*/


/*class prime;
	rand bit[8:0]arr[];
	
	constraint c1 {arr.size()==12;
					unique{arr};}
	 constraint c3 {foreach(arr[i])

					{ arr[i] inside {[2:100]};
						if(i>0)
							((arr[i] % 2 != 0) || (arr[i] == 2)) &&
							((arr[i] % 3 != 0) || (arr[i] == 3)) &&
							((arr[i] % 5 != 0) || (arr[i] == 5)) &&
							((arr[i] % 7 != 0) || (arr[i] == 7));			
						else
							arr[i]==2;
					}}
					
		
					
endclass
	
prime p1;

module test;
		initial
			begin
				p1=new();
				assert(p1.randomize());
				$display("prime numbers %0P",p1);
			end
endmodule*/	


/* no adjacent ones */

/*class case1;
	rand bit arr[10];
	constraint c1{foreach(arr[i])
			if(i>0)
				(arr[i]==0 || arr[i-1]==0) ;}	
		
endclass

case1 c1;

module test;
	initial
		begin
			c1=new();
			assert(c1.randomize());
			$display("values %0p",c1);
		end
endmodule*/


/* class no1;
rand bit arr[12];
int z;
constraint c1 { foreach(arr[i])
		{ arr[i] inside {0,1};}}
constraint c2 {
			z == 5;
}
		

  function void post_randomize();
    foreach(arr[i]) begin
      if(arr[i] == 1)
        z = z + 1;

          end
  endfunction

endclass

no1 n1;

module test;
	initial
		begin
			n1=new();
			assert(n1.randomize());
			$display( "values %0p         and value of z=%0d",n1,n1.z);
		end
endmodule*/



/* 0102030405*/

/*class even;
	rand bit[2:0] arr[10];

	constraint c1 {foreach(arr[i])
			{	if(i%2==0)
					arr[i]==0;
				else
					arr[i]==(i+1)/2;}}
			
endclass

even e1;

module test;
	initial
		begin	
			e1=new();
			assert(e1.randomize());
			$display("values of arr=%0p",e1);
		end
endmodule*/



/* values between 100 and 200 shouldnt come*/
/*class cons;
	rand int arr[];
	
	constraint c1 {arr.size() inside {[8:15]};}
	constraint c3{ foreach(arr[i])
			(arr[i] >= 0 && arr[i] <= 99) || (arr[i] >= 201 && arr[i] <= 500);}*/
	
		//**************** OR **********************//
	
	/*constraint c2 {foreach(arr[i])
			!(arr[i] inside {[100:200]});}	

endclass

cons c1;

module test;
	initial
		begin
			c1=new();
			assert(c1.randomize());
			$display("values %0p",c1);
		end
endmodule*/




/* in a 4x4 matrix, each 3x3 match should have only one 1's */
/*
class matrix #(int n=4, int m=3);

  rand int mat[n][n];

	constraint c { foreach(mat[i,j])
				{ if(i%(m)==0 && j%(m)==0)
					mat[i][j]==1;
				  else
					mat[i][j]==0;}}
						
 
 function void display();

    for(int i=0; i<n; i++) begin

      for(int j=0; j<n; j++) begin
       $write("%0d ", mat[i][j]);
      end

      $display("");

    end

  endfunction

endclass


module test;

  matrix  #(.n(7),.m(3)) m1;

  initial begin

    m1 = new();

    assert(m1.randomize());

    m1.display();

  end

endmodule
*/

/***** square numbers*******/

/*class square;
	rand bit [5:0] arr[];
	
	constraint c1 {arr.size()==6;}
	constraint c2 {foreach(arr[i])
			{ arr[i]==(i+1)**2;}}

endclass

square s1;

module test;
	initial
		begin
			s1=new();
			assert(s1.randomize());
			$display("square values=%0p",s1);
		end
endmodule
*/


/************ 1357913579 *********/
/*class odd;

  rand bit [3:0] arr[];

  	constraint c1 {arr.size() == 10;}

	constraint c2{	foreach(arr[i])
			{ arr[0]==1;
				if(i>0)
			{
			if(arr[i-1]==9)
				arr[i]==1;
			else
				arr[i]==arr[i-1]+2;}}}

endclass

odd o1;

module test;
	initial
		begin
			o1=new();
			assert(o1.randomize());
			$display("square values=%0p",o1);
		end
endmodule
*/



/************** consecutive two 1's *************/

/*class two;
	rand bit [7:0]data;
	
	constraint c1 {arr.size()==10;}
	
	/*constraint c2 { foreach(arr[i])
					{ if(i%2==0)
						arr[i]=arr[i+1];}}*/
						
	/*constraint c2 {$countones{data}==2;
					$countones(data & (data<<1))==1;}}
endclass

two t1;

module test;
	initial	
		begin	
			t1=new();
			assert(t1.randomize());
			$display("values %0p",t1);
		end
endmodule*/


/*** array value should contain same value in two different index*********/
/*
class different;
	rand bit [2:0] arr[];

	constraint c1 {arr.size()==10;}


/**** all values will repeat twice *****/
/*	constraint c2{ foreach(arr[i])
			{arr[0]==1;
			if(i>0)
			{ if(arr[i-1]==5)
				arr[i]==1;
			  else
				arr[i]==arr[i-1]+1;}}}  */
 
/*** atleast one value will repeat twice ********/
/*	constraint c2 { foreach(arr[i])
			 foreach(arr[j])
			{ if(i==j)
				arr[j]==arr[i];}}	

endclass

different d1;

module test;
	initial
	begin
		d1=new();
		assert(d1.randomize());
		$display("values %0p", d1);
	end
endmodule
*/


/** there should be only 3 peaks that means.high low high low high low only 3 times**/
/*
 class peak;
	rand int arr[];
	constraint c1 { arr.size==10;}
	constraint c2 { foreach(arr[i])
			{ arr[i] inside {[1:15]};
	
			if(i>1 )
		{
			if(i<6)
		{
			if(i%2==0)
				arr[i]<arr[i-2];
			else
			{
				arr[i]>arr[i-2];
				arr[i]<arr[i-1];
			}}
			else if(i>5)
				arr[i]>arr[i-1];}}}

	constraint c3 { unique{arr};}
//	constraint c5 { (arr.sum with (int'(item.index %2==0)*item)) > (arr.sum with (int'(item.index %2==1)*item));} 
	
	
endclass

peak p1;

module test;
	initial
		begin
			p1=new();
			assert(p1.randomize());
			$display("values %0p",p1);
		end
endmodule 
*/




/* 5 players playing ludo , each player will roll the dice 5 times. write constraint to find winner*/
/*
module tb;

class ludo;

  rand int dice[5][5];

  int sum[5];
  int winner;
  int max_sum;

  constraint c_dice {
    foreach(dice[i,j])
      dice[i][j] inside {[1:6]};
  }

  function void post_randomize();

    // Calculate sum of each player
    foreach(dice[i])
      sum[i] = dice[i].sum();

    // Find winner
    max_sum = sum[0];
    winner  = 0;

    foreach(sum[i])
    begin
      if(sum[i] > max_sum)
      begin
        max_sum = sum[i];
        winner  = i;
      end
    end

    // Display dice values
    foreach(dice[i])
    begin
      $write("Player %0d : ", i+1);
      foreach(dice[i,j])
        $write("%0d ", dice[i][j]);
      $display();
    end

    $display("\nPlayer Sums");
    foreach(sum[i])
      $display("Player %0d Sum = %0d", i+1, sum[i]);

    $display("\nWinner = Player %0d", winner+1);
    $display("Winning Score = %0d", max_sum);

  endfunction

endclass

ludo l;

initial begin

  l = new();

 assert(l.randomize());

end

endmodule
*/
