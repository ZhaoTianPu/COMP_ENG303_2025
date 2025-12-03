`timescale 1ns/1ps
module Vr3bitctrdec ( CLK, CLR, S_L );
    input CLK, CLR, S_L;
    output reg [0:7] S_L;
    reg [2:0] Q;
    integer i;

    always @ (posedge CLK) 
        if (CLR) Q <= 3'd0;
        else Q <= Q+1;

    always @ (Q) begin
        S_L = 8'b11111111;
        for (i=0; i<=7; i=i+1)
            if (i == Q) S_L[i] = 0;
    end
endmodule

module Vr3bitctrdecMod ( CLK, CLR, S_L );
    input CLK, CLR, S_L;
    output reg [0:7] S_L;
    reg [2:0] Q;
    integer i;

    always @ (posedge CLK) 
        if (CLR) Q <= 3'd0;
        else Q <= Q+1;
        S_L = 8'b11111111;
        for (i=0; i<=7; i=i+1)
            if (i == Q) S_L[i] = 0;
endmodule