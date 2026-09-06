

// create database bprn 25 batch of 5 people

//using overriding constructor

/*class bprn25;
int sslc,dip,be;
string name,email,contact_no;

function new(string lname,lemail,lcontact,int lsslc,ldip,lbe);
	name=lname;
	email=lemail;
	contact_no=lcontact;
	sslc=lsslc;
	dip=ldip;
	be=lbe;
endfunction

function void disp();
$display("name=%s,email=%s,contact_no=%s,sslc=%0d,dip=%0d,be=%0d",name,email,contact_no,sslc,dip,be);
endfunction

endclass:bprn25

module test();
 bprn25 bp[5];
initial
  begin
	bp[0]=new("s1","s1@gmail.com","9876543210",80,70,90);
	bp[1]=new("s2","s2@gmail.com","9876543211",60,70,90);
	bp[2]=new("s3","s3@gmail.com","9876543212",90,80,80);
 end
endmodule*/



//using default construct

class bprn25;
int sslc,dip,be;
string name,email,contact_no;

function data (string lname,lemail,lcontact,int lsslc,ldip,lbe);
	name=lname;
	email=lemail;
	contact_no=lcontact;
	sslc=lsslc;
	dip=ldip;
	be=lbe;
endfunction

function void disp();
$display("name=%s,email=%s,contact_no=%s,sslc=%0d,dip=%0d,be=%0d",name,email,contact_no,sslc,dip,be);
endfunction

endclass:bprn25

module test();
 bprn25 bp[2];
initial
  begin
	bp[0]=new;
	bp[0].data("s1","s1@gmail.com","9876543210",80,70,90);
	bp[1]=new;
	bp[1].data("s2","s2@gmail.com","9876543211",60,70,90);
	/*bp[2]=new("s3","s3@gmail.com","9876543212",90,80,80);
	bp[3]=new("s4","s4@gmail.com","9876543213",78,88,92);
	bp[4]=new("s5","s5@gmail.com","9876543214",65,75,95);*/

	foreach(bp[i])
	bp[i].disp();
  end
endmodule


class transaction;
  bit [3:0]data;
endclass:transaction

transaction th1,th2;

module test();
initial
  begin
	th1=new();
	th1.data=10;
	th2=th1;
	th1=null;
	$display("%0p",th1);
	$display("%0p",th2);
  end
endmodule


class packet;
	task send();
		$display("in class packet");
	endtask
endclass

packet p1;

 module test();
initial
  begin
   	if(p1==null)
    		begin
			$display("p1 pointing to null object");
			p1=new();
			$display("after creating object for p1");
			$display("address of p1=%0d",p1);
			p1.send();
    		end
   	else if(p1!=null)
    		begin
		    	p1.send();
		end
  end
endmodule





class packet;
	int data;
	function new(int d);
		data=d;
	endfunction
endclass

module tb;
	packet p;
	function void update(packet p);
		p.data=p.data+10;
		p=new(100);
		p.data=p.data+20;
		$display("p.data=%0d",p.data);
	
	endfunction
	
initial
  begin
  	p=new(5);
  	update(p);
  	$display("p.data=%0d",p.data);
  	
  end
  
 endmodule
