module AdderAheadCarry (
    input [3:0] g,  // x & y
    input [3:0] p,  // x | y
    input c_in,
    output [4:1] c_out,
    output g4,
    output p4
);
    assign c_out[1] = g[0] | p[0] & c_in;  // (x & y) | (x | y) & c_in
    assign c_out[2] = g[1] | p[1] & g[0] | p[1] & p[0] & c_in;
    assign c_out[3] = g[2] | p[2] & g[1] | p[2] & p[1] & g[0] | p[2] & p[1] & p[0] & c_in;

    assign g4 = g[3] | p[3] & g[2] | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & g[0];
    assign p4 = p[3] & p[2] & p[1] & p[0];
    assign c_out[4] = g4 | p4 & c_in;
endmodule



module AdderAhead4 (
    input [3:0] x,
    input [3:0] y,
    input c_in,
    output [3:0] sum,
    output c_out,
    output g4,
    output p4
);
    wire [3:0] g;
    wire [3:0] p;
    wire [4:1] c;


    AdderAhead1 u1 (
        .x(x[0]),
        .y(y[0]),
        .c_in(c_in),
        .sum(sum[0]),
        .g(g[0]),
        .p(p[0])
    );
    AdderAhead1 u2 (
        .x(x[1]),
        .y(y[1]),
        .c_in(c[1]),
        .sum(sum[1]),
        .g(g[1]),
        .p(p[1])
    );
    AdderAhead1 u3 (
        .x(x[2]),
        .y(y[2]),
        .c_in(c[2]),
        .sum(sum[2]),
        .g(g[2]),
        .p(p[2])
    );
    AdderAhead1 u4 (
        .x(x[3]),
        .y(y[3]),
        .c_in(c[3]),
        .sum(sum[3]),
        .g(g[3]),
        .p(p[3])
    );
    AdderAheadCarry uut (
        .g(g[3:0]),
        .p(p[3:0]),
        .c_in(c_in),
        .c_out(c[4:1]),
        .g4(g4),
        .p4(p4)
    );
    assign c_out = c[4];
endmodule


module AdderAhead4_tb ();
    reg [3:0] x;
    reg [3:0] y;
    reg c_in;
    wire [3:0] sum;
    wire c_out;
    wire g4;
    wire p4;

    AdderAhead4 uut (
        .x(x),
        .y(y),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out),
        .g4(g4),
        .p4(p4)
    );

    initial begin
        #10 begin
            x = 4'b0000;
            y = 4'b0000;
            c_in = 1'b0;
        end

        #10 begin
            x = 4'b0001;
            y = 4'b0000;
            c_in = 1'b0;
        end

        #10 begin
            x = 4'b0001;
            y = 4'b0001;
            c_in = 1'b0;
        end

        #10 begin
            x = 4'b0001;
            y = 4'b0001;
            c_in = 1'b1;
        end

        #10 begin
            x = 4'b1111;
            y = 4'b1111;
            c_in = 1'b1;
        end

        #10 begin
            x = 4'b1111;
            y = 4'b1111;
            c_in = 1'b0;
        end

        #10 begin

        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
