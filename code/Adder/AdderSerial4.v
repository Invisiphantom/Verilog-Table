module AdderSerial4 (
    input [3:0] x,
    input [3:0] y,
    input c_in,
    output [3:0] sum,
    output c_out
);
    wire [4:0] c;
    assign c[0] = c_in;
    genvar i;
    generate
        for (i = 0; i <= 3; i = i + 1) begin
            AdderSerial1 u_AdderSerial1 (
                .x    (x[i]),
                .y    (y[i]),
                .c_in (c[i]),
                .sum  (sum[i]),
                .c_out(c[i+1])
            );
        end
    endgenerate
    assign c_out = c[4];
endmodule



module AdderSerial4_tb;
    reg [3:0] x;
    reg [3:0] y;
    reg c_in;
    wire [3:0] sum;
    wire c_out;

    AdderSerial4 AdderSerial4_inst (
        .x(x),
        .y(y),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
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
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

endmodule
