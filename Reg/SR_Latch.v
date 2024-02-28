// S=0         : set   -> Q = 1
// R=0         : reset -> Q = 0
// S=1 && R=1  : hold
// S=0 && R=0  : invalid
module SR_Latch (
    input  S,
    input  R,
    output Q,
    output Q_n
);
    nand (Q, S, Q_n);
    nand (Q_n, R, Q);
endmodule


module SR_Latch_tb ();
    reg S, R;
    wire Q, Q_n;
    SR_Latch SR_Latch_0 (
        .S  (S),
        .R  (R),
        .Q  (Q),
        .Q_n(Q_n)
    );

    initial begin
        #10 begin // invalid
            S = 0;
            R = 0;
        end

        #10 begin // set
            S = 0;
            R = 1;
        end

        #10 begin // hold
            S = 1;
            R = 1;
        end

        #10 begin // reset
            S = 1;
            R = 0;
        end

        #10 begin // hold
            S = 1;
            R = 1;
        end

        #10 begin
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
