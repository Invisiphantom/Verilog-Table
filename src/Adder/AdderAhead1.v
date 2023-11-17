module AdderAhead1 (
    input  x,
    input  y,
    input  c_in,
    output sum,
    output c_out,
    output g,
    output p
);
    assign sum = x ^ y ^ c_in;
    assign g = x & y; // generate
    assign p = x | y; // propagate
    assign c_out = g | p & c_in; // x & y | x & c_in | y & c_in
endmodule



module AdderAhead1_tb;
  reg  x;
  reg  y;
  reg  c_in;
  wire  sum;
  wire  c_out;
  wire  g;
  wire  p;

  AdderAhead1  AdderAhead1_inst (
    .x(x),
    .y(y),
    .c_in(c_in),
    .sum(sum),
    .c_out(c_out),
    .g(g),
    .p(p)
  );

  initial begin
    #10 begin
        x = 1'b0;
        y = 1'b0;
        c_in = 1'b0;
    end

    #10 begin
        x = 1'b1;
        y = 1'b0;
        c_in = 1'b0;
    end

    #10 begin
        x = 1'b1;
        y = 1'b1;
        c_in = 1'b0;
    end

    #10 begin
        x = 1'b1;
        y = 1'b1;
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