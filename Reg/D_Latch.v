// en=1  : write -> Q = D
// en=0  : hold
module D_Latch (
    input  en,
    input  D,
    output Q
);
    wire S, R;
    nand (S, D, en);
    nand (R, ~D, en);
    SR_Latch u_SR_Latch (
        .R(R),
        .S(S),
        .Q(Q)
    );
endmodule

module D_Latch_tb;
    reg en, D;
    wire Q;
    D_Latch D_Latch_0 (
        .en(en),
        .D (D),
        .Q (Q)
    );

    initial begin
        #10 begin // write 0
            en = 1;
            D  = 0;
        end
        #10 begin // hold
            en = 0;
            D  = 0;
        end
        #10 begin // hold
            en = 0;
            D  = 1;
        end
        #10 begin // hold
            en = 0;
            D  = 0;
        end
        #10 begin // write 0
            en = 1;
            D  = 0;
        end
        #10 begin // write 1
            en = 1;
            D  = 1;
        end
        #10 begin // write 0
            en = 1;
            D  = 0;
        end
        #10 begin // write 1
            en = 1;
            D  = 1;
        end
        #10 begin // hold
            en = 0;
            D  = 1;
        end
        #10 begin // hold
            en = 0;
            D  = 0;
        end
        #10 begin
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
