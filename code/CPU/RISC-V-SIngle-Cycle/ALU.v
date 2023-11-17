module ALU #(
    parameter Width = 32  // 数据总线宽度
) (
    input      [      3:0] ALU_control,  // ALU控制信号输入
    input      [Width-1:0] A1,           // 第一个操作数输入
    input      [Width-1:0] A2,           // 第二个操作数输入
    output reg [Width-1:0] Y,            // ALU计算结果输出
    output                 zero,         // 是否为0输出
    output reg             s_less,       // 有符号比较结果输出
    output reg             u_less        // 无符号比较结果输出
);
    always @(*) begin
        case (ALU_control)
            4'b0010: Y = A1 + A2;  // add
            4'b0110: Y = A1 - A2;  // sub
            4'b0111: Y = A1 ^ A2;  // xor
            4'b0001: Y = A1 | A2;  // or
            4'b0000: Y = A1 & A2;  // and
            4'b0011: Y = A1 << A2;  // sll
            4'b1000: Y = A1 >> A2;  // srl
            4'b1010: Y = A1 >>> A2;  // sra
            4'b0100: begin  // slt
                if ((~A1 + 1) < (~A2 + 1)) Y = 1;
                else Y = 0;
            end
            4'b0101: begin  // sltu
                if (A1 < A2) Y = 1;
                else Y = 0;
            end
            default: Y = {Width{1'bx}};  // 未知操作码时不输出计算结果
        endcase
    end
    assign zero = (Y == {Width{1'b0}}) ? 1'b1 : 1'b0;  // 判断计算结果是否为0
    always @(A1 or A2) begin
        s_less = ($signed(A1) < $signed(A2)) ? 1 : 0;  // 有符号比较
        u_less = ($unsigned(A1) < $unsigned(A2)) ? 1 : 0;  // 无符号比较
    end
endmodule
