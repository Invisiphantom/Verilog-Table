// (en=1) write -> Q = D
// (en=0) hold  -> Q = Q
module D_Latch (
    input  D,
    input  en,
    output Q
);
    wire S, R;
    nand(S, D, en);
    nand(R, ~D, en);
    SR_Latch u_SR_Latch (
        .R    (R),
        .S    (S),
        .Q    (Q),
        .Q_bar()
    );
endmodule

module D_Latch_tb;
    reg D, en;
    wire Q, Q_bar;
    D_Latch D_Latch_0(D, en, Q);
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
        $display("D en | Q");
        $monitor("%b  %b | %b", D, en, Q);
        D = 0; en = 1;
        #10 D = 0; en = 1;
        #10 D = 1; en = 1;
        #10 D = 0; en = 1;
        #10 D = 1; en = 1;

        #10 D = 0; en = 0;
        #10 D = 1; en = 0;
        #10 D = 0; en = 0;
    end
endmodule