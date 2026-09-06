

/*module test();

class trans;
	static int i;
	static function void add();
		int j;
		i++;
		j++;
		$display("i=%0d,j=%0d",i,j);
	endfunction
endclass

trans t[3];
	initial
		begin
			foreach(t[i])
				begin	
				//	t[i]=new();  // not mandatory because this is static function
					t[i].add();
				end
		end
endmodule*/



/*module test();

class trans;
	static int i;
	 function static void add();
		int j;
		i++;
		j++;
		$display("i=%0d,j=%0d",i,j);
	endfunction
endclass

trans t[3];
	initial
		begin
			foreach(t[i])
				begin	
				//	t[i]=new();   // not mandatory because i is static
					t[i].add();
				end
		end
endmodule*/

module test();

class trans;
	 int i;
	 function static void add();
		int j;
		i++;
		j++;
		$display("i=%0d,j=%0d",i,j);
	endfunction
endclass

trans t[3];
	initial
		begin
			foreach(t[i])
				begin	
					t[i]=new();   //  mandatory because i is non static
					t[i].add();
				end
		end
endmodule



 /*  class packet; 
  static int ID = 0; 
  int aid = 0; 
  function new(); 
   ID++; 
   aid++; 
   $display("ID = %0d \t aid = %0d",ID,aid); 
  endfunction 
endclass : packet 
class generator; 
        task start(); 
   packet pkt_h = new(); 
   $display("%0p",pkt_h); 
  endtask : start 
endclass : generator 
 
module sp_test(); 
generator gen[4]; 
initial 
  begin 
   foreach (gen[i]) 
    begin 
      gen[i] = new; 
     $display(gen[i]); 
    end  
   gen[0].start();    
   gen[1].start();    
   repeat(10) 
    gen[2].start();   
   gen[3].start();  
  end 
endmodule*/ 

/*class packet #(size = 32); 
static bit [size-1:0] a;        //Each parameterized class specialization has its own static variable
bit[size-1:0] b; 
function new(); 
a++; b++; 
endfunction 
endclass : packet 
packet #(8)p1;  
packet p2; 
packet #(8)p3; 
packet #(32)p4; 
module top(); 
initial begin 
p1 = new() ; 
p2 = new() ; 
p3 = new(); 
p4 = new() ; 
$display ("p1.a = %0d, p1.b = %0d", p1.a, p1.b); 
$display ("p2.a = %0d, p2.b = %0d", p2.a, p2.b); 
$display ("p3.a = %0d, p3.b = %0d", p3.a, p3.b); 
$display ("p4.a = %0d, p4.b = %0d", p4.a, p4.b); 
end 
endmodule: top  */

/*class main_class;
	static int a;
	int b;
	static function void stat_fun();
	static int i;
	a++;
	i++;
	$display("the values of a = %0d || i = %0d ",a,i);
	endfunction
	function static void fun_stat();
	int j;
	b++;
	j++;
	$display("the values of b = %0d || j = %0d ",b,j);
	endfunction
endclass
module top();
main_class h,h1,h2,h3,h4;
initial
begin
h=new();
h.stat_fun();
h.fun_stat();
h1=new();
h1.stat_fun();
h1.fun_stat();
h2=new();
h2.stat_fun();
h2.fun_stat();
h3=new();
h3.stat_fun();
h3.fun_stat();
h4=new();
h4.stat_fun();
h4.fun_stat();
end
endmodule*/


/*Write a snippet of code for Addition of elements of two array using function passing 
  arrays through pass by reference method and analyze the output*/

/*module test;
  int a[4],b[4];
  int sum[4];
  function automatic add (const ref int a[4], b[4], ref int sum[4]);
    foreach (a[i])
      sum[i]=a[i] + b[i]; 
  endfunction
  initial
    begin
      foreach (a[i])
        begin
          a[i]= $urandom%50;
          b[i]= $urandom%20;
        end
      add (a, b, sum);
      $display ("a=%0p",a);
      $display ("b=%0p",b);
      $display ("sum=%0p",sum);
    end
endmodule*/


/********* there is two ways to return function****////
/*
//1

module tb;

function int add(int a, b);

    return a + b;

endfunction

initial begin

    $display("Sum = %0d", add(10,20));

end

endmodule

//2

module tb;

function int add(int a, b);

    add = a + b;  // return using function name

endfunction

initial begin

    $display("Sum = %0d", add(10,20));

end

endmodule
*/


module tb;

int salary[string];   // associative array

function int get_salary(string name);

    if(salary.exists(name))
        return salary[name];

    return -1;

endfunction

initial begin

    salary["John"]  = 50000;
    salary["David"] = 70000;

    $display("%0d", get_salary("David"));
    $display("%0d", get_salary("Ali"));

end

endmodule