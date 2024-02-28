// posedge clk  : write -> Q = D
// other        : hold
module D_Flipflop (
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule



module D_Flipflop_tb;
    reg D, clk;
    wire Q;
    D_Flipflop D_Flipflop (
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
