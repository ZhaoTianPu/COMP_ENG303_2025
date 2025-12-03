`timescale 1ns/1ps
module Vredge (clk, rst, X, EDGE);
    input  wire clk;
    input  wire rst;
    input  wire X;
    output  EDGE;
    localparam A_00 = 2'b00; // state A: two 0s
    localparam B_01 = 2'b01; // state B: one 0, one 1
    localparam C_10 = 2'b10; // state C: one 1, one 0
    localparam D_11 = 2'b11; // state D: two 1s

    reg [1:0] state;

    assign EDGE = (state == B_01) || (state == C_10);

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= A_00;
        else
            case (state)
                A_00:
                    state <= X ? B_01 : A_00;
                B_01:
                    state <= X ? D_11 : C_10;
                C_10:
                    state <= X ? B_01 : A_00;
                D_11:
                    state <= X ? D_11 : C_10;
            endcase
        end

endmodule
