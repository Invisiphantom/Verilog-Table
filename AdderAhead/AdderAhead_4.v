module AdderAhead_4 (
    input [3:0] a4_i,
    input [3:0] b4_i,
    input cin_i,
    output [3:0] sum_o,
    output cout_o,
    output g4_o,
    output p4_o
);
    wire [3:0] g_w;
    wire [3:0] p_w;
    wire [3:0] cout_w;
    assign cout_o = cout_w[3];

    AdderAhead_1 AA0 (
        .a_i  (a4_i[0]),
        .b_i  (b4_i[0]),
        .cin_i(cin_i),
        .sum_o(sum_o[0]),
        .g1_o (g_w[0]),
        .p1_o (p_w[0])
    );
    AdderAhead_1 AA1 (
        .a_i  (a4_i[1]),
        .b_i  (b4_i[1]),
        .cin_i(cout_w[0]),
        .sum_o(sum_o[1]),
        .g1_o (g_w[1]),
        .p1_o (p_w[1])
    );
    AdderAhead_1 AA2 (
        .a_i  (a4_i[2]),
        .b_i  (b4_i[2]),
        .cin_i(cout_w[1]),
        .sum_o(sum_o[2]),
        .g1_o (g_w[2]),
        .p1_o (p_w[2])
    );
    AdderAhead_1 AA3 (
        .a_i  (a4_i[3]),
        .b_i  (b4_i[3]),
        .cin_i(cout_w[2]),
        .sum_o(sum_o[3]),
        .g1_o (g_w[3]),
        .p1_o (p_w[3])
    );

    AdderAheadCarry AAC (
        .g_i(g_w[3:0]),
        .p_i(p_w[3:0]),
        .cin_i(cin_i),
        .cout_o(cout_w[3:0]),
        .g4_o(g4_o),
        .p4_o(p4_o)
    );
endmodule



module AdderAhead_4_tb;
    reg [3:0] a4_r;
    reg [3:0] b4_r;
    reg cin_r;
    wire [3:0] sum_w;
    wire cout_w;
    wire g4_w;
    wire p4_w;

    AdderAhead_4 uut (
        .a4_i  (a4_r),
        .b4_i  (b4_r),
        .cin_i (cin_r),
        .sum_o (sum_w),
        .cout_o(cout_w),
        .g4_o  (g4_w),
        .p4_o  (p4_w)
    );

    initial begin
        #10 begin  // 0000+0000+0=0_0000
            a4_r  = 4'b0000;
            b4_r  = 4'b0000;
            cin_r = 1'b0;
        end

        #10 begin  // 0010+0011=0101
            a4_r  = 4'b0010;
            b4_r  = 4'b0011;
            cin_r = 1'b0;
        end

        #10 begin  // 1001+0110+0=0_1111
            a4_r  = 4'b1001;
            b4_r  = 4'b0110;
            cin_r = 1'b0;
        end

        #10 begin  // 1111+1111+1=1_1111
            a4_r  = 4'b1111;
            b4_r  = 4'b1111;
            cin_r = 1'b1;
        end

        #10 begin
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
