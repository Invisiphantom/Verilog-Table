module Encode #(
    parameter LEN = 2
) (
    input en,
    input [(1 << LEN) - 1:0] in,
    output reg [LEN -1:0] out
);
    integer i;
    always @(en, in) begin
        if (en) begin
            out = 0;
            for (i = 0; i <= (1 << LEN) - 1; i = i + 1) begin
                if (in[i] == 1) out = i;
            end
        end else out = 0;
    end
endmodule
