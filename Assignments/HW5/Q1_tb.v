`timescale 1ns/1ps

module tb_mac;

    reg clk;
    reg rstb;
    reg signed [3:0] IN;
    reg signed [3:0] W;
    wire signed [11:0] OUT;

    mac dut (
        .clk(clk),
        .rstb(rstb),
        .IN(IN),
        .W(W),
        .OUT(OUT)
    );

    // clock generation: 1 GHz => 1 ns period
    always #0.5 clk = ~clk;

    integer i;
    initial begin

        clk = 0;
        rstb = 0;
        IN = 0;
        W = 0;
        #5 rstb = 1; // release reset

        // simulate 20 cycles (two rounds of accumulation)
        for (i = 0; i < 20; i = i + 1) begin
            IN = $random % 8 - 4;  // signed values between -4 and +3
            W  = $random % 8 - 4;
            #1;
            $display("IN = %d, W = %d, OUT = %d", IN, W, OUT);
        end

        #5;
        $finish;
    end

endmodule
