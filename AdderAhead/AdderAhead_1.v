module AdderAhead_1 (
    input  a_i,
    input  b_i,
    input  cin_i,
    output sum_o,
    output cout_o,
    output g1_o,
    output p1_o
);
    assign sum_o  = a_i ^ b_i ^ cin_i;

    // cout = a & b | a & cin | b & cin
    // cout = (a&b) | (a|b) & cin
    // cout = g1 | p1 & cin
    assign g1_o   = a_i & b_i;  // generate
    assign p1_o   = a_i | b_i;  // propagate
    assign cout_o = g1_o | p1_o & cin_i;
endmodule



module AdderAhead_1_tb;
    reg  a_i;
    reg  b_i;
    reg  cin_i;
    wire sum_o;
    wire cout_o;
    wire g1_o;
    wire p1_o;

    AdderAhead_1 AA1 (
        .a_i(a_i),
        .b_i(b_i),
        .cin_i(cin_i),
        .sum_o(sum_o),
        .cout_o(cout_o),
        .g1_o(g1_o),
        .p1_o(p1_o)
    );

    initial begin
        #10 begin  // 0+0+0=00
            a_i   = 1'b0;
            b_i   = 1'b0;
            cin_i = 1'b0;
        end

        #10 begin  // 1+0+0=01
            a_i   = 1'b1;
            b_i   = 1'b0;
            cin_i = 1'b0;
        end

        #10 begin  // 0+1+0=01
            a_i   = 1'b0;
            b_i   = 1'b1;
            cin_i = 1'b0;
        end

        #10 begin  // 1+1+0=10
            a_i   = 1'b1;
            b_i   = 1'b1;
            cin_i = 1'b0;
        end

        #10 begin  // 1+1+1=11
            a_i   = 1'b1;
            b_i   = 1'b1;
            cin_i = 1'b1;
        end

        #10 begin
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

endmodule
