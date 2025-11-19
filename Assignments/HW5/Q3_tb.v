`timescale 1ns/1ps

module tb_button_sync;

    reg clk;
    reg rst;
    reg bi;
    wire bo;

    button_sync dut (
        .clk(clk),
        .rst(rst),
        .bi(bi),
        .bo(bo)
    );

    // clock generation: 1 GHz => 1 ns period
    always #0.5 clk = ~clk;

    initial begin

        clk = 0;
        bi = 0;
        rst = 0;
		$display("cycle 0: bi = %d, bo = %d", bi, bo);
        #0.5; 
        bi = 1;
        $display("cycle 0.5: bi = %d, bo = %d", bi, bo);
        #0.5; // cycle 1 start
        bi = 1;
        $display("cycle 1: bi = %d, bo = %d", bi, bo);
        #0.5;
        bi = 1;
        $display("cycle 1.5: bi = %d, bo = %d", bi, bo);
        #0.5; // cycle 2 start
        bi = 1;
        $display("cycle 2: bi = %d, bo = %d", bi, bo);
        #0.5;
        bi = 1;
        $display("cycle 2.5: bi = %d, bo = %d", bi, bo);
        #0.5; // cycle 3 start
        bi = 1;
        $display("cycle 3: bi = %d, bo = %d", bi, bo);
        #0.5; 
        bi = 1;
        $display("cycle 3.5: bi = %d, bo = %d", bi, bo);
        #0.5; // cycle 4 start
        bi = 1;
        $display("cycle 4: bi = %d, bo = %d", bi, bo);
        #0.5; // turn off button
        bi = 0;
        $display("cycle 4.5: bi = %d, bo = %d", bi, bo);
        #0.5; // cycle 5 start
        bi = 0;
        $display("cycle 5: bi = %d, bo = %d", bi, bo);

        $finish;
    end

endmodule
