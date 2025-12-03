`timescale 1ns/1ps

module tb_Vredge;

    reg clk;
    reg rst;
    reg X;
    wire EDGE;

    Vredge dut (
        .clk(clk),
        .rst(rst),
        .X(X),
        .EDGE(EDGE)
    );

    // clock generation: 1 GHz => 1 ns period
    always #0.5 clk = ~clk;

    initial begin
        clk = 1;
        X = 0;
        rst = 1;
        #0.1;
        rst = 0;
        #0.9; 
        X = 1;
        #3;
        X = 0;
        #2; 
        X = 1;
        #1;
        X = 0;
        #1;
        X = 1;
        $finish;
    end

endmodule
