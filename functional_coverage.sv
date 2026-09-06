/*module top;
  class main;
    bit[3:0] a;
    covergroup cg;
      A :  coverpoint a{
        bins a1[3] = {[5:7]};}
    endgroup
    
    function new();
      cg =new();
    endfunction
    
  endclass
  main h;
  initial
    begin 
      h =new();
	  
    end
endmodule*/
///////////////////////////////////////////ques1/////////////////////////////////
/*
module tb;

  class example;

    bit [2:0] kind;
    bit [2:0] dst;
    bit [3:0] sig;

    covergroup cg;
      CP_KIND : coverpoint kind { option.auto_bin_max = 4; }
      
      CP_DST : coverpoint dst {
        bins low  = {0,1};
        bins mid  = {2,3};
        bins high = {4,5,6,7};
      }
	
      CP_SIG : coverpoint sig {
        bins up     = (0 => 1);
        bins down   = (1 => 0);
        bins burst  = (1 => 2[*3] => 4);
      }
      
      KIND_X_DST : cross CP_KIND, CP_DST {
        ignore_bins hi  = binsof(CP_DST.high) intersect {7};
        ignore_bins mid = binsof(CP_DST.low)  intersect {0} &&
                            binsof(CP_KIND)     intersect {[5:7]};
        ignore_bins lo  = binsof(CP_KIND)     intersect {0};
      } 

    endgroup

    function new();
      cg = new();
    endfunction

  endclass

  example h = new();

  initial begin
    for (int i = 0; i < 12; i++) begin
      h.kind = i % 8;
      h.dst  = (i*2) % 8;
      h.sig  = (i % 5 == 0) ? 1 : (i % 4);
      h.cg.sample();
      $display("i=%0d kind=%0d dst=%0d sig=%0d  Coverage=%0.2f%%",
               i, h.kind, h.dst, h.sig, h.cg.get_coverage());
    end
    $display("FINAL COVERAGE = %0.2f%%", h.cg.get_coverage());
  end

endmodule
*/
//////////////////////////////////////////////////ques2////////////////////////////////////////
/*
module tb1;

  class packet;

    bit [3:0] mode;
    bit [2:0] addr;
    bit [3:0] data;

    covergroup cg;

      CP_MODE : coverpoint mode { option.auto_bin_max = 5; }

      CP_ADDR : coverpoint addr {
        bins small1875 = {0,1};
        bins med   = {2,3,4};
        bins big   = {5,6,7};
      }

      CP_DATA : coverpoint data {
        bins rise = (0 => 1);
        bins fall = (1 => 0);
        bins jump = (0 => 2[*2] => 5);
      }

      MODE_X_ADDR : cross CP_MODE, CP_ADDR {
        ignore_bins inv1 = binsof(CP_ADDR.big) intersect {7};
        ignore_bins inv2 = binsof(CP_ADDR.small1875) intersect {0} &&
                           binsof(CP_MODE)       intersect {[10:12]};
      }

    endgroup

    function new();
      cg = new();
    endfunction
      
  endclass

  packet p = new();

  initial begin
    for (int i = 0; i < 15; i++) begin
      p.mode = (i * 3) % 16;
      p.addr = (i + 2) % 8;
      p.data = (i % 6 == 0) ? 0 : (i % 5);
      p.cg.sample();
      $display("i=%0d mode=%0d addr=%0d data=%0d Coverage=%.2f%%",
               i, p.mode, p.addr, p.data, p.cg.get_coverage());
    end
    $display("FINAL COVERAGE = %.2f%%", p.cg.get_coverage());
  end

endmodule
*/

/*
/////////////////////////////////////////////////ques3//////////////////////////////////////////
module top;
  class main;

    rand bit[3:0] kind;
    rand bit[2:0] dst;
    
    covergroup cg;
      a : coverpoint kind{
        	option.auto_bin_max=10;
      }
      b : coverpoint dst{
      		option.auto_bin_max=8;
      }
      axb : cross kind,dst{
  		ignore_bins hi = binsof(dst) intersect {7};
  		ignore_bins md = binsof(dst) intersect {0} &&
                   binsof(kind) intersect {[9:11]};
  //		ignore_bins lo = binsof(kind.lo);
		}
    endgroup
    
    function new();
      cg = new();
    endfunction
    
  endclass
  main h;
  initial
    begin
      h = new();
      repeat(20)
        begin
          assert(h.randomize());
          h.cg.sample;
          $display("%d",h.cg.get_coverage());
        end
    end
endmodule
*/

///////////////////////////////////////////////////ques4/////////////////////////////////////////////
/*
interface mem_if(input clk);
  logic [2:0] mode;
  clocking cb @(posedge clk);
    input mode;
  endclocking
endinterface

module top;
  
  bit clk;
  always
    #5 clk = ~clk;
  
  mem_if if1(clk);
  
   int val;
  covergroup cg@(if1.cb);
      coverpoint if1.mode{
        bins zero = (2 => 4);
        bins one = (4 => 5);
      }
    endgroup
   
      cg cgh =new();
  
  initial
    begin
      repeat(10) begin
        if1.mode = $urandom_range(0,5);
              @(posedge clk);                  // CB sampling happens here
	
        $display("%t %d",$time,cgh.get_coverage()); end 
    end
endmodule
  
*/
 
 /*  
module top;
	bit [3:0] a;
	class main;
		covergroup cg;

			coverpoint a{
				bins b[] ={[9:10],[10:15]};
				illegal_bins b2[3]={[9:11]};
			}
		endgroup
		function new();
			cg  =new();
		endfunction
	endclass
	main h;
	initial
		begin
			h =new();

			a = 4;
			h.cg.sample();

			a = 10;
			h.cg.sample();
						a = 11;
			h.cg.sample();
						a = 12;
			h.cg.sample();
			a = 13;
			h.cg.sample();
						a = 14;
			h.cg.sample();
						a = 15;
			h.cg.sample();
			$display("%d",h.cg.get_coverage());
		end

	endmodule
*/

/*

module top;
	bit[2:0] a,b;
	covergroup cg;
	A :	coverpoint a{
			bins o = {[0:1]};
			bins t = {[2:3]};
			bins w = {[4:5]};
			bins r = {[6:7]};
		}
	B :	coverpoint b{
			bins oo = {[0:3]};
			bins tt = {[4:7]};
		}
	A1XB1 : cross A,B {
 		 bins b0 = binsof(A.o) && binsof(B.oo);
  		 bins b1 = binsof(A.t) && binsof(B.oo);
  	  	 bins b2 = binsof(A.w) && binsof(B.oo);
  		 bins b3 = binsof(A.r) && binsof(B.oo);

  		 bins b4 = binsof(A.o) && binsof(B.tt);
  		 bins b5 = binsof(A.t) && binsof(B.tt);
  		 bins b6 = binsof(A.w) && binsof(B.tt);
  		 bins b7 = binsof(A.r) && binsof(B.tt);

		}
	endgroup
	cg h;
	initial
		begin
			h = new();
			for(int i=0;i<8;i++)
				begin
				if(i<=3)
					begin
					a = i;
					b = i;
					h.sample();
					$display("%d",h.get_coverage());
				end
			end
	end
endmodule
*/

/*
class test;
rand int a;
constraint a1{a inside{[5:45]}; a dist{10:=1};}
covergroup cg;
option.per_instance=1;
A:coverpoint a{bins b1={10};
        bins b2={[25:30]};
        bins b3={[31:35]};
        bins b4={[36:40]};
        bins b5={[41:45]};}
endgroup

function new;
    cg=new;
endfunction

endclass
test t;
module t;
initial
begin
t=new;
repeat(10)
begin
assert(t.randomize);
t.cg.sample;
$display("The value of a=",t.a);
$display("The coverage is=",t.cg.get_inst_coverage);
end
end
endmodule
*/



/*module test(); 
           class coverage; 
      bit [3:0] a; 
    covergroup exe; 
        option.per_instance=1; 
          coverpoint a; 
              endgroup 
 
           function new(); 
               exe=new(); 
              endfunction 
      endclass 
       coverage c_h; 
 
             initial 
		begin 
            		 for (int i=0; i<13;i++)
 				begin 
              				c_h =new(); 
              				c_h.a=i;
					c_h.exe.sample(); 
				end 
		
        	end 
  endmodule */

/*
module func_coverage;

  logic [3:0] addr;
  logic [2:0] data;
  logic en;

    covergroup c_group;
        cp1: coverpoint addr {
      bins b1 = {1, 10, 12};
      bins b2[] = {[2:9], 11};
      ignore_bins b3[2] = {[6:9]};}

    cp2: coverpoint data {
      bins b1 = {4, 7};       
      bins b2[] = {2, 3, 6}; }

       cp3: coverpoint en {
      bins b1 = {1};}

  endgroup

   c_group cg = new();

  
  
  initial begin

    repeat(20) begin
     
      addr = $urandom_range(0,15);
      data = $urandom_range(0,7);
      en   = $urandom_range(0,1);

      cg.sample();

      $display("addr=%0d data=%0d en=%0d", addr, data, en);
    end

        $display("\nCoverage = %0.2f %%", cg.get_inst_coverage());

    $finish;
  end

endmodule
*/

/* module top;

  bit clk;
  bit [7:0] var1, var2;

    covergroup c_group @(posedge clk);

        cp1: coverpoint var1 {
      bins x1 = {[0:99]};
      bins x2 = {[100:199]};
      bins x3 = {[200:255]};
    }

        cp2: coverpoint var2 {
      bins y1 = {[0:74]};
      bins y2 = {[75:149]};
      bins y3 = {[150:255]};
    }

        cp1_X_cp2: cross cp1, cp2 {

      bins xy1 = binsof(cp1.x1); // cp1 = x1 with all cp2
      bins xy2 = binsof(cp2.y2); // cp2 = y2 with all cp1
      bins xy3 = binsof(cp1.x1) && binsof(cp2.y2); // intersection
      bins xy4 = binsof(cp1.x1) || binsof(cp2.y2); // union  all combination of x1 and y2 and remove duplicate 

    }

  endgroup

    c_group cg = new();

    initial clk = 0;
  always #5 clk = ~clk;

  initial begin

    repeat(20) begin
      @(posedge clk);

      var1 = $urandom_range(0,255);
      var2 = $urandom_range(0,255);

      cg.sample();

      $display("var1=%0d var2=%0d", var1, var2);
    end

    // Coverage report
    $display("\nCoverage = %0.2f %%", cg.get_inst_coverage());

    $finish;
  end

endmodule
*/

/*
module top;

  bit clk;
  bit [7:0] var1, var2;

  // Covergroup
  covergroup c_group @(posedge clk);

    // Coverpoint 1
    cp1: coverpoint var1 {
      bins x1 = {[0:99]};
      bins x2 = {[100:199]};
      bins x3 = {[200:255]};
    }

    // Coverpoint 2
    cp2: coverpoint var2 {
      bins y1 = {[0:74]};
      bins y2 = {[75:149]};
      bins y3 = {[150:255]};
    }

    // Cross coverage
    cp1_X_cp2: cross cp1, cp2 {

      // cp1 values between 100–200
      bins xy1 = binsof(cp1) intersect {[100:200]};

      // NOT cp1 values between 100–200
      bins xy2 = !binsof(cp1) intersect {[100:200]};

      // specific values NOT in cp1 bins
      bins xy3 = !binsof(cp1) intersect {99,125,150,175};

    }

  endgroup

  // Instance
  c_group cg = new();

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin

    repeat(20) begin
      @(posedge clk);

      var1 = $urandom_range(0,255);
      var2 = $urandom_range(0,255);

      cg.sample();

      $display("var1=%0d var2=%0d", var1, var2);
    end

    $display("\nCoverage = %0.2f %%", cg.get_inst_coverage());

    $finish;
  end

endmodule
*/
/*
module test;
	class example;
		bit[3:0]y;
		bit[6:0]z;  // max 64 bins will be created
		covergroup cg;
			cp_y:coverpoint y{ option.auto_bin_max=4;}
			cp_z:coverpoint z;
			cp_yz:cross cp_y,cp_z;
		endgroup
		
		function new();
			cg=new();
		endfunction
	endclass
	
	example eh;
		initial
			begin
				eh=new();
				for(int i=0;i<10;i++)
					begin
		

					//	eh=new();	
						eh.y=i;
						eh.z=i+1;
						eh.cg.sample();
					end
			end
endmodule
*/

/*module test; 
class example;  
	bit [0:2] y;  
	bit z; 
	covergroup cg;  
		CP_Y : coverpoint y  
			{ option.auto_bin_max = 4 ; } 
		CP_Z : coverpoint z; 
		YZ :  cross CP_Y, CP_Z;  
	endgroup  

	function new(); 
		cg=new(); 
	endfunction 
endclass 

example e_h=new(); 

	initial 
		begin 

			for( int i=0; i< 5; i++)  
				begin 
				//	e_h=new();
					e_h.y= i; 
					e_h.z= ~e_h.z; 
					e_h.cg.sample; 
				end
		end
endmodule*/

/*
module cg_test(); 
            bit [4:0]a; 
            covergroup cg; 
                 c1:coverpoint a {option.at_least = 2; 
                                           bins a1[10]={[0:$]};} 
   endgroup 
  cg c1; 
  initial 
   begin 
    c1 = new(); 
    for(int i = 0;i < 16;i++) 
    begin 
     a = i; 
     c1.sample (); 
	$display("value of i=%0d",i);
    end 
    a = 4'b1010; 
    c1.sample; 
   end 
endmodule 
*/

/*

module test;
	bit[4:0]y;
	bit reset;
	bit clock;
	event e;

	covergroup cg (int i) @(e);
		option.per_instance=1;
		option.at_least=i;
		
		CP_Y:coverpoint y iff(!reset)
		{option.auto_bin_max=7;}
	endgroup

	cg cg1;

	initial
		begin
			cg1=new(1);
			for(int i=0;i<7;i++)
			begin
				y=i;
				reset= ~reset;
				#20;
			end
		end

	initial
		begin
			for(int i=0;i<7;i++)
			begin
				->e;
				#10;
			end
		end
endmodule
*/

/*
module tb;

  bit [2:0] a;

  covergroup cg;
    cp : coverpoint a { option.auto_bin_max = 5;}
  endgroup

  cg c = new();

   initial
 	begin
    	repeat(10)
		begin
      			#10;
     		 	a=a+2;
    		end
  	end

   initial 
	begin
    	repeat(3)
		begin
      			#20;
      			c.sample();
    		end
  	end

endmodule
*/

/*
module tb;

  bit [3:0] a;
  bit [2:0] b;

  covergroup cg;

    cp_a : coverpoint a { option.auto_bin_max = 5;}

    cp_b : coverpoint b {
      bins low  = {[0:2]};
      bins high[] = {[3:7]};
      ignore_bins ig = {5};}

    cross cp_a, cp_b;

  endgroup

  cg c = new();

  initial 
	begin
    	repeat(8) 
		begin
      			#10;
     			 a = a + 2;
      			 b = b + 1;
    		end
  	end

  initial
	 begin
    	  repeat(6)
		begin
      			#13;
      			c.sample();
    		end
  	end

endmodule
*/



module tb;

  bit [6:0] a;
  int b;

  covergroup cg;

    cp_a : coverpoint a;

    cp_b : coverpoint b {
      bins even = {0,2,4,6,8};
      bins odd  = {1,3,5,7,9};
    }

    cross a, cp_b;

  endgroup

  cg c = new();

  initial begin
    repeat (5) begin
      #10;
      a += 25;
      b += 2;
      c.sample();
    end
  end

endmodule


/*
module tb;

  bit [3:0] a;

  covergroup cg;
    cp : coverpoint a {
      wildcard bins wb[] = {4'b1??1, 4'b1??0};
    }
  endgroup

  cg c = new();

  initial begin
    for (int i = 2; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        a = {i[1:0], j[1:0]};
        c.sample();
      end
    end
  end

endmodule
*/
