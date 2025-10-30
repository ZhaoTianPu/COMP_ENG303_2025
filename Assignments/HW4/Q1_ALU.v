//============================================================
// 8-bit ALU (unsigned inputs), F[2:0] selects operation
// F=000: Q=a+b              (Cout = carry-out)
// F=001: Q=a-b              (Cout = borrow   ; 1 if a<b, else 0)
// F=010: Q=a OR  b
// F=011: Q=a AND b
// F=100: Q=a XOR b
// F=101: Q=NOT a
// F=110: Q=arithmetic left  shift a by 1  (<<1; LSB=0)
// F=111: Q=arithmetic right shift a by 1  (>>1; MSB holds sign bit a[7])
//============================================================
`timescale 1ns/1ps
module alu8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [2:0] F,
    output reg  [7:0] Q,
    output reg        Cout // carry-out for add, borrow for sub
);
    // Internal 9-bit adders for proper carry/borrow handling
    wire [8:0] add9 = {1'b0, a} + {1'b0, b};
    wire [8:0] sub9 = {1'b0, a} + {1'b0, ~b} + 9'b000000001; 

    always @* begin
        Q    = 8'h00;
        Cout = 1'b0;

        case (F)
            3'b000: begin // a + b
                Q    = add9[7:0];
                Cout = add9[8]; // true carry-out
            end
            3'b001: begin // a - b
                Q    = sub9[7:0];
                Cout = ~sub9[8]; // borrow = NOT(carry-out of a + ~b + 1)
            end
            3'b010: begin // a OR b
                Q    = a | b;
                Cout = 1'b0;
            end
            3'b011: begin // a AND b
                Q    = a & b;
                Cout = 1'b0;
            end
            3'b100: begin // a XOR b
                Q    = a ^ b;
                Cout = 1'b0;
            end
            3'b101: begin // NOT a
                Q    = ~a;
                Cout = 1'b0;
            end
            3'b110: begin // arithmetic left shift by 1 (same as logical for 2's comp)
                Q    = {a[6:0], 1'b0};
                Cout = 1'b0;
            end
            3'b111: begin // arithmetic right shift by 1 (preserve sign bit)
                Q    = {a[7], a[7:1]};
                Cout = 1'b0;
            end
            default: begin
                Q    = 8'h00;
                Cout = 1'b0;
            end
        endcase
    end
endmodule
