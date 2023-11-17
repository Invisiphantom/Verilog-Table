module Decode #(
    parameter LEN = 2
) (
    input en,
    input [LEN - 1:0] in,
    output reg [(1 << LEN) - 1:0] out
);
    integer i;
    always @(en, in) begin
        if (en) begin
            for (i = 0; i <= (1 << LEN) - 1; i = i + 1) begin
                if (in == i) out[i] = 1'b1;
                else out[i] = 1'b0;
            end
        end else out = {(1 << LEN) {1'b0}};
    end
endmodule


