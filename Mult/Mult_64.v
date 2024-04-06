module Mult_64 (
    input clk,
    input [63:0] x,
    input [63:0] y,
    output reg data_ok,
    output reg [127:0] result
);
    parameter s0 = 0, s1 = 1, s2 = 2;
    reg [  1:0] state;  // 当前状态机状态
    reg [  6:0] count;  // 当前计算的位数
    reg [127:0] x_reg;  // 左移被乘数
    reg [ 63:0] y_reg;  // 倍数 (1|0)

    initial begin
        state = s0;
    end

    always @(posedge clk) begin
        case (state)
            s0: begin  // 初始化
                count   <= 7'b0;  // 从y_reg[0]开始计算
                data_ok <= 1'b0;
                result  <= 128'b0;
                x_reg   <= {{64{1'b0}}, x}; // 无符号乘法
                y_reg   <= y;
                state   <= s1;
            end
            s1: begin  // 循环移位相加
                if (count == 7'b1000000) state <= s2;  // y_reg[64]无需计算, 直接结束
                else begin
                    result <= result + (y_reg[0] == 1'b1 ? x_reg : 0);
                    y_reg  <= y_reg >> 1;  // 右移倍数
                    x_reg  <= x_reg << 1;  // 左移被乘数
                    count  <= count + 1;  // 当前计算位数+1
                    state  <= s1;  // 继续循环
                end
            end
            s2: begin  // 计算结束
                data_ok <= 1'b1;
            end
            default: ;
        endcase
    end
endmodule




module mult64_tb;
    reg clk;
    reg [63:0] x;
    reg [63:0] y;
    wire data_ok;
    wire [127:0] result;

    Mult_64 uut (
        .clk(clk),
        .x(x),
        .y(y),
        .data_ok(data_ok),
        .result(result)
    );

    initial begin
        clk = 1'b0;
        x   = 64'hffff_ffff_ffff_ffff;
        y   = 64'hffff_ffff_ffff_ffff;

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
