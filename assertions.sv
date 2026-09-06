
/*module simple_assertion_example;
  reg a, b;

  initial begin
    a = 1'b1;
    b = 1'b0;
    #10 a = 1'b0;
    #10 b = 1'b0;
    #10 a = 1'b1;
    #10 b = 1'b1;
  end

  always @(*) begin
    assert (a == b)
	$display("pass");
	else
      $display("Assertion failed: a (%0b) != b (%0b) at time %0t", a, b, $time);
  end
endmodule*/

/*module top;
	bit a;
	bit b;
	bit clk;

	property prop;
		@(posedge clk)
		$rose(a)|=>!b;
	endproperty

	ac : assert property(prop);
	cov: cover property(prop);
endmodule*/




/* At any positive edge of the clock, if signal b is asserted high, then signal a must have been 
high exactly two clock cycles earlier, provided that the gating signal c is valid (high) on the 
corresponding clock edge. */

/*module example;
bit rst,clk,a,b,c;

property example1;
	@(posedge clk) disable iff(rst)
	$rose(b) |-> $past(a,2)==1;
endproperty

a0:assert property(example1);
c0:cover property(example1);

endmodule*/

/*At any positive edge of the clock, if signal b is asserted high, then signal a must have been 
high exactly two clock cycles earlier, provided that the gating signal c is valid (high) on the 
same clock edge. */

/*module test;
bit rst,clk,a,b,c;

property example2;
	@(posedge clk) disable iff(rst)
	(b && c) |-> $past((a,2)==1);
endproperty

a0:assert property(example2);
c0:cover property(example2);

endmodule*/


//////////////////////////////////////////////////////////////////////////////////////////////////
//1 write a assertion Signal_a and signal_b can only be asserted together for one cycle; in the next cycle, at least 
//one of them must be deasserted.
//////////////////////////////////////////////////////////////////////////////////////////////////
/*module top1;
	bit signal_a,signal_b,clk;
	
	property prop1;
		@(posedge clk)
			(signal_a && signal_b) |-> !(signal_a && signal_b);
	endproperty

	ap : assert property(prop1);
	cp : cover property (prop1);
endmodule*/

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//2 write a assertion Signal_a must not be asserted before the first signal_b (maybe asserted on the same cycle 
//as signal_b)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*module top_11;
	bit clk;
	bit left;
	bit right;
	bit rst;
	bit[3:0] q;

	property rst_n;
	@(posedge clk)
		!rst |-> (q==4'd0);
	endproperty

		
	property prop1;
		@(posedge clk)
			disable iff(!rst)
				(!left && right) |=> q==({1'b0,$past(q[3:1])});
	endproperty

	property prop2;
		@(posedge clk)
			disable iff(!rst)
				(left && !right) |=> q==({$past(q[2:0]),1'b0});
	endproperty

	property prop3;
		@(posedge clk)
			disable iff(!rst)
				(!left && !right) |=> q==$past(q,1);
	endproperty

	a0 : assert property(rst_n);
	c0 : cover property(rst_n);
		
	a1 : assert property(prop1);
	c1 : cover property(prop1);

	a2 : assert property(prop2);
	c2 : cover property(prop2);

	a3 : assert property(prop3);
	c3 : cover property(prop3);

endmodule*/

/*

module top34;
 	bit enable;
	bit ready;
	bit clk;
	property prop_1;
		@(posedge clk)
			enable && ready;
	endproperty

	a0 : assert property(prop_1);
	c0 : cover property (prop_1);
endmodule
*/



/*

module top;
	bit clk;
	bit a,b;

	

		property p1;
			@(posedge clk) $rose(a) |=> b ##2 c;
		endproperty
	
		p11 : assert property (p1)
			$info("asstertion passed ");
		else 
			$error("assertion failed");
		
		c11 : cover property (p1);
 
endmodule 	
*/
/*
module top;
	bit clk;
	bit a,b,q1,q0,clr;

	always@(posedge clk)
		begin 
			if(clr)
				q1 <= 1'b0;
			else if (a == 0 && b ==0)
				q1<= 1'b1;
			else if(a == 0 && b== 1) 
				q1 <= ~q1;
			else if(a == 1 && b==0)
				q1 <= q1;
			else 
				q1<= 1'b0;
		end
	assign q0 =~q1;
	
        property clr_ppt;
		@(posedge clk) $rose(clr) |=> q1 == 0;
	endproperty

//	property not_equal;
//		@(posedge clk) q1 != q0;
//	endproperty

	property no_change;
		@(posedge clk) disable iff(clr) 
			        (a==1 && b == 0) |=> q1 == $past(q1,1);
	endproperty

	property set;
		@(posedge clk) 	disable iff(clr)
				(a==0 && b==0) |=> q1 == 1; 	
	endproperty

	property toggle;
		@(posedge clk) disable iff(clr)
				(a==0 && b==1) |=> q1 == ~$past(q1,1);
	endproperty

	property reset;
		@(posedge clk) 	disable iff(clr)
				(a==1 && b==1) |=> q1 == 0;
	endproperty

	CLEAR      : assert property(clr_ppt);
	NO_CHGANGE : assert property(no_change);
	SET        : assert property(set);
	RESET      : assert property(toggle);
	TOGGLE     : assert property(reset);

	CLEAR_1      : cover property(clr_ppt);
	NO_CHGANGE_1 : cover property(no_change);
	SET_1 	     : cover property(set);
	RESET_1      : cover property(toggle);
	TOGGLE_1     : cover property(reset);

	
		
endmodule 
*/
/*
module top;
	bit clk;
	bit a,b,c;

	

		property p1;
			@(posedge clk) $rose(a) |=> b ##2 c;
		endproperty
	
		p11 : assert property (p1)
			$info("asstertion passed ");
		else 
			$error("assertion failed");
		
		c11 : cover property (p1);
 
endmodule 	
*/


//signal a is high in next clock cycle signal b should be high until c is high
/*
module top;
	bit clk,a,b,c,rst;
	
	property p1;
		@(posedge clk) disable iff(rst) $rose(a) |=> b until_with c;  
	endproperty
	
	P1 : assert property(p1);
	
	C1 : cover property(p1);
endmodule 
*/

//write an assertion to check that whenever req goesw high ack must be aserted within 3 cycles 
//and once ack is asserted req must go low in the next cycle;
/*
module top;
	bit clk,req,ack,rst;
	
	property p1;
		@(posedge clk) disable iff(rst) $rose(req) |-> ##[0:2]ack ##1 $fell(req); 
	endproperty
	
	P1 : assert property(p1);
	
	C1 : cover property(p1);
endmodule 
*/
/*
module assertion;
	bit clk,req,grant;
	
	property p1;
		@(posedge clk) $rose(req) |-> ##3 (grant) !(req) !##[0:$] grant; 
	endproperty
	
	P1 : assert property(p1);
	C1 : cover property(p1);
endmodule 
 */
	
				
	

/*module top;
		logic [3:0] grant;
		logic valid_req;
		logic clk;
		
		property p0;
			@(posedge clk) $onehot(grant);
		endproperty
		
		property p1;
			@(posedge clk) $rose(valid_req) |-> ##[1:5] $onehot(grant);
		endproperty 
		
		P1 : assert property (p1);
		C1 : cover property (p1);
		P0 : assert property (p0);
		C0 : cover property (p0);

endmodule */





module top;
	bit clk;
	bit a,b,c;

	

		property p1;
			@(posedge clk) $rose(a) |=> b ##2 c;
		endproperty
	
		p11 : assert property (p1)
			$info("asstertion passed ");
		else 
			$error("assertion failed");
		
		c11 : cover property (p1);
 
endmodule 	


/*module top;
	bit clk;
	bit a,b,q1,q0,clr;

	always@(posedge clk)
		begin 
			if(clr)
				q1 <= 1'b0;
			else if (a == 0 && b ==0)
				q1<= 1'b1;
			else if(a == 0 && b== 1) 
				q1 <= ~q1;
			else if(a == 1 && b==0)
				q1 <= q1;
			else 
				q1<= 1'b0;
		end
	assign q0 =~q1;
	
        property clr_ppt;
		@(posedge clk) $rose(clr) |=> q1 == 0;
	endproperty

//	property not_equal;
//		@(posedge clk) q1 != q0;
//	endproperty

	property no_change;
		@(posedge clk) disable iff(clr) 
			        (a==1 && b == 0) |=> q1 == $past(q1,1);
	endproperty

	property set;
		@(posedge clk) 	disable iff(clr)
				(a==0 && b==0) |=> q1 == 1; 	
	endproperty

	property toggle;
		@(posedge clk) disable iff(clr)
				(a==0 && b==1) |=> q1 == ~$past(q1,1);
	endproperty

	property reset;
		@(posedge clk) 	disable iff(clr)
				(a==1 && b==1) |=> q1 == 0;
	endproperty

	CLEAR      : assert property(clr_ppt);
	NO_CHGANGE : assert property(no_change);
	SET        : assert property(set);
	RESET      : assert property(toggle);
	TOGGLE     : assert property(reset);

	CLEAR_1      : cover property(clr_ppt);
	NO_CHGANGE_1 : cover property(no_change);
	SET_1 	     : cover property(set);
	RESET_1      : cover property(toggle);
	TOGGLE_1     : cover property(reset);

	
		
endmodule */

/*
module top;
	bit clk;
	bit a,b,c;

	

		property p1;
			@(posedge clk) $rose(a) |=> b ##2 c;
		endproperty
	
		p11 : assert property (p1)
			$info("asstertion passed ");
		else 
			$error("assertion failed");
		
		c11 : cover property (p1);
 
endmodule 	
*/
	

//signal a is high in next clock cycle signal b should be high until c is high
/*
module top;
	bit clk,a,b,c,rst;
	
	property p1;
		@(posedge clk) disable iff(rst) $rose(a) |=> b until_with c;  
	endproperty
	
	P1 : assert property(p1);
	
	C1 : cover property(p1);
endmodule 
*/

//write an assertion to check that whenever req goesw high ack must be aserted within 3 cycles 
//and once ack is asserted req must go low in the next cycle;
/*
module top;
	bit clk,req,ack,rst;
	
	property p1;
		@(posedge clk) disable iff(rst) $rose(req) |-> ##[0:2]ack ##1 $fell(req); 
	endproperty
	
	P1 : assert property(p1);
	
	C1 : cover property(p1);
endmodule 
*/
/*
module assertion;
	bit clk,req,grant;
	
	property p1;
		@(posedge clk) $rose(req) |-> ##3 (grant) !(req) !##[0:$] grant; 
	endproperty
	
	P1 : assert property(p1);
	C1 : cover property(p1);
endmodule 
 */
/*module top;
		logic [3:0] grant;
		logic valid_req;
		logic clk;
		
		property p0;
			@(posedge clk) $onehot(grant);
		endproperty
		
		property p1;
			@(posedge clk) $rose(valid_req) |-> ##[1:5] $onehot(grant);
		endproperty 
		
		P1 : assert property (p1);
		C1 : cover property (p1);
		P0 : assert property (p0);
		C0 : cover property (p0);

endmodule */


 /*Write an assertion: On rose of a, wait for rose of b or c. If b comes first, 
then d should be 1. If c comes first d should be zero. */

/*

module top;
	bit a,b,c,d;

property p_a_b_c_d;
  @(posedge clk)
  $rose(a) |-> first_match(
                 ##[1:$] $rose(b) ##0 (d == 1) or
                 ##[1:$] $rose(c) ##0 (d == 0)
               );
endproperty
/*
P0:assert property(p_a_b_c_d);
C0:cover_property(p_a_b_c_d);

endmodule*/

/*
module counter;
	bit clk,rst,en;
	bit [3:0] count_out;

	always @(posedge clk)
	begin
		if(rst)
			count_out<=4'd0;
		else if(!rst && en && count_out==15)
			count_out<=0;
		else if(en)
			count_out<=count_out+1;
	end

	property reset;
		@(posedge clk) rst |=> count_out==0;
	endproperty

	property enb;
		@(posedge clk) disable iff(rst)
		(en && (count_out)!=15) |=> (count_out==$past(count_out)+1); 
	endproperty

	property c15;
		@(posedge clk) disable iff(rst)
		(en && (count_out)==15) |=> (count_out==0); 
	endproperty

	property hold;
		@(posedge clk) disable iff(rst)
		!en |=> (count_out==$past(count_out)); 
	endproperty




	p0:assert property(reset);
	c0:cover property (reset);

	p1:assert property(enb);
	c1:cover property(enb);

	p2:assert property(c15);
	c2:cover property(c15);

	p3:assert property(hold);
	c3:cover property(hold);


endmodule

*/

/********** glitch detection ************/
/*
module glitch;
	bit a,clk;

	property p1 ;
	@(posedge clk)	$changed(a) |=> !($stable(a));
	endproperty

	A1:assert property(p1);
	A2:cover property (p1);
endmodule
*/


/*** when a signal_a is asserted,signal_b must be asserted, 
and must remain up until one of the signals signal_c or signal_d is asserted ****/

/*
module test;
	bit a,b,c,d,clk,rst;

/*	property p1;
		@(posedge clk) disable iff(rst)
		$rose(a) |-> (b throughout (!c && !d));
	endproperty  

//   or

	property p2;
		@(posedge clk) disable iff(rst)
		$rose(a) |-> if((!c) && (!d))
					b==1;
				else	
					b==0;
	endproperty

	P1:assert property(p1);
	C1:cover property(p1);
endmodule
*/


/**** Data should never repeat on two consecutive valid transfers*****/
/*
module top;

bit [7:0] prev_data;
bit prev_valid;  

always @(posedge clk)
begin
  if(valid && ready)
  begin
    prev_data  <= data;
    prev_valid <= 1;
  end
end

property no_repeat_transfer;
  @(posedge clk)
  (valid && ready && prev_valid)|-> (data != prev_data);
endproperty

assert property(no_repeat_transfer);

endmodule
*/



/*Response ID must match request ID*/
/*
module top;
	bit [3:0]req_id,rsp_id;
	bit clk,req_valid,rsp_valid;
	
	 property id_match;
		int id;
		@(posedge clk) 
		(req_valid,id=req_id) |=> ##[1:$] rsp_valid |-> (rsp_id==id);
	endproperty
	
	/********** or  ************/  /** (req_valid,id=req_id) means if(req_valid) then id <= req_id;***/
	
/*	always @(posedge clk)
		begin
		  if(req_valid)
			id <= req_id;
		end

	property id_match;
	  @(posedge clk)
	  req_valid|=> ##[1:$]rsp_valid |-> (rsp_id == id);
	  
	
	assert property (id_match);
endmodule
*/


/*** assertion for frequency checker. (100Mhz) ***/ 
/*
module top;
bit clk;

property clk_freq_check;
  realtime t;

  @(posedge clk)
  (1,t = $realtime)|=> @(posedge clk)(($realtime - t) == 10ns);

/* @(posedge clk)
  (1,t=$realtime)|=> @(posedge clk)($realtime-t >= 9.9ns && $realtime-t <= 10.1ns); 
 
endproperty

assert property(clk_freq_check);

endmodule
*/



  
 /*** How would you write an assertion to verify that a clock maintains a period of 10 ns?***/
/*
module check;

    reg clk;

    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;
    end

property p1;
    time t1, t2;

    @(posedge clk)(1, t1 = $realtime)
    |=> @(posedge clk)(1, t2 = $realtime)
    |-> (t2 - t1) == 10ns;
endproperty

assert property(p1);

endmodule
*/

/*******How would you verify that a clock has a 50% duty cycle with a tolerance of ±1 ns?********/
/*
module duty_cycle;

    reg clk;

    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;
    end

property duty_cycle_check;

    time t1, t2, t3;

    @(posedge clk)(1, t1 = $realtime)
    |=> @(negedge clk)(1, t2 = $realtime)
	|=> @(posedge clk)(1, t3 = $realtime)
    |-> (((t2 - t1) >= 4ns) && ((t2 - t1) <= 6ns)) &&
       (((t3 - t2) >= 4ns) && ((t3 - t2) <= 6ns));

endproperty

assert property(duty_cycle_check)
    else
        $error("Duty cycle is not 50%% ±1 ns");
endmodule
*/


/*****How would you detect if a clock stops toggling for more than 20 ns?****/
/*
module tb;

    reg clk;
    time t1, t2;

    initial
	begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    property clk_alive;

        @(posedge clk)(1, t1 = $realtime)
		|=> @(posedge clk) (1, t2 = $realtime)
        |-> ((t2 - t1) <= 20ns);

    endproperty

    CLK_ALIVE_CHECK:
    assert property(clk_alive)
        $display("PASS");
    else
        $error("Clock stopped for more than 20 ns");

    initial begin
        #100;
        $finish;
    end

endmodule
*/


 /****How would you detect clock glitches or pulses narrower than 3 ns? ****/
 
/*
module tb;

    reg clk;

    initial
	begin
    clk = 0;

    repeat(3)
    begin
        #5 clk = ~clk;
        #5 clk = ~clk;
    end

    // Inject 2 ns glitch
    #5 clk = 1;
    #2 clk = 0;

    // Continue normal clock
    forever begin
        #5 clk = ~clk;
        #5 clk = ~clk;
    end
end

  // High pulse should be >= 3 ns
  

    property no_glitch;

        time t1, t2;

        @(posedge clk)(1, t1 = $realtime)
        |=> @(negedge clk)(1, t2 = $realtime)
		|-> ((t2 - t1) >= 3ns);

    endproperty

    NO_GLITCH_CHECK :
    assert property(no_glitch)
        $display("[%0t] PASS", $time);
    else
        $error("[%0t] Clock glitch detected", $time);

    initial
    begin
        #80;
        $finish;
    end

endmodule
*/

/**** Given a divide-by-2 clock (clk_div2) generated from clk,
 how would you verify that it toggles every two cycles of clk?***/
 
/*
module tb;

    bit clk;
    bit rst;
    bit q;

    initial 
	begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial 
	begin
        rst = 1;
        #12 rst = 0;
    end

    always @(posedge clk or posedge rst)
    begin
        if(rst)
            q <= 1'b0;
        else
            q <= ~q;
    end

   
    property toggle_check;

        @(posedge clk)
        disable iff(rst)
        q == ~$past(q);

    endproperty

    TOGGLE_CHECK :
    assert property(toggle_check)
        $display("[%0t] PASS", $time);
    else
        $error("[%0t] q did not toggle", $time);

    initial
	begin
        #100;
        $finish;
    end

endmodule
*/


/*** How would you verify that a gated clock remains stable when the clock enable signal is deasserted?***/

/*
module tb;

    bit clk;
    bit rst;
    bit clk_en;
    bit gclk;

 property gated_clk_stable;

        @(posedge clk or negedge clk) disable iff (rst)
			!clk_en |-> $stable(gclk);

    endproperty

    GATED_CLK_STABLE:
    assert property(gated_clk_stable)
        $display("[%0t] PASS", $time);
    else
        $error("[%0t] Gated clock toggled while clk_en = 0", $time);

endmodule

*/

/****How would you verify that clk_b operates at exactly half the frequency of clk_a?****/
 /*
 module tb;

    bit clk_a;
    bit clk_b;
    bit rst;
	
property div2_clk;

    @(posedge clk_a)
    disable iff(rst)
    clk_b == ~$past(clk_b);

endproperty

assert property(div2_clk)
    else
        $error("clk_b is not divide-by-2");

endmodule
*/


/**A pulse generated in the clk_a domain must be observed in the clk_b domain within 
three clk_b cycles. How would you write an assertion for this requirement?**/
/*
module tb;
bit pulsea,pulseb,

property pulse_sync,clka,clkb;

    @(posedge clka) $rose(pulsea) |=>@(posedge clkb) ##[0:3] $rose(pulseb);

endproperty

assert property(pulse_sync);

endmodule
*/

/****How would you verify that an asynchronous reset (rst_n) is 
deasserted only in synchronization with the positive edge of clk?***/

/*
 module tb;
 
 bit clk,rstn_n;

property rst_deassert_sync;

    @(posedge clk)
    $rose(rst_n);

endproperty

assert property(rst_deassert_sync);
*/


/*******  OR ******/
/*
property rst_deassert_sync;

    @(posedge rst_n)
    $rose(clk);

endproperty

assert property(rst_deassert_sync)
    else
        $error("Reset deassertion is not synchronized to clk");

endmodule		
*/

/*
module tb;

  logic clk;
  logic req, ack;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // -----------------------------------------
  // Property with arguments
  // -----------------------------------------
  property p(logic req, logic ack, int min, int max);
    @(posedge clk) req |-> ##[min:max] ack;
  endproperty

  // -----------------------------------------
  // Assertion instances
  // -----------------------------------------

  a1: assert property (p(req, ack, 2, 5))
    $display("[%0t] PASS: ack within 2-5 cycles", $time);
  else
    $error("[%0t] FAIL: ack not within window", $time);

initial 
begin
    req = 0;
    ack = 0;

    repeat (3) @(posedge clk);

    // CASE 1: PASS (ack after 3 cycles)
    req <= 1;
    @(posedge clk);
    req <= 0;

    repeat (3) @(posedge clk);
    ack <= 1;
    @(posedge clk);
    ack <= 0;

	#100 $finish ;
end
endmodule
*/
