// (posedge clk) write -> Q = D
// hold  -> Q = Q
module SR_Latch_3 (
    input  S1,
    input  S2,
    input  R,
    output Q,
    output Q_bar
);
    nand (Q, S1, S2, Q_bar);
    nand (Q_bar, R, Q);
endmodule


module SR_Latch_2 (
    input  S,
    input  R,
    output Q,
    output Q_bar
);
    nand (Q, S, Q_bar);
    nand (Q_bar, R, Q);
endmodule


module D_Flipflop (
    input  D,
    input  clk,
    output Q,
    output Q_bar
);
    wire Q1, Q1_bar, Q2, Q2_bar;
    SR_Latch_3 begin_SR (
        .S1(clk),
        .S2(Q2),// Ensure that when Q2 deactivates, Q1 always activates, rid the influence by D's change
        .R(D),
        .Q(Q1),
        .Q_bar(Q1_bar)
    );
    SR_Latch_2 mid_SR (
        .S(clk),
        .R(Q1_bar),
        .Q(Q2),
        .Q_bar(Q2_bar)
    );

    wire final_S, final_R;
    assign final_S = Q2;
    assign final_R = Q1;
    SR_Latch_2 final_SR (
        .S(final_S),
        .R(final_R),
        .Q(Q),
        .Q_bar(Q_bar)
    );
endmodule



module D_Flipflop_tb;
    reg D, clk;
    wire Q, Q_bar;
    D_Flipflop D_Flipflop (
        .D(D),
        .clk(clk),
        .Q(Q),
        .Q_bar(Q_bar)
    );
    initial begin
        $dumpfile("D_Flipflop.vcd");
        $dumpvars(0, D_Flipflop_tb);
        $display("D clk | Q");
        $monitor("%b   %b | %b", D, clk, Q);
        D = 0; clk = 0;
        #10 D = 0; clk = 0;
        #10 D = 0; clk = 1;
        #10 D = 0; clk = 0;
        #10 D = 0; clk = 0;

        #10 D = 1; clk = 0;
        #10 D = 1; clk = 1;
        #10 D = 1; clk = 0;
        #10 D = 1; clk = 0;
    end
endmodule