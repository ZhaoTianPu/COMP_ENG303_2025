`timescale 1ns/1ps
module tb_multiplier_3x3;
  reg [2:0] A, B;
  wire [5:0] P;
  integer i;
  multiplier_3x3 dut (.A(A), .B(B), .P(P));

  task run_vec;
    input [2:0] a, b;
    begin
      A = a; B = b;
      #1;
      $display("A=%0d (%b)  B=%0d (%b)  -> P=%0d (%b)",
        a, a, b, b, P, P);
    end
  endtask

  initial begin
    $display("---- 3-bit Multiplier Test ----");

    // initialize 
    A=0; B=0; 
    #1;
    // test 1: set A = 5, loop over all possible B
    $display("test 1: A=5, B runs from 0 to 7");
    for (i = 0; i < 8; i = i + 1) begin
      A = 5;
      B = i;
      #1;
      $display("A=%0d (%b)  B=%0d (%b)  -> P=%0d (%b)",
        A, A, B, B, P, P);
    end
    // test 2: set B = 2, loop over all possible A
    $display("test 2: A runs from 0 to 7, B=2");
    for (i = 0; i < 8; i = i + 1) begin
      A = i;
      B = 2;
      #1;
      $display("A=%0d (%b)  B=%0d (%b)  -> P=%0d (%b)",
        A, A, B, B, P, P);
    end

    $display("All tests completed.");
    $finish;
  end
endmodule
