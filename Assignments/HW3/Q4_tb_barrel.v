`timescale 1ns/1ps
module tb_barrel;
  reg [15:0] DIN;
  reg [3:0] S;
  reg [2:0] C;
  wire [15:0] DOUT;
  integer i;
  Vrbarrel16 dut (.DIN(DIN), .S(S), .C(C), .DOUT(DOUT));

  initial begin
    $display("---- 16-bit Barrel Shifter Test ----");

    // initialize 
    DIN=0; S=0; C=0; 
    #1;
    // DIN = [1001011101010011]
    // S = [0011]
    // run all possible C values
    DIN = 16'b1001011101010011;
    S = 4'b0011;
    $display("DIN = %b", DIN);
    $display("S = %0d (%b)", S, S);
    #1
    for (i = 0; i < 6; i = i + 1) begin
      C = i;
      #1;
      $display("C=%b  -> DOUT=%b",
        C, DOUT);
    end

    $display("All tests completed.");
    $finish;
  end
endmodule
