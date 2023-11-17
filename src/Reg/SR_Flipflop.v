// (posedge clk, S=1) set   -> Q = 1
// (posedge clk, R=1) reset -> Q = 0
// (S=1&&R=1) invalid 
// hold  -> Q = Q
module SR_Flipflop (
    input  S,
    input  R,
    input  clk,
    output Q,
    output Q_bar
);

    reg posedge_clk;
    always @(posedge clk) begin
        posedge_clk = 1;
        #1 posedge_clk = 0;
    end

    wire S_bar, R_bar;
    nand (S_bar, S, posedge_clk);
    nand (R_bar, R, posedge_clk);
    SR_Latch u_SR_Latch (
        .S    (S_bar),
        .R    (R_bar),
        .Q    (Q),
        .Q_bar(Q_bar)
    );
endmodule


module SR_Flipflop_tb;
    reg S, R, clk;
    wire Q, Q_bar;
    SR_Flipflop SR_Flipflop_0(S, R, clk, Q, Q_bar);
    
    initial begin
        $dumpfile("SR_Flipflop.vcd");
        $dumpvars(1, SR_Flipflop_tb);
        $display("S R clk | Q Q_bar");
        $monitor("%b %b   %b | %b %b", S, R, clk, Q, Q_bar);
        S = 0; R = 0; clk = 0;
        #10 S = 1; R = 0; clk = 0;
        #10 S = 1; R = 0; clk = 1;
        #10 S = 1; R = 0; clk = 0;

        #10 S = 0; R = 1; clk = 0;
        #10 S = 0; R = 1; clk = 1;
        #10 S = 0; R = 1; clk = 0;
    end
endmodule