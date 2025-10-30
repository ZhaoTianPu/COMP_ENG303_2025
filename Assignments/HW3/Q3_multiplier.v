// Q3_multiplier.v
`timescale 1ns/1ps
module multiplier_3x3 (
  input  [2:0] A,
  input  [2:0] B,
  output [5:0] P
);
  // intermediate products
  wire [5:0] P0, P1, P2;
  // widen B
  wire [5:0] B_6bit;
  
  assign B_6bit = {3'b0, B};
  
  // multiply A[0] by B
  assign P0 = A[0]? B_6bit : 6'b0;
  assign P1 = A[1]? B_6bit << 1 : 6'b0;
  assign P2 = A[2]? B_6bit << 2 : 6'b0;
  assign P = P0 + P1 + P2;
endmodule