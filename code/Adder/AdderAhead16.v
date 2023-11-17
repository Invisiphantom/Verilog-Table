module AdderAhead16 (
    input [15:0] x,
    input [15:0] y,
    input c_in,
    output [15:0] sum,
    output c_out,
    output g16,
    output p16
);
    wire [3:0] g;
    wire [3:0] p;
    wire [4:1] c;


    AdderAhead4 A0 (
        .x(x[3:0]),
        .y(y[3:0]),
        .c_in(c_in),
        .sum(sum[3:0]),
        .g4(g[0]),
        .p4(p[0])
    );
    AdderAhead4 A1 (
        .x(x[7:4]),
        .y(y[7:4]),
        .c_in(c[1]),
        .sum(sum[7:4]),
        .g4(g[1]),
        .p4(p[1])
    );
    AdderAhead4 A3 (
        .x(x[11:8]),
        .y(y[11:8]),
        .c_in(c[2]),
        .sum(sum[11:8]),
        .g4(g[2]),
        .p4(p[2])
    );
    AdderAhead4 A4 (
        .x(x[15:12]),
        .y(y[15:12]),
        .c_in(c[3]),
        .sum(sum[15:12]),
        .g4(g[3]),
        .p4(p[3])
    );
    AdderAheadCarry AAt (
        .p(p[3:0]),
        .g(g[3:0]),
        .c_in(c_in),
        .c_out(c[4:1]),
        .g4(g16),
        .p4(p16)
    );
    assign c_out = c[4];
endmodule



module AdderAhead16_tb;
    reg [15:0] x;
    reg [15:0] y;
    reg c_in;
    wire [15:0] sum;
    wire c_out;
    wire g16;
    wire p16;

    AdderAhead16 AdderAhead16_inst (
        .x(x),
        .y(y),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out),
        .g16(g16),
        .p16(p16)
    );

    initial begin
        #10 begin
            x = 16'b0000000000000000;
            y = 16'b0000000000000000;
            c_in = 1'b0;
        end

        #10 begin
            x = 16'b0000000000000001;
            y = 16'b0000000000000000;
            c_in = 1'b0;
        end

        #10 begin
            x = 16'b0000000000000001;
            y = 16'b0000000000000001;
            c_in = 1'b0;
        end

        #10 begin
            x = 16'b0000000000000001;
            y = 16'b0000000000000001;
            c_in = 1'b1;
        end

        #10 begin
            x = 16'b0000000000000001;
            y = 16'b1111111111111111;
            c_in = 1'b1;
        end

        #10 begin
            x = 16'b1111111111111111;
            y = 16'b1111111111111111;
            c_in = 1'b1;
        end

        #10 begin
            x = 16'b1111111111111111;
            y = 16'b1111111111111111;
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
