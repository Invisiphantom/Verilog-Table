`timescale 1ns / 1ps

module X7Seg (
    input             clk,    // 时钟信号
    input             clr,    // 清零信号
    input      [ 7:0] en,     // 使能信号
    input      [39:0] key,    // 数字信号
    output reg [ 7:0] AN,     // 数码管阳极信号
    output     [ 6:0] A2G     // 数码管阴极信号
);

    wire [ 2:0] timeSel;       // 时间选择信号
    reg  [ 4:0] numShow;       // 数字显示信号
    reg  [19:0] clkCount;      // 时钟计数器

    always @(posedge clk, posedge clr)  // 时钟上升沿和清零信号触发
        if (clr == 1) clkCount <= 0;    // 清零计数器
        else clkCount <= clkCount + 1;  // 计数器加1

    assign timeSel[2:0] = clkCount[19:17];  // 每10.4ms将timeSel的值从0-7循环
    always @(timeSel) begin                 // 时间选择信号变化时触发
        case (timeSel)
            0:
            if (en[0] == 1) begin          // 如果数码管0的使能信号为1
                AN <= 8'b1111_1110;        // 则此时只启动数码管0
                numShow <= key[4:0];       // 将数字显示信号设置为为key的低5位
            end else AN <= 8'b1111_1111;   // 否则此时不启动任何数码管
            1:
            if (en[1] == 1) begin          // 如果数码管1的使能信号为1
                AN <= 8'b1111_1101;        // 则此时只启动数码管1
                numShow <= key[9:5];       // 将数字显示信号设置为为key的第5~9位
            end else AN <= 8'b1111_1111;   // 否则此时不启动任何数码管
            2:
            if (en[2] == 1) begin          // 如果数码管2的使能信号为1
                AN <= 8'b1111_1011;        // 则此时只启动数码管2
                numShow <= key[14:10];     // 将数字显示信号设置为为key的第10~14位
            end else AN <= 8'b1111_1111;   // 否则此时不启动任何数码管
            3:
            if (en[3] == 1) begin          // 如果数码管3的使能信号为1
                AN <= 8'b1111_0111;        // 则此时只启动数码管3
                numShow <= key[19:15];     // 将数字显示信号设置为为key的第15~19位
            end else AN <= 8'b1111_1111;   // 否则此时不启动任何数码管
            4:
            if (en[4] == 1) begin          // 如果数码管4的使能信号为1
                AN <= 8'b1110_1111;        // 则此时只启动数码管4
                numShow <= key[24:20];     // 将数字显示信号设置为为key的第20~24位
            end else AN <= 8'b1111_1111;   // 否则此时不启动任何数码管
            5:
            if (en[5] == 1) begin          // 如果数码管5的使能信号为1
                AN <= 8'b1101_1111;        // 则此时只启动数码管5
                numShow <= key[29:25];     // 将数字显示信号设置为为key的第25~29位
            end else AN <= 8'b1111_1111;   // 否则此时不启动任何数码管
            6:
            if (en[6] == 1) begin          // 如果数码管6的使能信号为1
                AN <= 8'b1011_1111;        // 则此时只启动数码管6
                numShow <= key[34:30];     // 将数字显示信号设置为为key的第30~34位
            end else AN <= 8'b1111_1111;   // 否则此时不启动任何数码管
            7:
            if (en[7] == 1) begin          // 如果数码管7的使能信号为1
                AN <= 8'b0111_1111;        // 则此时只启动数码管7
                numShow <= key[39:35];     // 将数字显示信号设置为为key的第35~39位
            end else AN <= 8'b1111_1111;   // 否则此时不启动任何数码管
            default:
            begin                          // 默认情况下不启动任何数码管
                AN <= 8'b1111_1111;        // 所有数码管全部关闭
                numShow <= 5'b00000;       // 数字显示信号为0
            end
        endcase
    end

    Hex7Seg u_Hex7Seg (                   // 数码管阴极信号转换模块
        .key(numShow),                    // 输入数字显示信号
        .A2G(A2G)                         // 输出数码管阴极信号
    );
endmodule