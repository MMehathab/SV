module test;
	event e;

	initial
		begin
			fork
				begin
					#10 ->e;
					$display($time,"  trigger");
				end
				begin
					repeat(2)
						begin
							@e;
					//		wait(e.triggered);
							$display($time,"   wait");
						end
				end
			join
		end
endmodule


/*
module test;
	event e;

	initial
		begin
			fork
				begin
					#10 ->e;
				end
				begin
					@e;
					$display("A");
				end
				begin
					@e;
					$display("B");
				end
				
			join
		end
endmodule
*/

/*
module test;
	event e;

	initial
		begin
			fork
				begin
					@e;
					$display($time," A");
				end	

				begin
					#10; 
					-> e;
				end				
			join_any
			$display($time," B");

		end
endmodule
*/

/*
module test;
	event e;

	initial
		begin
			repeat(3)

				begin
					#10; 
					-> e;
				end
		end

	initial
	
		begin
			repeat(3)
				begin
				//	wait(e.triggered);
					@(e);
					$display($time," A");
				end	
		end				
endmodule
*/


/*
module test;
	event e;

	initial
		begin
			->e;
			->e;
			->e;
		end

	initial
		begin
			@(e);
		//	wait(e.triggered);
			$display("recieved");
		end
endmodule
*/


/*join_any to join_none conversion*/

/*
module test;
event e1;
 initial
  begin
	fork
		->e1;
 		begin
			#5 $display("start 1");
		end
		begin
			#10 $display("start 2");
		end
	join_any

  	wait(e1.triggered);
	$display("done");
  end
endmodule
*/

/*
module test;
bit [3:0] i,j;
event e1;

initial
	begin
		{i,j}=$random;
		
		fork
			->e1;
			begin
	
				#i;
				$display("A");
			end

			begin
				#j;
				$display("B");
			end
		join_any
		wait(e1.triggered);
		$display("outside %p %p",i,j);

	end
endmodule
*/			



/****** join_none to join_any******/

/*
module test;
//event e1,e2;
bit[3:0]i,j;
 bit a,b;
initial
	begin
		{i,j} = $random;
		fork
			begin
		
				#i;
				$display("A");
		 		a=1;//->e1;
			end

			begin
				#j;
				$display("B");
				b=1;//->e2;
			end
		join_none
			wait(a ==1 || b==1)
			//wait(e1.triggered) || ( e2.triggered))
		  $display("outside %p %p",i,j);
	end
endmodule
*/


		
/*
module tb;
 event a1,a2;
  
  initial begin
     ->a1;
	#10;
   ->a2;
  end

 initial begin
   ->>a1;      //->> this makes the below processes waits for the trigger. executes in NBA region
	#10;
    ->>a2;
  end
  
  
  initial begin
    @(a1);
    $display("I1 Event A1 Trigger @ time - %0t",$time);
    @(a2);
    $display("I1 Event A2 Trigger @ time - %0t",$time);
  end
  
  initial begin
    wait(a1);
    $display("I2 Event A1 Trigger @ time - %0t",$time);
    wait(a2);
    $display("I2 Event A2 Trigger @ time - %0t",$time);
  end
  
  initial begin
    wait(a1.triggered);
    $display("I3 Event A1 Trigger @ time - %0t",$time);
    wait(a2.triggered);
    $display("I3 Event A2 Trigger @ time - %0t",$time);
  end
 

 
endmodule
*/



/***** circular dependency*****/
/*
module circular_dep;
	event e1 ,e2;
	
	task A();
	$display("start  task A");
		wait(e2.triggered);
		-> e1;
	$display("from task A");
	endtask

	task B();
	$display("start  task B");

		wait(e1.triggered);
		->e2;
	$display("from task B");

	endtask

initial	
	begin

	fork
		A();
		B();
	join_none

	#5 ->e1;
	end
endmodule
*/


/*
module q3;
  event e1;


  task A();
    wait(e1.triggered);
    $display("A done");
  endtask


  task B();
    -> e1;
    $display("B done");
  endtask

  initial 
	fork
    		A();
    		B();
 	 join
endmodule
*/



/*
module q8;
  event e1,e2,e3;

  initial
	 begin
    		fork
      			begin
      	  		//	wait(e1.triggered);
				@(e1);
        			-> e2;
        			$display("A");
      			end

      			begin
       			// 	wait(e2.triggered);
				@(e2);
        			-> e3;
        			$display("B");
      			end

     			 begin
        		//	wait(e3.triggered);
				@(e3);
        			$display("C");
      			end
    		join_none

   -> e1;
  end
endmodule
*/




/*
module q8;
  event e1,e2,e3;

  initial
	 begin
    		fork
      			begin
      	  		//	wait(e1.triggered);
				@(e1);
        			-> e2;
        			$display("A");
      			end

      			begin
       			 //	wait(e2.triggered);
				@(e2);
        			-> e3;
        			$display("B");
      			end

     			 begin
        		//	wait(e3.triggered);
				@(e3);
        			$display("C");
      			end
    		join_none

   #5 ->e1;
  end
endmodule
*/



/*
module q8;
  event e1,e2,e3;

  initial
	 begin
    		fork
      			begin
      	  		//	wait(e1.triggered);
				@(e1);
        			-> e2;
        			$display("A");
      			end

      			begin
       			 //	wait(e2.triggered);
				@(e2);
        			-> e3;
        			$display("B");
      			end

     			 begin
        		//	wait(e3.triggered);
				@(e3);
        			$display("C");
      			end
    		join_none

    ->>e1;
  end
endmodule

*/

/*
module test;

event e;

initial begin
  fork
   -> e;
    @e $display("Received");//output depends on simulator
  join
end

endmodule
*/


/*
module test;

event e;

initial begin
  fork
    begin
      @e;
      $display($time,"A");
    end

    begin
      #10;
      -> e;
    end
  join_none

  $display($time,"B"); // this executes first because join_any
end

endmodule
*/


/*
module test;
  event e;

  initial begin
    #10 -> e;
    #10 -> e;
  end

  initial 
	begin
    		@e;
    		$display($time," Received");
  	end
	
endmodule
*/

/*
module test;
  event e;

  initial begin
    #10 -> e;
    #10 -> e;
  end

  initial begin
		repeat(2)
		begin
    			@e;
    			$display($time," Received");
		end
  	end
	
endmodule
*/


/*
module test;
  event e;

  initial begin
    fork
      begin
        #10 ->e;
        $display($time," trigger");
      end

      begin
        repeat(2) begin
          @e;
          $display($time, " Wait");
        end
      end
    join
  end
endmodule
*/

/*
module test;
  event e;

  initial begin
    fork
      begin
		repeat(2)
		begin
			#10 ->e;
			$display($time," trigger");
		  end
		  end

		  begin
			repeat(2) begin
			  @e;
			  $display($time, " Wait");
			end
		  end
    join_none
  end
endmodule
*/

