module Decode24 (
    input en,
    input [1:0] in,
    output reg [3:0] out
);
    always @(en, in) begin
        if (en) begin
            case (in)
                2'b00:   out = 4'b0001;
                2'b01:   out = 4'b0010;
                2'b10:   out = 4'b0100;
                2'b11:   out = 4'b1000;
                default: out = 4'bxxxx;
            endcase
        end
        else out = 4'b0000;
    end
endmodule
