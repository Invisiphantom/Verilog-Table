module Div_sign (
    input clk,
    input [7:0] X,
    input [7:0] Y,
    output reg data_ok,
    output reg [7:0] Q_reg,
    output [7:0] R_reg
);
    parameter s0 = 0, s1 = 1, s2 = 2;
    reg [1:0] state;  // 当前状态机状态


    initial begin
        state = 2'b00;
    end

    reg [ 3:0] count;  // 当前计算的位数
    reg [15:0] X_reg;  // 被除数
    reg [15:0] Y_reg;  // 除数
    assign R_reg = X_reg;

    always @(posedge clk) begin
        case (state)
            s0: begin  // 初始化
                count = 0;
                if ($signed(X) < 0) X_reg = {8'b0, (~X + 8'b1)};
                else X_reg = {8'b0, X};
                if ($signed(Y) < 0) Y_reg = {(~Y + 8'b1), 8'b0};
                else Y_reg = {Y, 8'b0};
                Q_reg   = 8'b0;
                data_ok = 0;
                state   = s1;
            end
            s1: begin  // 循环移位相减
                Y_reg = Y_reg >> 1;
                Q_reg = Q_reg << 1;
                if (X_reg >= Y_reg) begin
                    X_reg = X_reg - Y_reg;
                    Q_reg = Q_reg + 1;
                end
                count = count + 1;
                if (count == 4'b1000) begin
                    if (($signed(X) < 0) ^ ($signed(Y) < 0)) begin
                        Q_reg = ~Q_reg + 8'b1;
                        X_reg = ~X_reg + 16'b1;
                    end
                    state   = s2;
                    data_ok = 1;
                end
            end
            s2: begin  // 计算结束
            end
            default: ;
        endcase
    end
endmodule


module Div_tb;
    reg clk;
    reg [7:0] X;
    reg [7:0] Y;
    wire data_ok;
    wire [7:0] Q_reg;
    wire [7:0] R_reg;

    Div_sign uut (
        .clk(clk),
        .X(X),
        .Y(Y),
        .data_ok(data_ok),
        .Q_reg(Q_reg),
        .R_reg(R_reg)
    );

    initial begin
        clk = 1'b0;
        X   = -8;
        Y   = 3;

        for (integer i = 0; i <= 20; i = i + 1) begin
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
