`timescale 1ns/1ps
module tb_ripple_adder4;
  logic [3:0] A, B;
  logic       CIN;
  logic [3:0] S;
  logic       COUT;

  ripple_adder4 dut (.A(A), .B(B), .CIN(CIN), .S(S), .COUT(COUT));

  task automatic run_vec(input [3:0] a, b, input cin);
    A = a; B = b; CIN = cin;
    #1;
    $display("A=%0d (%b)  B=%0d (%b)  CIN=%0d -> COUT=%0b, S=%04b, {COUT, S}=%0d",
      a, a, b, b, cin, COUT, S, {COUT, S});
  endtask

  initial begin
    $display("---- 4-bit Ripple Carry Adder Test ----");

    // initialize 
    A=0; B=0; CIN=0; 
    #1;

    run_vec(4'd1 , 4'd3 , 1'b0);
    run_vec(4'd11, 4'd9 , 1'b0);
    run_vec(4'd7 , 4'd13, 1'b0);
    run_vec(4'd15, 4'd1 , 1'b0);

    $display("All tests completed.");
    $finish;
  end
endmodule
