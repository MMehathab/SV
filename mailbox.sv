/*module top;

class trans;

	rand bit[4:0] a;

endclass

class generator;

	mailbox#(trans) mbx;
	trans h;

	function new(mailbox#(trans) mbx);
		this.mbx = mbx;
	endfunction

	task run;
	
		repeat(10)
		begin
			h=new;
			assert(h.randomize);
			$display("generator datas%p",h);
			mbx.put(h);
		end
	
	endtask

endclass

class driver;
	
	mailbox#(trans) mbx;	
	trans h;

	function new(mailbox#(trans) mbx);
		this.mbx=mbx;
	endfunction

	task run;

		repeat(10)
		begin
			mbx.get(h);
			$display("driver datas%p",h);
		end

	endtask

endclass

class env;
	
	mailbox#(trans) mbx;

	generator gen;
	driver drv;

	task build();

		mbx = new;
		gen = new(mbx);
		drv = new(mbx);

	endtask

	task run;

		fork
			gen.run;
			drv.run;
		join

	endtask

endclass

env e;

initial
begin
	e = new;
	e.build;
	e.run;
end

endmodule*/


/*module test;

  mailbox mb = new();
  int data;

  initial begin
    #5 mb.put(100);
  end

  initial begin
    $display("Waiting to peek...");
    mb.peek(data);   // waits until data is available
    $display("Peeked = %0d at time %0t", data, $time);

    mb.get(data);    // now remove it
    $display("Got = %0d at time %0t", data, $time);
  end

endmodule*/


/* example on try peek*/
/*module test;

  mailbox mb = new();
  int data;

  initial begin
    #5 mb.put(200);
  end

  initial
	begin
	
		if(mb.try_peek(data))
			$display("Peeked = %0d",data);
		else
			$display("No data at time %0t", $time);
			
		#6;
		
		if(mb.try_peek(data))
			$display("Peeked = %0d at time %0t", data, $time);

    mb.get(data); 
  end

endmodule*/


/* exampke on try_put and try_get*/
/*module test;

  mailbox #(int) mb;
  int data;

  initial begin
    mb = new(1); 

    fork

      // ---------------- PRODUCER ----------------
      begin
        int i = 10;

        repeat(3) 
			begin

			if (mb.try_put(i))
				$display("Put %0d SUCCESS at time %0t", i, $time);
			else
				$display("Put %0d FAILED (mailbox full) at time %0t", i, $time);

			i = i + 10;
			#2;
			end
      end

      // ---------------- CONSUMER ----------------
      begin
        repeat(3)
			begin
				#1;
				if (mb.try_get(data))
					$display("Got %0d SUCCESS at time %0t", data, $time);
				else
					$display("Get FAILED (mailbox empty) at time %0t", $time);
			end
      end

    join

  end

endmodule
*/