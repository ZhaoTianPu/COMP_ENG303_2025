`timescale 1ns/1ps

module tb_alu8;
    reg  [7:0] a, b;
    reg  [2:0] F;
    wire [7:0] Q;
    wire       Cout;

    alu8 dut(.a(a), .b(b), .F(F), .Q(Q), .Cout(Cout));

    // Reference model for checks
    function [8:0] add9(input [7:0] x, input [7:0] y);
        add9 = {1'b0,x} + {1'b0,y};
    endfunction
    function [8:0] sub9(input [7:0] x, input [7:0] y);
        sub9 = {1'b0,x} + {1'b0,~y} + 9'd1; // x - y
    endfunction

    task check(input [7:0] ta, input [7:0] tb, input [2:0] tF);
        reg [7:0] expected_Q;
        reg       expected_C;
        reg [8:0] tmp;
        begin
            a = ta; b = tb; F = tF; 
            #1; 

            case (tF)
                3'b000: begin 
                    tmp = add9(ta,tb); 
                    expected_Q = tmp[7:0]; 
                    expected_C = tmp[8]; 
                end
                3'b001: begin 
                    tmp = sub9(ta,tb); 
                    expected_Q = tmp[7:0]; 
                    expected_C = ~tmp[8]; 
                end
                3'b010: begin 
                    expected_Q = ta | tb; 
                    expected_C = 1'b0; 
                end
                3'b011: begin 
                    expected_Q = ta & tb; 
                    expected_C = 1'b0; 
                end
                3'b100: begin 
                    expected_Q = ta ^ tb; 
                    expected_C = 1'b0; 
                end
                3'b101: begin 
                    expected_Q = ~ta; 
                    expected_C = 1'b0; 
                end
                3'b110: begin 
                    expected_Q = {ta[6:0],1'b0}; 
                    expected_C = 1'b0; 
                end
                3'b111: begin 
                    expected_Q = {ta[7], ta[7:1]}; 
                    expected_C = 1'b0; 
                end
            endcase

            if (Q!==expected_Q || Cout!==expected_C) begin
                $display("FAIL  F=%03b  a=%0d (%08b)  b=%0d (%08b)  -> Q=%0d (%08b) Cout=%0b  expected_Q=%0d (%08b) expected_C=%0b",
                tF, ta, ta, tb, tb, Q, Q, Cout, expected_Q, expected_Q, expected_C);
            end else begin
                $display("PASS  F=%03b  a=%0d (%08b)  b=%0d (%08b)  -> Q=%0d (%08b)  Cout=%0b",
                tF, ta, ta, tb, tb, Q, Q, Cout);
            end
        end
    endtask

    initial begin
        $display("---- 8-bit ALU Test ----");
        // ADD tests (including 250+5 & 250+6)
        check(8'd12,  8'd34, 3'b000);
        check(8'd250, 8'd5,  3'b000); // expect Cout=0
        check(8'd250, 8'd6,  3'b000); // expect Cout=1

        // SUB tests (7-3 -> borrow 0; 3-7 -> borrow 1)
        check(8'd7,   8'd3,  3'b001);
        check(8'd3,   8'd7,  3'b001);

        // Logic ops
        check(8'b00101110,  8'b00011010, 3'b010); // OR
        check(8'b00101110,  8'b00011010, 3'b011); // AND
        check(8'b00101110,  8'b00011010, 3'b100); // XOR
        check(8'b00101110,  8'b00011010, 3'b101); // NOT

        // Shifts (show arithmetic right keeps MSB)
        check(8'b10110100,  8'b01010101, 3'b110); // <<1
        check(8'b10110100,  8'b01010101, 3'b111); // >>>1 (MSB stays 1)

        $display("All tests done.");
        #5 $finish;
    end
endmodule
