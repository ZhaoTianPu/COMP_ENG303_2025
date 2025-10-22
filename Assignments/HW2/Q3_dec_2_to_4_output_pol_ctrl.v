`timescale 1ns/1ps
module dec_2_to_4_output_pol_ctrl (
    input A0, A1, A2,           
    output Y0, Y1, Y2, Y3
);
    // inverters and the and gates
    wire d0, d1, d2, d3;
    assign d0 = (~A1 & ~A0);
    assign d1 = (~A1 &  A0);
    assign d2 = ( A1 & ~A0);
    assign d3 = ( A1 &  A0);

    // xors
    assign Y0 = d0 ^ A2;
    assign Y1 = d1 ^ A2;
    assign Y2 = d2 ^ A2;
    assign Y3 = d3 ^ A2;
endmodule