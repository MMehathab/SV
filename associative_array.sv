
/*
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
*/


/**** find max value *******/

/*
module tb;
int aa[int];
int max;

function int get_max();

    int idx;
    int max;

    aa.first(idx);
    max = aa[idx];

    foreach(aa[idx])
        if(aa[idx] > max)
            max = aa[idx];

    return max;

endfunction

initial
	begin	
		repeat(5)
			begin
				aa[$urandom_range(5,50)]=$urandom_range(0,999);
				// or //
				//   aa[10]=500;
				//	aa[20]=100;
				//	aa[30]=700;
			end
			
			foreach(aa[idx])
			$display("aa[%0d] = %0d",idx, aa[idx]);
			
		max=get_max();
		
		$display("max value=%0d",max);
	end
endmodule
*/



/*** find second largest value***/
/*

module tb;

int aa[int];

function int second_max();

    int max1, max2;
    bit first = 1;

    foreach(aa[idx])
    begin
        if(first)
        begin
            max1  = aa[idx];
            max2  = aa[idx];
            first = 0;
        end
        else
        begin
            if(aa[idx] > max1)
            begin
                max2 = max1;
                max1 = aa[idx];
            end
            else if(aa[idx] > max2)
                max2 = aa[idx];
        end
    end

    return max2;

endfunction

initial
begin

    aa[10] = 100;
    aa[20] = 500;
    aa[30] = 300;
    aa[40] = 900;
    aa[50] = 700;

    foreach(aa[idx])
        $display("aa[%0d] = %0d", idx, aa[idx]);

    $display("\nSecond Max = %0d", second_max());

end

endmodule
	*/
	
/// Store All Even Values from Associative Array into Queue
/*	
module tb;

int aa[int];
int even_q[$];

function automatic void get_even(ref int q[$]);  // ref keyword, pass by reference. so even_q will also update

    foreach(aa[idx])
        if(aa[idx]%2==0)
            q.push_back(aa[idx]);

endfunction



initial 
begin

    aa[10]=100;
    aa[20]=201;
    aa[30]=300;
    aa[40]=401;

    get_even(even_q);

    foreach(even_q[i])
	$display("%0d",even_q[i]);

end

endmodule
*/

/****Queue of Values Greater Than Average*****/

module tb;

int aa[int];
int gt_q[$];

function automatic void gt_avg(ref int q[$]);

    int sum = 0;
    int avg;

    foreach(aa[idx])
        sum = sum+aa[idx];

    avg = sum / aa.num();

    foreach(aa[idx])
        if(aa[idx] > avg)
            q.push_back(aa[idx]);

endfunction

initial 
begin

    aa[10] = 100;
    aa[20] = 200;
    aa[30] = 300;
    aa[40] = 400;
    aa[50] = 500;

    foreach(aa[idx])
        $display("aa[%0d] = %0d",idx, aa[idx]);

    gt_avg(gt_q);

    $display("\nValues Greater Than Average:");

    foreach(gt_q[i])
        $display("gt_q[%0d] = %0d",i, gt_q[i]);

end

endmodule