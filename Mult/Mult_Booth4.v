module Mult_Booth4 (
    input clk,
    input [65:0] X,
    input [65:0] Y,
    output reg data_ok,
    output [131:0] aluResult
);

    parameter s0 = 0, s1 = 1;
    reg state;  // 当前状态机状态
    reg [6:0] count;  // 当前处于的位数
    reg [65:0] X_n;  // -X
    reg [65:0] X_2;  // X << 1
    reg [65:0] X_2n;  // -X << 1

    reg [65:0] Acc;
    reg [66:0] Y_reg;  // Y[65:-1]
    assign aluResult = {Acc, Y_reg[66:1]};

    initial begin
        state = s0;
    end

    always @(posedge clk) begin
        case (state)
            s0: begin  // 初始化
                count = 7'b0;  // 从Y[0]开始计算
                X_n = -X;
                X_2 = X << 1;
                X_2n = (-X) << 1;

                Acc = 66'b0;
                Y_reg = {Y, 1'b0};  // Y[65:-1]
                data_ok = 1'b0;
                state = s1;
            end
            s1: begin  // 循环移位相加
                case (Y_reg[2:0])
                    3'b001:  Acc = Acc + X;
                    3'b010:  Acc = Acc + X;
                    3'b011:  Acc = Acc + X_2;
                    3'b101:  Acc = Acc + X_n;
                    3'b110:  Acc = Acc + X_n;
                    3'b100:  Acc = Acc + X_2n;
                    default: ;
                endcase
                {Acc, Y_reg} = $signed({Acc, Y_reg}) >>> 2;  // 右移倍数
                count = count + 2;  // 当前计算的位数+2
                if (count == 7'b1000010) begin
                    data_ok = 1'b1;  // Y[8]无需计算, 直接结束
                    state   = 1'bx;
                end
            end
            default: ;
        endcase
    end
endmodule


module Mult_Booth4_tb;

    reg clk;
    reg [65:0] X;
    reg [65:0] Y;
    wire data_ok;
    wire [131:0] aluResult;

    Mult_Booth4 uut (
        .clk(clk),
        .X(X),
        .Y(Y),
        .data_ok(data_ok),
        .aluResult(aluResult)
    );

    initial begin
        begin
            clk  = 1'b0;
            X = 66'h3_FFFF_FFFF_FFFF_FFFF;
            Y = 66'h3_FFFF_FFFF_FFFF_FFFF;
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
