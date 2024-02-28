// (posedge clk) write -> Q = D
// hold  -> Q = Q
module D_Flipflop_MS (
    input  D,
    input  clk,
    output Q
);
    wire D1, clk1, Q1;
    assign D1 = D;
    assign clk1 = ~clk;
    D_Latch u1_D_Latch (
        .D  (D1),
        .clk(clk1),
        .Q  (Q1)
    );

    wire D2, clk2, Q2;
    assign D2 = Q1;
    assign clk2 = ~clk1;
    D_Latch u2_D_Latch (
        .D  (D2),
        .clk(clk2),
        .Q  (Q)
    );
    assign Q = Q2;
endmodule


module D_Flipflop_MS_tb;
    reg D, clk;
    wire Q;
    D_Flipflop_MS D_Flipflop_MS_0 (D, clk, Q);

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
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
