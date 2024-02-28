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


    AdderAhead_1 u1 (
        .a_i(a4_i[0]),
        .b_i(b4_i[0]),
        .cin_i(cin_i),
        .sum_o(sum_o[0]),
        .g1_o(g_w[0]),
        .p1_o(p_w[0])
    );
    AdderAhead_1 u2 (
        .a_i(a4_i[1]),
        .b_i(b4_i[1]),
        .cin_i(cout_w[0]),
        .sum_o(sum_o[1]),
        .g1_o(g_w[1]),
        .p1_o(p_w[1])
    );
    AdderAhead_1 u3 (
        .a_i(a4_i[2]),
        .b_i(b4_i[2]),
        .cin_i(cout_w[2]),
        .sum_o(sum_o[2]),
        .g1_o(g_w[2]),
        .p1_o(p_w[2])
    );
    AdderAhead_1 u4 (
        .a_i(a4_i[3]),
        .b_i(b4_i[3]),
        .cin_i(cout_w[3]),
        .sum_o(sum_o[3]),
        .g1_o(g_w[3]),
        .p1_o(p_w[3])
    );
    AdderAheadCarry uut (
        .g1_o(g_w[3:0]),
        .p1_o(p_w[3:0]),
        .cin_i(cin_i),
        .cout_o(cout_w[4:1]),
        .g4_o(g4_o),
        .p4_o(p4_o)
    );
    assign cout_o = cout_w[4];
endmodule


module AdderAhead_4_tb ();
    reg [3:0] a4_i;
    reg [3:0] b4_i;
    reg cin_i;
    wire [3:0] sum_o;
    wire cout_o;
    wire g4_o;
    wire p4_o;

    AdderAhead_4 uut (
        .a_i(a4_i),
        .b_i(b4_i),
        .cin_i(cin_i),
        .sum_o(sum_o),
        .cout_o(cout_o),
        .g4_o(g4_o),
        .p4_o(p4_o)
    );

    initial begin
        #10 begin
            a4_i = 4'b0000;
            b4_i = 4'b0000;
            cin_i = 1'b0;
        end

        #10 begin
            a4_i = 4'b0001;
            b4_i = 4'b0000;
            cin_i = 1'b0;
        end

        #10 begin
            a4_i = 4'b0001;
            b4_i = 4'b0001;
            cin_i = 1'b0;
        end

        #10 begin
            a4_i = 4'b0001;
            b4_i = 4'b0001;
            cin_i = 1'b1;
        end

        #10 begin
            a4_i = 4'b1111;
            b4_i = 4'b1111;
            cin_i = 1'b1;
        end

        #10 begin
            a4_i = 4'b1111;
            b4_i = 4'b1111;
            cin_i = 1'b0;
        end

        #10 begin

        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
