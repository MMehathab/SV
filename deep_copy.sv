 
 /*// deep copy example
 
 class sub;
 	int obj;
 	function sub copy2();       //returns address of subclass pointed by handle copy2
 		copy2=new();
 		copy2.obj=this.obj;
 	endfunction:copy2
 endclass:sub
 
 class trans;
 	int data;
 	sub s=new();
 	function trans copy1();
 		copy1=new();
 		copy1.data=this.data;    //here this refers to th1
 		copy1.s=this.s.copy2;       //this.s=th1.s. address of copy1.s will be changed to address of copy2
 	endfucntion:copy1                    // after end function copy1 handle will be erased
 endclass:trans
 
 module test();
 trans th1,th2;
 initial
 	begin
 		th1=new();
 		th1.data=4;
 		th1.s.obj=5;
 		
 		$display("\nAFTER CREATING th1");
   		$display("th1.data   = %0d", th1.data);
    		$display("th1.s.obj  = %0d", th1.s.obj);
    		
 		th2=th1.copy;              //address of copy1. th2 will act as handle along with copy1 but after endfunction 
 							//copy1 will be erased by tool, only th2 is a handle now
 		$display("\nAFTER th2 = th1.copy1();   
   		$display("th1.data   = %0d", th1.data);
    		$display("th1.s.obj  = %0d", th1.s.obj);
    		$display("th2.data   = %0d", th2.data);
    		$display("th2.s.obj  = %0d", th2.s.obj);
    		
    		
 		th2.s.obj=10;
 		
 		$display("AFTER changing th2.s.obj");
    		$display("th1.data   = %0d", th1.data);
    		$display("th1.s.obj  = %0d", th1.s.obj);  
    		$display("th2.data   = %0d", th2.data);
    		$display("th2.s.obj  = %0d", th2.s.obj);
    		
	end
 endmodule:test*/
 
 
 
 /* deep copy with 3 classes*/
 
  class short;
 	int addr;
 	function short copy3;
 		copy3=new;
 		copy3.addr=this.addr;
 	endfunction
 endclass
 
 class sub;
 	int obj;
 	short sh=new;
 	function sub copy2();       //returns address of subclass pointed by handle copy2
 		copy2=new();
 		copy2.sh=this.sh.copy3;
 		copy2.obj=this.obj;
 	endfunction
 endclass:sub
 
 class trans;
 	int data;
 	sub s=new();
 	function trans copy1();
 		copy1=new();
 		copy1.data=this.data;    //here this refers to th1
 		copy1.s=this.s.copy2;       //this.s=th1.s. address of copy1.s will be changed to address of copy2
 	endfunction:copy1                    // after end function copy1 handle will be erased
 endclass:trans
 
 module test();
 trans th1,th2;
 initial
 	begin
 		th1=new();
 		th1.data=4;
 		th1.s.obj=5;
 		th1.s.sh.addr=30;
 		
 		$display("\nAFTER CREATING th1");
   		$display("th1.data   = %0d", th1.data);
    		$display("th1.s.obj  = %0d", th1.s.obj);
    		$display("th1.s.sh.addr  = %0d", th1.s.sh.addr);
    		
    		
 		th2=th1.copy1;              //address of copy1. th2 will act as handle along with copy1 but after endfunction 
 							//copy1 will be erased by tool, only th2 is a handle now
 		$display("\nAFTER th2 = th1.copy1()");   
   		$display("th1.data   = %0d", th1.data);
    		$display("th1.s.obj  = %0d", th1.s.obj);
    		$display("th1.s.sh.addr  = %0d", th1.s.sh.addr);
    		$display("th2.data   = %0d", th2.data);
    		$display("th2.s.obj  = %0d", th2.s.obj);
    		$display("th2.s.sh.addr  = %0d", th2.s.sh.addr);
    		
    		
 		th2.s.obj=10;
 		th2.s.sh.addr=20;
 		
 		$display("AFTER changing th2.s.obj");
    		$display("th1.data   = %0d", th1.data);
    		$display("th1.s.obj  = %0d", th1.s.obj); 
    		$display("th1.s.sh.addr  = %0d", th1.s.sh.addr); 
    		$display("th2.data   = %0d", th2.data);
    		$display("th2.s.obj  = %0d", th2.s.obj);
    		$display("th2.s.sh.addr  = %0d", th2.s.sh.addr);
    		
	end
 endmodule:test
