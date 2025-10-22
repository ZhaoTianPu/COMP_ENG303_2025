`timescale 1ns/1ps

module tb;
  // DUT input signals
  reg  A0, A1, A2;
  // DUT output signals
  wire Y0, Y1, Y2, Y3;
  // index for loop
  integer i;

  // DUT
  dec_2_to_4_output_pol_ctrl dut (
    .A0(A0), .A1(A1), .A2(A2),
      .Y0(Y0), .Y1(Y1), .Y2(Y2), .Y3(Y3)
  );

  // print table
  initial begin
  $display("A2 A1 A0 | Y3 Y2 Y1 Y0");
    $display("-----------------------");

    // create all combinations for the input
    for (i = 0; i < 8; i = i + 1) 
      begin
          {A2, A1, A0} = i[2:0];
          #1; // wait 1ns
          $display(" %b   %b  %b |  %b  %b  %b  %b",
                  A2, A1, A0, Y3, Y2, Y1, Y0);
      end
    $display("-----------------------");
    $finish;
  end
endmodule
