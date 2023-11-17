// (S=0) set   -> Q = 1, Q_bar = 0
// (R=0) reset -> Q = 0, Q_bar = 1
// (S=1&&R=1) hold    -> Q = Q, Q_bar = Q_bar
// (S=0&&R=0) invalid -> Q = 0, Q_bar = 0
module SR_Latch (
    input  S,
    input  R,
    output Q,
    output Q_bar
);
    nand(Q, S, Q_bar);
    nand(Q_bar, R, Q);
endmodule


module SR_Latch_tb();
    reg R, S;
    wire Q, Q_bar;
    SR_Latch SR_Latch_0(R, S, Q, Q_bar);
    
    initial begin
        $dumpfile("SR_Latch.vcd");
        $dumpvars(1, SR_Latch_tb);
        $display("R S | Q Q_bar");
        $monitor("%b %b | %b %b", R, S, Q, Q_bar);
        R = 1; S = 1;
        #10 R = 1; S = 1;
        #10 R = 1; S = 0;
        #10 R = 1; S = 1;

        #10 R = 1; S = 1;
        #10 R = 0; S = 1;
        #10 R = 1; S = 1;
    end
endmodule