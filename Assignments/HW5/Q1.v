`timescale 1ns/1ps

module mac (
    input  wire              clk,
    input  wire              rstb,       // active low reset
    input  wire signed [3:0] IN,         // input activation
    input  wire signed [3:0] W,          // input weight
    output reg  signed [11:0] OUT        // 12-bit signed output
);

    // internal pipeline registers
    reg signed [7:0] mult_reg;           // holds product
    reg signed [11:0] acc_reg;           // accumulator
    reg [3:0] cycle_count;               // count cycles

    // stage 1: multiply
    always @(posedge clk or negedge rstb) begin
        if (!rstb)
            mult_reg <= 8'sd0;
        else
            mult_reg <= IN * W;
    end

    // stage 2: accumulate
    always @(posedge clk or negedge rstb) begin
        if (!rstb) begin
            acc_reg <= 12'sd0;
            cycle_count <= 4'd0;
            OUT <= 12'sd0;
        end
        else begin
            if (cycle_count == 4'd8) begin
                // after 9th accumulation, output result and reset accumulator
                OUT <= acc_reg + mult_reg;
                acc_reg <= 12'sd0;
                cycle_count <= 4'd0;
            end else begin
                acc_reg <= acc_reg + mult_reg;
                cycle_count <= cycle_count + 1'b1;
            end
        end
    end

endmodule