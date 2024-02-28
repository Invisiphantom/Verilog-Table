module Mux41 (
    input [3:0] data,
    input [1:0] key,
    output reg out
);
    always @(key or data)
        case (key)
            2'b00:   out = data[0];
            2'b01:   out = data[1];
            2'b10:   out = data[2];
            2'b11:   out = data[3];
            default: out = 1'b0;
        endcase
endmodule


module Mux41_tb;
    reg [3:0] data;
    reg [1:0] key;
    wire out;

    Mux41 uut (
        .data(data),
        .key (key),
        .out (out)
    );

    initial begin
        #10 begin
            data = 4'b0000;
            key  = 2'b00;
        end

        #10 begin
            data = 4'b0001;
            key  = 2'b00;
        end

        #10 begin
            data = 4'b0010;
            key  = 2'b01;
        end

        #10 begin
            data = 4'b0100;
            key  = 2'b10;
        end

        #10 begin
            data = 4'b1000;
            key  = 2'b11;
        end

        #10 begin
            data = 4'b0111;
            key  = 2'b11;
        end

        #10 begin

        end
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
