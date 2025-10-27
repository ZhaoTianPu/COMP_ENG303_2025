`timescale 1ns/1ps
module Vrbarrel16 (DIN, S, C, DOUT);
    input [15:0] DIN;
    input [3:0] S;
    input [2:0]C;
    output [15:0] DOUT;
    reg [15:0] DOUT;
    parameter Lrotate = 3'b000, //the coding of different shift modes
              Rrotate = 3'b001,
              Llogical = 3'b010,
              Rlogical = 3'b011,
              Larith = 3'b100,
              Rarith = 3'b101;

    function [15:0] Vrol;
      input [15:0] D;
      input [3:0] S;
      integer ii, N;
      reg [15:0] TMPD;
      begin
        N = S;
        TMPD = D;
        for (ii = 1; ii<=N; ii = ii+1)
          TMPD = {TMPD[14:0], TMPD[15]};
        Vrol = TMPD;
      end
    endfunction

    function [15:0] Vror;
      input [15:0] D;
      input [3:0] S;
      integer ii, N;
      reg [15:0] TMPD;
      begin
        N = S;
        TMPD = D;
        for (ii = 1; ii<=N; ii = ii+1)
          TMPD = {TMPD[0], TMPD[15:1]};
        Vror = TMPD;
      end
    endfunction

    function [15:0] Vsll;
      input [15:0] D;
      input [3:0] S;
      integer ii, N;
      reg [15:0] TMPD;
      begin
        N = S;
        TMPD = D;
        for (ii = 1; ii<=N; ii = ii+1)
          TMPD = {TMPD[14:0], 1'b0};
        Vsll = TMPD;
      end
    endfunction

    function [15:0] Vslr;
      input [15:0] D;
      input [3:0] S;
      integer ii, N;
      reg [15:0] TMPD;
      begin
        N = S;
        TMPD = D;
        for (ii = 1; ii<=N; ii = ii+1)
          TMPD = {1'b0, TMPD[15:1]};
        Vslr = TMPD;
      end
    endfunction

    function [15:0] Vsla;
      input [15:0] D;
      input [3:0] S;
      integer ii, N;
      reg [15:0] TMPD;
      begin
        N = S;
        TMPD = D;
        for (ii = 1; ii<=N; ii = ii+1)
          TMPD = {TMPD[14:0], 1'b0};
        Vsla = TMPD;
      end
    endfunction

    function [15:0] Vsra;
      input [15:0] D;
      input [3:0] S;
      integer ii, N;
      reg [15:0] TMPD;
      begin
        N = S;
        TMPD = D;
        for (ii = 1; ii<=N; ii = ii+1)
          TMPD = {TMPD[15], TMPD[15:1]};
        Vsra = TMPD;
      end
    endfunction


    always @ (DIN or S or C)
      case (C)
        Lrotate: DOUT = Vrol(DIN, S);
        Rrotate: DOUT = Vror(DIN, S);
        Llogical: DOUT = Vsll(DIN, S);
        Rlogical: DOUT = Vslr(DIN, S);
        Larith: DOUT = Vsla(DIN, S);
        Rarith: DOUT = Vsra(DIN, S);
        default: DOUT = DIN;
      endcase
  endmodule