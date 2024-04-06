// https://www.youtube.com/watch?v=tnLKU07b-HA&list=PLBlnK6fEyqRgLLlzdgiTUKULKJPYc0A4q&index=91
module Mult_Booth2 (
    input clk,
    input [65:0] X,  // 66位有符号数
    input [65:0] Y,  // 66位有符号数
    output reg data_ok,
    output [131:0] result  // 132位有符号数
);

    parameter s0 = 0, s1 = 1, s2 = 2;
    reg [1:0] state;  // 当前状态机状态
    reg [6:0] count;  // 当前计算的位数
    reg [65:0] X_neg;  // -X

    reg [65:0] Acc;
    reg [66:0] Y_reg;  // Y[65:-1]
    assign result = {Acc, Y_reg[65:1]};

    initial begin
        state = s0;
    end

    always @(posedge clk) begin
        case (state)
            s0: begin  // 初始化
                count <= 7'b0;  // 从Y[0]开始计算
                X_neg <= -X;
                Acc <= 66'b0;
                Y_reg <= {Y, 1'b0};  // Y[7:-1]
                data_ok <= 1'b0;
                state <= s1;
            end
            s1: begin  // 循环移位相加
                case (Y_reg[1:0])
                    2'b01:   Acc = Acc + X;
                    2'b10:   Acc = Acc + X_neg;
                    default: ;
                endcase
                {Acc, Y_reg} = $signed({Acc, Y_reg}) >>> 1;  // 右移倍数
                count = count + 1;  // 当前计算的位数+1
                if (count == 7'b1000010) state = s2;  // Y[8]无需计算, 直接结束
            end
            s2: begin  // 计算结束
                data_ok <= 1'b1;
            end
            default: ;
        endcase
    end
endmodule


module Mult_Booth2_tb;

    reg clk;
    reg [65:0] X;
    reg [65:0] Y;
    wire data_ok;
    wire [131:0] result;

    Mult_Booth2 uut (
        .clk(clk),
        .X(X),
        .Y(Y),
        .data_ok(data_ok),
        .result(result)
    );

    initial begin
        begin
            clk = 1'b0;
            X   = 66'h3_FFFF_FFFF_FFFF_FFFF;
            Y   = 66'h3_FFFF_FFFF_FFFF_FFFF;
        end

        for (integer i = 0; i <= 100; i = i + 1) begin
            #5;
            clk = 1'b1;

            #5;
            clk = 1'b0;
        end

    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
