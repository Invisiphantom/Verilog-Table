

module AdderSerial1 (
    input  x,
    input  y,
    input  c_in,
    output sum,
    output c_out
);
    assign sum   = ^{x, y, c_in};
    assign c_out = |{x & y, x & c_in, y & c_in};
    // assign {c_out, sum} = x + y + c_in;
endmodule


module AdderSerial1_tb;
    reg  x;
    reg  y;
    reg  c_in;
    wire sum;
    wire c_out;

    AdderSerial1 AdderSerial1_inst (
        .x(x),
        .y(y),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
    );

    initial begin
        #10 begin
            x    = 1'b0;
            y    = 1'b0;
            c_in = 1'b0;
        end

        #10 begin
            x    = 1'b0;
            y    = 1'b1;
            c_in = 1'b0;
        end

        #10 begin
            x    = 1'b1;
            y    = 1'b0;
            c_in = 1'b0;
        end

        #10 begin
            x    = 1'b1;
            y    = 1'b1;
            c_in = 1'b0;
        end

        #10 begin
            x    = 1'b0;
            y    = 1'b0;
            c_in = 1'b0;
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

endmodule

