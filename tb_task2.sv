module tb_task2 ();
    reg clk=0;
    reg [7:0] N;
    reg resetb=0;
    reg start;
    wire done;
    wire [2:0] state;
    wire [7:0] R, tag;

    always #5 clk = ~clk;  // Create clock with period=10

    initial begin
        #0 resetb = 0; N <= 7; start <= 0;
        #10 resetb <= 1;
      	#20 start <= 1;
      	#10 start <= 0;
        wait( done==1 ) $display("done at time (%0d ps), N=%0d, R=%0d", $time, N, R);
	#20 N <= 16;
        start <= 1;
        #10 start <= 0;
        #10 wait( done==1 ) $display("done at time (%0d ps), N=%0d, R=%0d", $time, N, R);
        $display ("Simulation end time is (%0d ps)", $time);
        #30 $finish;
    end

    task2 dut( .* );
endmodule