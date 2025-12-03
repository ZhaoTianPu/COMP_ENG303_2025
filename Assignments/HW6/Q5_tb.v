module tb_counters;
    reg CLK=0, CLR=1;
    wire [7:0] S1, S2;

    Vr3bitctrdec     u1(CLK,CLR,S1);
    Vr3bitctrdecMod  u2(CLK,CLR,S2);

    always #5 CLK = ~CLK;

    initial begin
        #12 CLR=0;
        #300 $finish;
    end
endmodule
