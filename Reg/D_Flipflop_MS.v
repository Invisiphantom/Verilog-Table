// posedge clk  : write -> Q = D
// other        : hold
module D_Flipflop_MS (
    input  clk,
    input  D,
    output Q
);
    wire Q_t;
    D_Latch DL1 (
        .en(~clk),
        .D (D),
        .Q (Q_t)
    );
    D_Latch DL2 (
        .en(clk),
        .D (Q_t),
        .Q (Q)
    );
endmodule


module D_Flipflop_MS_tb;
    reg clk, D;
    wire Q;

    D_Flipflop_MS D_Flipflop_MS (
        .clk(clk),
        .D  (D),
        .Q  (Q)
    );

    initial begin
        #10 begin
            clk = 0;
            D   = 0;
            #20 clk = 1;
        end

        #10 begin
            clk = 0;
            D   = 1;
            #20 clk = 1;
        end

        #10 begin
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
