`timescale 1ns / 1ps

module SegDriveTop (
    input             CLK100MHZ,  // 100MHz时钟输入
    input      [15:0] SW,         // 16位开关输入
    output     [15:0] LED,        // 16位LED输出
    output     [ 6:0] A2G,        // 7段数码管段选输出
    output     [ 7:0] AN,         // 7段数码管位选输出
    output reg        LED16_B,
    output reg        LED16_G,
    output reg        LED16_R,
    output reg        LED17_B,
    output reg        LED17_G,
    output reg        LED17_R
);
    wire timeSel_12Hz, timeSel_6Hz, timeSel_3Hz, timeSel_1_5Hz;  // 时间选择信号    
    reg [25:0] clkCount;  // 时钟计数器
    always @(posedge CLK100MHZ)  // 时钟上升沿触发
        clkCount <= clkCount + 1;  // 计数器加1
    assign timeSel_12Hz = clkCount[22];  // 时钟频率11.92Hz
    assign timeSel_6Hz  = clkCount[23];  // 时钟频率5.96Hz
    assign timeSel_3Hz  = clkCount[24];  // 时钟频率2.98Hz
    assign timeSel_1_5Hz= clkCount[25];  // 时钟频率1.49Hz


    reg [2:0] state;  // 状态机状态
    always @(posedge timeSel_1_5Hz) begin
        case (state)
            0: state <= 1;
            1: state <= 2;
            2: state <= 3;
            3: state <= 4;
            4: state <= 5;
            5: state <= 0;
            default: state <= 0;
        endcase
    end

    reg en_RED, en_BLUE;
    always @(state) begin
        case (state)
            0: begin
                en_RED  = 1;
                en_BLUE = 0;
            end
            1: begin
                en_RED  = 0;
                en_BLUE = 1;
            end
            2: begin
                en_RED  = 1;
                en_BLUE = 0;
            end
            3: begin
                en_RED  = 0;
                en_BLUE = 1;
            end
            4: begin
                en_RED  = 1;
                en_BLUE = 1;
            end
            5: begin
                en_RED  = 1;
                en_BLUE = 1;
            end
            default: begin
                en_RED  = 0;
                en_BLUE = 0;
            end
        endcase
    end


    always @(posedge timeSel_12Hz) begin
        if (en_RED == 1'b1) LED17_R = ~LED17_R;
        else LED17_R = 1'b0;
        if (en_BLUE == 1'b1) LED16_B = ~LED16_B;
        else LED16_B = 1'b0;
    end


    wire [ 7:0] en;  // 8位数码管使能信号
    reg  [39:0] key;  // 40位数码管键值
    assign en[7:0] = 8'b0000_0000;

    X7Seg u_X7Seg (
        .clk(CLK100MHZ),
        .clr(1'b0),
        .en (en),
        .key(key),
        .AN (AN),
        .A2G(A2G)
    );
endmodule
