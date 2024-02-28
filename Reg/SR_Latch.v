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
    reg R, S;
    wire Q, Q_n;
    SR_Latch SR_Latch_0 (
        R,
        S,
        Q,
        Q_n
    );

    initial begin
        
    end
endmodule
