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
        end else out = 4'b0000;
    end
endmodule


module Decode24_tb;
    reg en_r;
    reg [1:0] in_r;
    wire [3:0] out_w;

    Decode24 uut (
        .en (en_r),
        .in (in_r),
        .out(out_w)
    );

    initial begin
        #10 begin
            en_r = 1'b0;
            in_r = 2'b00;
        end

        #10 begin
            en_r = 1'b1;
            in_r = 2'b00;
        end

        #10 begin
            en_r = 1'b1;
            in_r = 2'b01;
        end

        #10 begin
            en_r = 1'b1;
            in_r = 2'b10;
        end

        #10 begin
            en_r = 1'b1;
            in_r = 2'b11;
        end

        #10 begin

        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
