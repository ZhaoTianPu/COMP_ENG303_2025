module full_adder (
    input  logic A,
    input  logic B,
    input  logic CIN,
    output logic S,
    output logic COUT
);
    assign S    = A ^ B ^ CIN;
    assign COUT = (A & B) | (A & CIN) | (B & CIN);
endmodule

module ripple_adder4 (
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic       CIN,     // usually 0
    output logic [3:0] S,
  output logic COUT
);
    wire C1, C2, C3;

  assign S[0] = A[0] ^ B[0] ^ CIN;
  assign C1 = (A[0] & B[0]) | (A[0] & CIN) | (B[0] & CIN);
    assign S[1] = A[1] ^ B[1] ^ C1;
  assign C2 = (A[1] & B[1]) | (A[1] & C1) | (B[1] & C1);
    assign S[2] = A[2] ^ B[2] ^ C2;
  assign C3 = (A[2] & B[2]) | (A[2] & C2) | (B[2] & C2);
    assign S[3] = A[3] ^ B[3] ^ C3;
  assign COUT = (A[3] & B[3]) | (A[3] & C3) | (B[3] & C3);
endmodule