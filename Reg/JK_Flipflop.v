// J=0 && K=0  : hold
// J=1 && K=0  : set
// J=0 && K=1  : reset
// J=1 && K=1  : toggle
module JK_Flipflop (
    input clk,
    input J,
    input K,
    output reg Q
);
    always @(posedge clk)
        case ({
            J, K
        })
            2'b00: Q <= Q;
            2'b01: Q <= 1'b0;
            2'b10: Q <= 1'b1;
            2'b11: Q <= ~Q;
        endcase
endmodule



module JK_Flipflop_tb;
    reg J, K, clk;
    wire Q;
    JK_Flipflop JK_Flipflop_0 (
        .clk(clk),
        .J  (J),
        .K  (K),
        .Q  (Q)
    );

    initial begin
        #10 begin // set
            clk = 0;
            J   = 1;
            K   = 0;
            #20 clk = 1;
        end
        #10 begin
            clk = 0;
            J   = 0;
            K   = 0;
            #20 clk = 1;
        end

        #10 begin // reset
            clk = 0;
            J   = 0;
            K   = 1;
            #20 clk = 1;
        end
        #10 begin
            clk = 0;
            J   = 0;
            K   = 0;
            #20 clk = 1;
        end

        #10 begin // toggle
            clk = 0;
            J   = 1;
            K   = 1;
            #20 clk = 1;
        end
        #10 begin
            clk = 0;
            J   = 0;
            K   = 0;
            #20 clk = 1;
        end

        #10 begin // toggle
            clk = 0;
            J   = 1;
            K   = 1;
            #20 clk = 1;
        end
        #10 begin
            clk = 0;
            J   = 0;
            K   = 0;
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
