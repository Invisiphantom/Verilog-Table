module Encode42 (
    input en,
    input [3:0] in,
    output reg [1:0] out
);
    always @(en, in) begin
        if (en) begin
            case (in)
                4'b0001: out = 2'b00;
                4'b0010: out = 2'b01;
                4'b0100: out = 2'b10;
                4'b1000: out = 2'b11;
                default: out = 2'bxx;
            endcase
        end else out = 2'b00;
    end
endmodule

module Encode42_tb;
    reg en;
    reg [3:0] in;
    wire [1:0] out;

    Encode42 DUT (
        .en (en),
        .in (in),
        .out(out)
    );

    initial begin
        #10 begin
            en = 1'b0;
            in = 4'b0000;
        end

        #10 begin
            en = 1'b1;
            in = 4'b0001;
        end

        #10 begin
            en = 1'b1;
            in = 4'b0010;
        end

        #10 begin
            en = 1'b1;
            in = 4'b0100;
        end

        #10 begin
            en = 1'b1;
            in = 4'b1000;
        end

        #10 begin
            en = 1'b1;
            in = 4'b1111;
        end

        #10 begin
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
